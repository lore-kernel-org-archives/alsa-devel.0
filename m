From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/3] ALSA: hda - jack poll once if
	jackpoll_interval==0
Date: Wed, 24 Jul 2013 12:31:51 +0200
Message-ID: <51EFAD17.3060502@canonical.com>
References: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5h7gggp8wz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F04AF26530A
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 12:31:52 +0200 (CEST)
In-Reply-To: <s5h7gggp8wz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On 07/24/2013 12:08 PM, Takashi Iwai wrote:
> At Mon, 22 Jul 2013 03:19:16 -0400,
> Wang Xingchao wrote:
>>
>> jackpoll_interval used to poll jack event periodically, if it's 0,
>> give the caller one chance to probe jack status.
>
> Why?  I miss the background...
>
> jackpoll_interval=0 means that the polling is disabled.  So, there
> should be no polling at all.

I wondered that too, but figured it's to make the next patch work. I 
asked why one couldn't just call snd_hda_jack_set_dirty/poll_all from 
runtime_resume, but xingchao said it lead to a loop of some sort.

Reference: 
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/064348.html

>
>
> Takashi
>
>> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
>> ---
>>   sound/pci/hda/hda_codec.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index 8a005f0..74c11bc 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -1216,11 +1216,12 @@ static void hda_jackpoll_work(struct work_struct *work)
>>   {
>>   	struct hda_codec *codec =
>>   		container_of(work, struct hda_codec, jackpoll_work.work);
>> -	if (!codec->jackpoll_interval)
>> -		return;
>>
>>   	snd_hda_jack_set_dirty_all(codec);
>>   	snd_hda_jack_poll_all(codec);
>> +	if (!codec->jackpoll_interval)
>> +		return;
>> +
>>   	queue_delayed_work(codec->bus->workq, &codec->jackpoll_work,
>>   			   codec->jackpoll_interval);
>>   }
>> --
>> 1.8.3.2
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
