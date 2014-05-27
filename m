From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Fix Left/Rigth PGA
 mixer widgets/kcontrols
Date: Tue, 27 May 2014 14:24:34 +0200
Message-ID: <53848402.9020801@metafoo.de>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
 <53847489.2010801@metafoo.de> <538479EC.7030105@ti.com>
 <53847CE7.4080105@metafoo.de> <538482C2.1090607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 188F12655AD
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 14:24:33 +0200 (CEST)
In-Reply-To: <538482C2.1090607@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

[...]
>>>> This driver uses a custom put handler and the generic get handler.
>>>> dapm_kcontrol_get_value() is used in the generic get handler, but only if reg
>>>> equal to SND_SOC_NOPM. Which is not the case for this driver.
>>>
>>> The relevant code is this:
>>>      if (dapm_kcontrol_is_powered(kcontrol) && reg != SND_SOC_NOPM)
>>>          val = (snd_soc_read(codec, reg) >> shift) & mask;
>>>      else
>>>          val = dapm_kcontrol_get_value(kcontrol);
>>>
>>> and when the widget is not powered the code will try to get the value from the
>>> dapm_kcontrol_data, which is not even touched by the custom code in the driver.
>>
>> dapm_kcontrol_is_powered() always returns true if the control is not a
>> auto-muted control. And there are no auto-muted controls in the tlv320aix3c
>> driver.
>
> dapm_kcontrol_is_powered() returns the data->widget->power, which is not the
> automute state. Widgets do turn off when they are not in use, like in my system:
>
> # cat tlv320aic3x-codec.0-001b/dapm/Left\ PGA\ Mixer
> Left PGA Mixer: Off  in 0 out 0
>   out "static" "Left ADC"
>
> So the widget's power is off.

The widget that data->widget points to is not the mixer widget. It is the 
widget that is created for auto-mute handling if the control is auto-muted. 
It will be NULL in your case, which means dapm_kcontrol_is_powered() return 
true.

- Lars
