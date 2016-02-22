From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: Add machine driver for ALC5650 codec
Date: Mon, 22 Feb 2016 11:05:50 +0800
Message-ID: <1456110350.7576.12.camel@mtksdaap41>
References: <1455849359-14581-1-git-send-email-pc.liao@mediatek.com>
	 <20160219153744.GP18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160219153744.GP18327@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, 2016-02-19 at 23:37 +0800, Mark Brown wrote:
> On Fri, Feb 19, 2016 at 10:35:59AM +0800, PC Liao wrote:
> 
> > @@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
> >  # Machine support
> >  obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
> >  obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
> > +obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
> 
> Why is this not covered by (or coverable by) the existinng RT5650-RT5657
> driver?

Thanks for your review.

Because they are different boards and have some differences like HW
configuration and mixer control, we want to separate machine driver
clearly.

Otherwise, I think I will upload this change to new version for more
clearly.
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index bcdcb06..dcb1440 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -2,5 +2,5 @@
 obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
 # Machine support
 obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
 obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
