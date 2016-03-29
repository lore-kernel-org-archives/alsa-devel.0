From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: Add second I2S on
 mt8173-rt5650 machine driver
Date: Tue, 29 Mar 2016 21:28:23 +0800
Message-ID: <1459258103.3747.7.camel@mtksdaap41>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id D604A2605C3
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:28:30 +0200 (CEST)
In-Reply-To: <20160328191115.GE2350@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srv_heupstream <srv_heupstream@mediatek.com>, "tiwai@suse.de" <tiwai@suse.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, 2016-03-29 at 03:11 +0800, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 11:42:05AM +0800, PC Liao wrote:
> 
> > +Optional properties:
> > +- mediatek,rt5650_i2s: I2S mode of rt5650
> > +  0: using I2S1 on rt5650 for record
> > +  1: using I2S2 on rt5650 for record
> > +
> 
> I would expect the machine driver to have a reference to the DAI that is
> in use rather than a property like this.  This is the way pretty much
> all DT based machine drivers work...

Thanks for comment.
I think I need to comment more clearly.
This setting is different connection from MT8173 to rt5650 on hardware.

- mediatek,rt5650_i2s: I2S mode of rt5650
0: Default setting. Playback and record path use same set of I2S.
Playback/Record path using same I2S clock connect from MT8173 I2S1 to
rt5650 I2S1.
1: Playback and record path use different set of I2S. Playback path
connects from MT8173 I2S1 to rt5650 I2S1 and record path connects from
MT8173 I2S2 to rt5650 I2S2.

Because we use codec ASRC function and need to initialize on different
setting about this parts:
+	switch (mt8173_rt5650_priv.rt5650_i2s) {
+	case MT8173_RT5650_I2S1:
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER |
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+		break;
+	case MT8173_RT5650_I2S2:
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S2_ASRC);
+		break;
+	default:
+		break;
+	}
, we use device tree to determine which connection we choose.
Does this explain can be accepted?
Thanks!
