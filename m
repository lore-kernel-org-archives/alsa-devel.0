From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 04/13] ALSA: dice: cache stream formats
 at current mode of sampling transmission frequency
Date: Tue, 1 May 2018 12:02:09 +0900
Message-ID: <2a3d530a-5a03-0760-21b5-6e74fd2503e5@sakamocchi.jp>
References: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
 <20180429065032.13869-5-o-takashi@sakamocchi.jp>
 <s5h7eooenmy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 755D926762F
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 05:02:12 +0200 (CEST)
In-Reply-To: <s5h7eooenmy.wl-tiwai@suse.de>
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

On May 1 2018 00:10, Takashi Iwai wrote:
> On Sun, 29 Apr 2018 08:50:23 +0200,
> Takashi Sakamoto wrote:
>>
>> In former commits, proxy structure get members for cache of stream
>> formats. This commit fills the cache with stream formats at current mode
>> of sampling transmission frequency.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   sound/firewire/dice/dice-stream.c | 76 +++++++++++++++++++++++++++++++++++++++
>>   sound/firewire/dice/dice.c        |  4 +++
>>   sound/firewire/dice/dice.h        |  3 ++
>>   3 files changed, 83 insertions(+)
>>
>> diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
>> index 928a255bfc35..2a9f0cd994a5 100644
>> --- a/sound/firewire/dice/dice-stream.c
>> +++ b/sound/firewire/dice/dice-stream.c
>> @@ -30,6 +30,24 @@ const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
>>   	[6] = 192000,
>>   };
>>   
>> +int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
>> +				  unsigned int *mode)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); i++) {
>> +		if (!(dice->clock_caps & BIT(i)))
>> +			continue;
>> +		if (snd_dice_rates[i] != rate)
>> +			continue;
>> +
>> +		*mode = (i - 1) / 2;
> 
> What if i=0?  It'll be a negative value?

Yes. But division by 2 to -1 results in 0 because in C language 
specification 'truncate toward zero'[1] is applied to discard
fractional part. Then, the result is assigned to value of 'unsigned int'
type. As a result:

0: 32000/44100/48000
1: 88200/96000
2: 176400/192000

This is what I expect.

[1] footnote for '6.5.5 Multiplicative operators' clause in ISO/IEC 9899.


Thanks

Takashi Sakamoto
