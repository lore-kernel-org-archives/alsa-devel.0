From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: fix bad register
 MIC_BIAS_VOLTAGE setup on probe
Date: Fri, 25 Sep 2015 14:03:53 -0300
Message-ID: <CAOMZO5DzNzyeP2C10Wr-atonsUBzMO-esokAkcQnj6hUDMf_cA@mail.gmail.com>
References: <1443190887-18080-1-git-send-email-gianlucarenzi@eurekelettronica.it>
	<20150925165028.GJ30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150925165028.GJ30445@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>, Fabio Estevam <fabio.estevam@freescale.com>, linux-kernel <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 25, 2015 at 1:50 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Sep 25, 2015 at 04:21:27PM +0200, Gianluca Renzi wrote:
>
>>       snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
>>                       SGTL5000_BIAS_R_MASK,
>> -                     sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
>> +                     sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);
>
> That doesn't look right...  I would expect _BIAS_R_SHIFT to shift a
> value into the register masked off by _BIAS_R_MASK and therefore that
> the above is saying that the definition of one of those two macros is
> wrong.  I would not expect something called _BIAS_VOLT_SHIFT here.

Yes, the correct fix should be:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1376,8 +1376,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
                        sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);

        snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
-                       SGTL5000_BIAS_R_MASK,
-                       sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
+                       SGTL5000_BIAS_VOLT_MASK,
+                       sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);
        /*
         * disable DAP
         * TODO:

Gianluca,

Care to send a v2 of the patch?

Regards,

Fabio Estevam
