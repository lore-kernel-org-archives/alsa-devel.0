From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/11] ASoC: rt5651: Fix bias_level
 confusion / overcurrent detection deps
Date: Wed, 21 Feb 2018 20:43:47 +0100
Message-ID: <361a97ba-4af8-8a99-f092-4c63c5570348@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-3-hdegoede@redhat.com>
 <20180221114045.GB8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com
 [209.85.128.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 079E126762C
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 20:43:49 +0100 (CET)
Received: by mail-wr0-f182.google.com with SMTP id o76so7750801wrb.7
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 11:43:49 -0800 (PST)
In-Reply-To: <20180221114045.GB8334@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 21-02-18 12:40, Mark Brown wrote:
> On Tue, Feb 20, 2018 at 11:15:03PM +0100, Hans de Goede wrote:
>> Overcurrent detection (ovcd) requires the following to be on:
>> 1) The LDO supply
>> 2) The micbias1 supply
>> 3) General analog voltages such as vref aka a bias_level of standby
>>
>> Before this commit deps 2. and 3. were not met (unless a stream recording
>> from the mic was active).
> 
> What does the overcurrent detection detect overcurrent on?

On the micbias current, which is why we need the micbias1 supply on
to do OVCD, which we use to determine if we've a headset (speakers
+ microphone) or headphones (speakers only, mic contact shorted to
ground) plugged in.

>> 3. Is not met because rt5651_set_bias_level() was only enabling this when
>> reaching a bias level of prepared instead of doing this in the normal
>> standby bias level, which the dapm core will select as soon as any pins /
>> supplies are on. This commit fixes by making rt5651_set_bias_level() behave
>> as a normal set_bias function for other codecs and already enabling these
>> things at standby level.
> 
> ...
> 
>> 2. is fixed by simply force-enabling "micbias1" when doing ovcd, this
>> commit also adds code to turn both the micbias1 and the LDO supplies of
>> again when we're done, note they will only really get turned off if the
>> ovcd was the only user.
>>
>> The snd_soc_codec_force_bias_level(BIAS_OFF) call done in rt5651_probe()
>> will now turn off PWR_ANLG1, so the programming of PWR_ANLG1 before the
>> snd_soc_codec_force_bias_level() now is a no-op and can be removed.
> 
> This is two or three changes combined into a single commit which makes
> it harder to review :(

I can split this up, but I cannot guarantee then that there will not
be a state between 1 of the commits where OVCD is not even more broken
then before.

>> @@ -1811,8 +1795,11 @@ static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
>>   	int jack_type;
>>   
>>   	if (jack_insert) {
>> -		snd_soc_dapm_force_enable_pin(dapm, "LDO");
>> -		snd_soc_dapm_sync(dapm);
>> +		snd_soc_dapm_mutex_lock(dapm);
>> +		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
>> +		snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
>> +		snd_soc_dapm_sync_unlocked(dapm);
>> +		snd_soc_dapm_mutex_unlock(dapm);
>>   
>>   		snd_soc_update_bits(codec, RT5651_MICBIAS,
>>   				    RT5651_MIC1_OVCD_MASK |
> 
> This is now only enabling the LDO and bias when the jack is inserted -
> is that enough?

Yes, we only need to do OVCD on an insertion event to differ between
headset vs headphones.

Regards,

Hans
