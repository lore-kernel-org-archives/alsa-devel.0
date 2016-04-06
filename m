From: PC Liao <pc.liao@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: Add second I2S on
 mt8173-rt5650 machine driver
Date: Wed, 6 Apr 2016 21:58:25 +0800
Message-ID: <1459951105.28748.12.camel@mtksdaap41>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk> <1459258103.3747.7.camel@mtksdaap41>
 <20160329160703.GN2350@sirena.org.uk> <1459479052.24414.3.camel@mtksdaap41>
 <20160402170404.GG2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 249E8265130
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 15:58:32 +0200 (CEST)
In-Reply-To: <20160402170404.GG2350@sirena.org.uk>
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

On Sun, 2016-04-03 at 01:04 +0800, Mark Brown wrote:
> On Fri, Apr 01, 2016 at 10:50:52AM +0800, PC Liao wrote:
> > On Wed, 2016-03-30 at 00:07 +0800, Mark Brown wrote:
> 
> > > This sort of arrangement is very common - it's often needed to get
> > > different sample rates for playback and capture.  Normally it'd be
> > > represented in the DT by having the two DAI links specified normally and
> > > then having the driver look at the DT to see what's connected to work
> > > out what mode to use.
> 
> > Could you please suggest the reference driver about this?
> 
> Any driver that can identify an individual DAI within a device by using
> sound-dai references, even simple-card does this.

Thanks for suggestion.
This machine driver is based on DPCM.
Should I add BE DAI and use DAPM, then using ucm-config(mixer control)
to control the path?
Or, do I think the wrong direction?
Thanks!
