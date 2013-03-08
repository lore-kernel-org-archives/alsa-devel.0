From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: add codec driver for TI TAS5086
Date: Fri, 08 Mar 2013 13:26:35 +0100
Message-ID: <5139D8FB.4070500@gmail.com>
References: <1362740833-15704-1-git-send-email-zonque@gmail.com>
 <20130308114251.GF28481@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C2C626170F
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 13:26:32 +0100 (CET)
Received: by mail-bk0-f49.google.com with SMTP id w11so675083bku.36
 for <alsa-devel@alsa-project.org>; Fri, 08 Mar 2013 04:26:32 -0800 (PST)
In-Reply-To: <20130308114251.GF28481@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

thanks for your quick review.

On 08.03.2013 12:42, Mark Brown wrote:
> On Fri, Mar 08, 2013 at 12:07:13PM +0100, Daniel Mack wrote:

>> +static int tas5086_digital_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
>> +
>> +	return regmap_write(priv->regmap, TAS5086_SOFT_MUTE,
>> +			    mute ? 0x3f : 0x00);
> 
> Please avoid the ternery operator.  It'd be nice to switch over to
> mute_stream() too.

I wasn't aware of steam_mute. How's that supposed to be used? I'm asking
because when using 4-channel playback, the driver gets this callback for
stream == 0 only. Am I supposed to (un)mute all channels here,
regardless of the stream parameter passed in?

>> +#ifdef CONFIG_PM
>> +static int tas5086_soc_suspend(struct snd_soc_codec *codec)
>> +{
>> +	return 0;
>> +}
> 
> Empty functions can just be omitted, though it might make sense to hold
> the device in reset over suspend.

I can't test this at the moment, so I'll skip suspend functionality
support for now. Will send another follow-up patch in the future for this.



Thanks,
Daniel
