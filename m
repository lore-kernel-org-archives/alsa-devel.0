From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Sat, 25 Feb 2012 20:16:22 +0800
Message-ID: <20120225121619.GA25201@S2101-09.ap.freescale.net>
References: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<20120224140200.GH5450@opensource.wolfsonmicro.com>
	<20120224142342.GA16659@S2101-09.ap.freescale.net>
	<20120224141705.GJ5450@opensource.wolfsonmicro.com>
	<20120224232148.GA24268@S2101-09.ap.freescale.net>
	<4F4819C4.5040709@freescale.com>
	<20120225000319.GC24268@S2101-09.ap.freescale.net>
	<4F483BB8.7030706@freescale.com>
	<20120225101758.GJ22562@n2100.arm.linux.org.uk>
	<20120225114414.GC3167@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id E6C8B2446F
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 13:02:45 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so2161515pbc.38
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 04:02:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120225114414.GC3167@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tabi Timur-B04825 <B04825@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2012 at 11:44:15AM +0000, Mark Brown wrote:
> On Sat, Feb 25, 2012 at 10:17:58AM +0000, Russell King - ARM Linux wrote:
> > On Sat, Feb 25, 2012 at 01:39:05AM +0000, Tabi Timur-B04825 wrote:
> 
> > > That's not what Mark is talking about.  You somehow posted patch 0/6 as a 
> > > reply to the *previous* patchset, so the two patchsets were merged into 
> > > one email thread.
> 
> > Sorry, you and Mark are not listening to Shawn.  Even worse, you're
> > telling Shawn that what he's trying to explain to you is not the point
> > when it is actually the whole point.
> 
> > The "[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl" was posted as a
> > follow-up to "[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ".
> 
> > So, the "*previous* patchset" _was_ "[PATCH 1/4] ASoC: imx: let
> > SND_MXC_SOC_FIQ select FIQ" and not some other random patch set.  That
> > is a fundamental fact, which can't be argued.  Anyone can verify it, and
> > it can be verified by checking the email headers.
> 
> No, I get that it's a new version of the same patch set

I know it's confusing.  But "[PATCH 0/6] ASoC: a few cleanups on
sound/soc/fsl" is not a new version of the series "[PATCH 1/4] ASoC:
imx: let SND_MXC_SOC_FIQ select FIQ".  Instead, it's a follow-up
series which depends on previously posted patches.

Anyway, I will stop doing that to confuse people.

Regards,
Shawn

> rather than a
> totally unrelated patch set that was followed up to - I'd still rather
> it weren't posted like that as the threading ends up being less helpful
> than is desirable.
