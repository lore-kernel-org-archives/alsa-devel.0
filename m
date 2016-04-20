From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Date: Wed, 20 Apr 2016 17:39:50 +0800
Message-ID: <1461145190.3774.5.camel@mtksdaap41>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
	 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
	 <20160420082917.GH3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160420082917.GH3217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?UTF-8?Q?=28=E9=99=B3=E6=80=9D=E7=BF=B0=29?= <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, 2016-04-20 at 16:29 +0800, Mark Brown wrote:
> On Wed, Apr 20, 2016 at 02:40:47PM +0800, PC Liao wrote:
> 
> > +Optional properties:
> > +- capture-dai: audio codec dai on capture path
> > +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> > +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
> 
> I sugggested changing this to use a subnode but you've ignored my
> suggestion...

Sorry.... It's my mistake.

You mean that using a subnode.
This is my example:

  codec-capture {
	  sound-dai = <&rt5650 1>;
  };

Does this is your suggestion?
Thanks!
