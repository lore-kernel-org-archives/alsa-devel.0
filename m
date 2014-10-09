From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: rt5677: make volume TLV closer to
	reality
Date: Thu, 9 Oct 2014 15:10:44 -0700
Message-ID: <CAEUnVG6QLdukNnDRQmWdVoJa0qnkf1=j9bFOZX_2R66LhWDHfA@mail.gmail.com>
References: <1412888409-4650-1-git-send-email-dgreid@chromium.org>
 <s5hvbnszzbr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 21BA4260434
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 00:11:05 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id h136so4564513oig.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2014 15:11:05 -0700 (PDT)
In-Reply-To: <s5hvbnszzbr.wl-tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, benzh@chromium.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, anatol.pomozov@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 9, 2014 at 2:51 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu,  9 Oct 2014 14:00:09 -0700,
> Dylan Reid wrote:
>>
>> The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
>> units.  Approximate 0.375 as 0.37.  It leaves the minimum value off by
>> 1.15dB, but that is better than being off by ~500 as it was with 37.5
>> as the step.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>> Just a suggestion.  It seems to me to be the lesser of two evils.
>> This probably won't be the last codec that has a higher resolution
>> than 0.01dB, should we come up with a way to express that?
>
> How about using TLV_DB_MINMAX instead?

That sounds like the right idea.  It'll only be off by 0.005dB.  I'll
replace this change with that one.

Thanks!

-dg

>
>
> Takashi
>
>> ---
>>  sound/soc/codecs/rt5677.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
>> index 16aa4d9..f139d5a 100644
>> --- a/sound/soc/codecs/rt5677.c
>> +++ b/sound/soc/codecs/rt5677.c
>> @@ -538,9 +538,11 @@ static bool rt5677_readable_register(struct device *dev, unsigned int reg)
>>  }
>>
>>  static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
>> -static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
>> +/* Actual min=-65.625dB and step=0.375dB but only have 0.01 resolution. */
>> +static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6475, 37, 0);
>>  static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
>> -static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
>> +/* Actual min=-17.625dB and step=0.375dB but only have 0.01 resolution. */
>> +static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1739, 37, 0);
>>  static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
>>  static const DECLARE_TLV_DB_SCALE(st_vol_tlv, -4650, 150, 0);
>>
>> --
>> 2.1.2.330.g565301e
>>
