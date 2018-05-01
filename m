From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 03/13] ALSA: dice: add proc node for
	stream formation
Date: Tue, 1 May 2018 12:06:05 +0900
Message-ID: <e8f6fa14-b6bb-4265-cfe5-ccf75ada5718@sakamocchi.jp>
References: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
 <20180429065032.13869-4-o-takashi@sakamocchi.jp>
 <s5h6048enj7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E069226766E
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 05:06:08 +0200 (CEST)
In-Reply-To: <s5h6048enj7.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

On May 1 2018 00:12, Takashi Iwai wrote:
> On Sun, 29 Apr 2018 08:50:22 +0200,
> Takashi Sakamoto wrote:
>>
>> Products with DICE interface in market can support variable stream
>> formats for three levels of sampling transmission frequencies. To
>> record these formats, a proxy structure got several fields in former
>> commit.
>>
>> This commit adds a proc node to output the stream formats for debugging
>> purpose.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   sound/firewire/dice/dice-proc.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
>> index 43b130b7aa07..f967e0ec7598 100644
>> --- a/sound/firewire/dice/dice-proc.c
>> +++ b/sound/firewire/dice/dice-proc.c
>> @@ -243,6 +243,40 @@ static void dice_proc_read(struct snd_info_entry *entry,
>>   	}
>>   }
>>   
>> +static void dice_proc_read_formation(struct snd_info_entry *entry,
>> +				     struct snd_info_buffer *buffer)
>> +{
>> +	static const char *const rate_labels[] = {
>> +		[0] = "low",
>> +		[1] = "middle",
>> +		[2] = "high",
>> +	};
> 
> This doesn't look smart :)
> 
> How about defining these three numbers as constants (or macros)?
> Also the magic number 3 appearing everywhere can be defined properly,
> too.

Indeed. I was a bit rude. I'm OK to utilize constants for this purpose.


Thanks

Takashi Sakamoto
