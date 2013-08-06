From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Tue, 06 Aug 2013 13:31:04 +0200
Message-ID: <5200DE78.5060409@metafoo.de>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk> <51FFDF11.5020106@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E0E@rtitmbs7.realtek.com.tw>
 <5200B7B5.7050506@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
 <5200C369.6050607@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E62@rtitmbs7.realtek.com.tw>
 <5200CD0D.7030007@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CC4526535B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 13:30:49 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/06/2013 01:04 PM, Bard Liao wrote:
>> -----Original Message-----
>> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
>> Sent: Tuesday, August 06, 2013 6:17 PM
>> To: Bard Liao
>> Cc: Mark Brown; Oder Chiou; alsa-devel@alsa-project.org;
>> swarren@nvidia.com; swarren@wwwdotorg.org; lgirdwood@gmail.com; Flove
>> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: change
>> widgetsequencefordepop
>>
>> On 08/06/2013 12:07 PM, Bard Liao wrote:
>>>> -----Original Message-----
>>>> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
>>>> Sent: Tuesday, August 06, 2013 5:36 PM
>>>> To: Bard Liao
>>>> Cc: Mark Brown; Oder Chiou; alsa-devel@alsa-project.org;
>>>> swarren@nvidia.com; swarren@wwwdotorg.org; lgirdwood@gmail.com;
>> Flove
>>>> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: change
>>>> widgetsequencefordepop
>>>>
>>>> On 08/06/2013 11:13 AM, Bard Liao wrote:
>>>>>>> I think I need to use SND_SOC_DAPM_SWITCH with
>>>>>> SOC_DAPM_SINGLE_AUTODISABLE for this control.
>>>>>>> Am I right?
>>>>>>> I am trying to do that, but meet a problem.
>>>>>>> If I set speaker switch unmute before playing music, dapm will
>>>>>>> mute it
>>>>>> automatically in power on sequence.
>>>>>>> The only way I can unmute speaker is set speaker switch unmute
>>>>>>> while
>>>>>> playing music.
>>>>>>
>>>>>> DAPM should unmute the switch on power up and mute it on power
>> down.
>>>>>> The Speaker Channel Switch control has the invert flag set did you
>>>>>> also set the invert flag for the new autodisable control?
>>>>>
>>>>> Yes, the related code is as below.
>>>>> static const struct snd_kcontrol_new spk_l_enable_control =
>>>>> 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5640_SPK_VOL,
>>>>> 		RT5640_L_MUTE_SFT, 1, 1);
>>>>>
>>>>> static const struct snd_kcontrol_new spk_r_enable_control =
>>>>> 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5640_SPK_VOL,
>>>>> 		RT5640_R_MUTE_SFT, 1, 1);
>>>>>
>>>>> 	SND_SOC_DAPM_SWITCH("Speaker L Playback", SND_SOC_NOPM, 0,
>> 0,
>>>>> 			&spk_l_enable_control),
>>>>> 	SND_SOC_DAPM_SWITCH("Speaker R Playback", SND_SOC_NOPM,
>> 0, 0,
>>>>> 			&spk_r_enable_control),
>>>>
>>>> Looks good. Maybe I got the invert = 1 case wrong somewhere. Can you
>>>> add a couple of printks and send me the result?
>>>
>>> The result is as below.
>>>
>>> [    9.418738] new control: Speaker R Playback Switch 1
>>> [    9.423949] new control: Speaker L Playback Switch 1
>>>
>>> root@tegra-ubuntu:/home/ubuntu# amixer cset name="Speaker L Playback
>>> Switch" 0 numid=25,iface=MIXER,name='Speaker L Playback Switch'
>>>     ; type=BOOLEAN,access=rw------,values=1
>>>     : values=off
>>> root@tegra-ubuntu:/home/ubuntu# dmesg -c [  163.717158] Speaker L
>>> Playback Switch->on_val = 1 root@tegra-ubuntu:/home/ubuntu#
>>> root@tegra-ubuntu:/home/ubuntu# amixer cset name="Speaker L Playback
>>> Switch" 1 numid=25,iface=MIXER,name='Speaker L Playback Switch'
>>>     ; type=BOOLEAN,access=rw------,values=1
>>>     : values=on
>>> root@tegra-ubuntu:/home/ubuntu#
>>> root@tegra-ubuntu:/home/ubuntu# dmesg -c [  174.482833] Speaker L
>>> Playback Switch->on_val = 0
>>
>> That looks right, right? on_val is what is going to be written to the control's
>> register. And in your case this needs to be 0 for unmute and 1 for mute. So why
>> would DAPM mute the control on power-up?
>
> I think the issue is that the on_val is set to be off_val in dapm_kcontrol_data_alloc.
> And if I launch "amixer cget name="Speaker L Playback Switch" after the system boot up immediately it will show values=on.
> I think it should show values=off, since the dapm path is actually disconnected.
> If I launch " amixer cset name="Speaker L Playback Switch" 1", the dapm path will be connected.
> But dapm_kcontrol_set_value will return false in if (data->value == value) condition.
> So the on_val will not be set in dapm_kcontrol_set_value, and will equal to off_val still.
> If I set "Speaker L Playback Switch" off and on, the issue will disappear.

Makes sense. So this should fix it, I guess:

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -229,6 +229,8 @@ static int dapm_kcontrol_data_alloc(struct
  			template.id = snd_soc_dapm_kcontrol;
  			template.name = kcontrol->id.name;

+			data->value = template.on_val;
+
  			data->widget = snd_soc_dapm_new_control(widget->dapm,
  				&template);
  			if (!data->widget) {
