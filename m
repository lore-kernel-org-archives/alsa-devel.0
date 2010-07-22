From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 12:38:53 +0300
Message-ID: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 900ED103989
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 11:38:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org


Hello.

And thank you for all the comments. 

Comments to comments:

>> +#undef DEBUG
>
> This shouldn't be here.

Removed.

>> +     wl1273->mode = ucontrol->value.integer.value[0];
>
> You're not doing any validation of the supplied value here.

Validation added.

> Don't put your enums in arrays, it just makes things harder to maintain
> since you have to reference an index into an array rather than a named
> value.

Yes using one-element arrays is kind of meaningless, so arrays removed.

> My major comment about this driver is that it'd probably make sense to
> redo it on top of Liam's multi-component branch, though it shouldn't be
> a pressing concern for merge.

I didn't do this yet. But could you give me the git URL and then I'll resend?

> Wouldn't it be nicer to do this stuff with the ALSA constraint APIs
> rather than futzing with the constant data?

I principle I of course agree. But it seems - also discussed with the local
ALSA specialist - that using static constraints does not work here.
HALF_DUPLEX is not one of the SNDRV_PCM_HW_PARAM_'s... or something like that.
As a ALSA non-specialist I'd be willing to this leave as it is...

>> +static int wl1273_set_dai_fmt(struct snd_soc_dai *codec_dai,
>> +                           unsigned int fmt)
>> +{
>> +     return 0;
>> +}
>
>Remove unused functions.

I tried leaving this out but then the codec stopped working. I guess I should
mention that my test environment is 2.6.32. I'm only able to test that
the codec compiles under 2.6.35. Anyway I left the function in.

>> +enum wl1273_mode wl1273_get_codec_mode(struct snd_soc_codec *codec)
>> +{
>> +     struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
>> +     return wl1273->mode;
>> +}
>> +EXPORT_SYMBOL_GPL(wl1273_get_codec_mode);
>
> Why is this being exported?

This is because the soc_card driver needs to know the codec mode and accessing
the internals of the codec struct is ugly.

>> +static int wl1273_soc_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +     return 0;
>> +}
>> +
>> +static int wl1273_soc_resume(struct platform_device *pdev)
>> +{
>> +     return 0;
>> +}
>
> Remove unused functions.

Dropping these caused no problems, so removed...

Cheers,
Matti A.

Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  586 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |   42 ++++
 2 files changed, 628 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h
