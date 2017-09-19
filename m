From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [RFC] ASoC: codecs: msm8916-wcd-analog: use btn0 released
 detection
Date: Tue, 19 Sep 2017 09:22:37 -0400
Message-ID: <20170919132237.ctjcpe27pmwu36mm@workotop.localdomain>
References: <20170913204355.26186-1-damien.riegel@savoirfairelinux.com>
 <3485d646-12fd-4435-1bae-87af9a1a857e@linaro.org>
 <20170919121147.wtpebx6p377cctvc@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170919121147.wtpebx6p377cctvc@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 19, 2017 at 01:11:47PM +0100, Mark Brown wrote:
> On Mon, Sep 18, 2017 at 10:08:04AM +0100, Srinivas Kandagatla wrote:
> > On 13/09/17 21:43, Damien Riegel wrote:
> > > msm8916-wcd-analog uses button0 to differentiate between headphone and
> > > headset. Under some circumstances, button pressed and released
> > > interrupts are not fired as the driver expects it.
> 
> > This is what we need to understand to find a right solution,
> > I would like to understand on what is the difference in the hw layout.

I asked the hardware team and the design is exactly the same, but we use
different mechanical parts (ie. the jack connector).

We've started comparing electrical signals between "Android on
Intrinsyc's eval kit" vs. "Linux on our device", just to get a broad
idea of what might be happening, and today we'll compare the two
hardware with the same software on it. I'll get back to you as soon as I
have more information.

> These sorts of problems can also occur because of differences in test
> process - pressure at different angles, different speeds of insertion
> and a million other things.

Definitely. I also noticed an issue with the first very detection
because the micbias will only be set the first time the driver gets a
mechanical insertion interrupt. Following snippet seems to solve the
problem:

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index f562f2d86907..5045dabd9ea9 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -446,6 +446,7 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
 {
        struct snd_soc_codec *codec = wcd->codec;
+       bool micbias_enabled = false;
        u32 plug_type = 0;
        u32 int_en_mask;

@@ -477,6 +478,11 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
                            DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
                            DIG_CLK_CTL_D_MBHC_CLK_EN);

+       if (snd_soc_read(codec, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
+               micbias_enabled = true;
+
+       pm8916_mbhc_configure_bias(priv, micbias_enabled);
+
        int_en_mask = MBHC_SWITCH_INT;
        if (wcd->mbhc_btn_enabled)
                int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
