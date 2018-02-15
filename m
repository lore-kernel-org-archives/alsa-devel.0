From: Fabio Estevam <festevam@gmail.com>
Subject: Re: sgtl5000 fails after suspend/resume
Date: Thu, 15 Feb 2018 16:27:22 -0200
Message-ID: <CAOMZO5A4i5xs3o5GxZkZuTSJQ1t5dsaMsMqm1DCDsr-UXzFhJQ@mail.gmail.com>
References: <CAOMZO5B3rb_UKatssvP0eZdm4JD_oa3A0A1pAr4keq4w0EYBNA@mail.gmail.com>
 <CAOMZO5CyE5T-H=K2Q9A=tYoY9zt0CO4YdFWK5PMS=NR2XbqPzQ@mail.gmail.com>
 <20180215181632.GJ8374@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f173.google.com (mail-ot0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 04E7A267D1E
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 19:27:23 +0100 (CET)
Received: by mail-ot0-f173.google.com with SMTP id q12so559769otg.10
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 10:27:23 -0800 (PST)
In-Reply-To: <20180215181632.GJ8374@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Eric Nelson <eric@nelint.com>, Stefan Agner <stefan@agner.ch>, Gary Bisson <gary.bisson@boundarydevices.com>, Max Krummenacher <max.krummenacher@toradex.com>, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Feb 15, 2018 at 4:16 PM, Mark Brown <broonie@kernel.org> wrote:

> Does it need a register map resync when powering on again?

Thanks for your suggestion! This works:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -871,15 +871,26 @@ static int sgtl5000_pcm_hw_params(struct
snd_pcm_substream *substream,
 static int sgtl5000_set_bias_level(struct snd_soc_component *component,
                                   enum snd_soc_bias_level level)
 {
+       struct sgtl5000_priv *sgtl = snd_soc_component_get_drvdata(component);
+       int ret;
+
        switch (level) {
        case SND_SOC_BIAS_ON:
        case SND_SOC_BIAS_PREPARE:
        case SND_SOC_BIAS_STANDBY:
+               regcache_cache_only(sgtl->regmap, false);
+               ret = regcache_sync(sgtl->regmap);
+               if (ret) {
+                       regcache_cache_only(sgtl->regmap, true);
+                       return ret;
+               }
+
                snd_soc_component_update_bits(component,
SGTL5000_CHIP_ANA_POWER,
                                    SGTL5000_REFTOP_POWERUP,
                                    SGTL5000_REFTOP_POWERUP);
                break;
        case SND_SOC_BIAS_OFF:
+               regcache_cache_only(sgtl->regmap, true);
                snd_soc_component_update_bits(component,
SGTL5000_CHIP_ANA_POWER,
                                    SGTL5000_REFTOP_POWERUP, 0);
                break;
