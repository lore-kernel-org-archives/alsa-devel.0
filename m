From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: fireworks/bebob: fix refering to
 released resources at unplugging
Date: Wed, 21 Jan 2015 18:01:47 +0900
Message-ID: <54BF6AFB.2070806@sakamocchi.jp>
References: <1421795250-7528-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7fwgwqwb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 45EC626059D
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 10:01:49 +0100 (CET)
In-Reply-To: <s5h7fwgwqwb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Jan 21 2015 16:10, Takashi Iwai wrote:
> At Wed, 21 Jan 2015 08:07:30 +0900,
> Takashi Sakamoto wrote:
>>
>> Unplugging devices can cause disorder by releasing streaming resources
>> before stopping playbacking/capturing substreams. This commit forces
>> the state of ALSA character devices into disconnect before releasing
>> the resources.
>
> This isn't enough, unfortunately.  snd_card_disconnect() itself
> doesn't sync, merely disconnects and stops the streams, etc, thus the
> file handles may be still opened.

Oh, exactly. As you said, the drivers can't force applications to call 
snd_pcm_close() even if calling snd_card_disconnect(). As a result, any 
AMDTP streams are still running.

> In general, releasing the resources should be done in either in card's
> private_free or snd_device's free callback where all files have been
> already released.  For example, bebob_remove() should just call
> snd_card_free_when_closed() (that invokes snd_card_disconnect()
> internally) and call the reset (kfree() and *_destroy()) in a card's
> free callback.

Thanks for your indication. I should move these releasing code to 
.private_free callback.

Currently I'm bothered by these drivers about kernel oops at unplugging 
during playbacking/capturing (not always). I guess:
  1. unplugging.
  2. isochronous communications stops, then the drivers detect packet 
discontinuity and set XRUN state to PCM substream immediately.
  3. PCM applications call .prepare to recover XRUN state.
  4. these drivers try transactions in .prepare
  5. (Asynchronously) xxx_remove() is called by bus driver and release 
stream/transaction resources
  6. the trial of transaction causes oops.

This patch is not a better solution to this, too. Please abandon it...


Thanks

Takashi Sakamoto

>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   sound/firewire/bebob/bebob.c         | 3 ++-
>>   sound/firewire/fireworks/fireworks.c | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
>> index fc19c99..41eb1ce 100644
>> --- a/sound/firewire/bebob/bebob.c
>> +++ b/sound/firewire/bebob/bebob.c
>> @@ -306,10 +306,11 @@ static void bebob_remove(struct fw_unit *unit)
>>   	if (bebob == NULL)
>>   		return;
>>
>> +	snd_card_disconnect(bebob->card);
>> +
>>   	kfree(bebob->maudio_special_quirk);
>>
>>   	snd_bebob_stream_destroy_duplex(bebob);
>> -	snd_card_disconnect(bebob->card);
>>   	snd_card_free_when_closed(bebob->card);
>>   }
>>
>> diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
>> index 3e2ed8e..21fb50f 100644
>> --- a/sound/firewire/fireworks/fireworks.c
>> +++ b/sound/firewire/fireworks/fireworks.c
>> @@ -289,10 +289,11 @@ static void efw_remove(struct fw_unit *unit)
>>   {
>>   	struct snd_efw *efw = dev_get_drvdata(&unit->device);
>>
>> +	snd_card_disconnect(efw->card);
>> +
>>   	snd_efw_stream_destroy_duplex(efw);
>>   	snd_efw_transaction_remove_instance(efw);
>>
>> -	snd_card_disconnect(efw->card);
>>   	snd_card_free_when_closed(efw->card);
>>   }
>>
>> --
>> 2.1.0
