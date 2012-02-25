From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Sat, 25 Feb 2012 08:03:20 +0800
Message-ID: <20120225000319.GC24268@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<20120224140200.GH5450@opensource.wolfsonmicro.com>
	<20120224142342.GA16659@S2101-09.ap.freescale.net>
	<20120224141705.GJ5450@opensource.wolfsonmicro.com>
	<20120224232148.GA24268@S2101-09.ap.freescale.net>
	<4F4819C4.5040709@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id BF7AA24346
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 00:49:40 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so1662958pbc.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:49:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4819C4.5040709@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 05:14:12PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> >> > That doesn't seem to be related to my point?  I'm asking you to not
> >> > reply to an old version of your patch series in order to post a new
> >> > version of it, just post the new version.
> 
> > This is the first version of this series.
> 
> I think there's a communication breakdown.  Shawn, take a look at this:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/thread.html
> 
> Search for "[alsa-devel] [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl".
> 
> You'll see that this email is indented, because it was posted to the
> mailing list AS A REPLY to "[alsa-devel] [PATCH 1/4] ASoC: imx: let
> SND_MXC_SOC_FIQ select FIQ".  That's because it has this line in the
> message header:
> 
> In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
> 
> This is what Mark is talking about.  He wants new patch sets to be posted
> NOT as replies to other patch sets.
> 
Yes, I did something wrong.  But my point is the following patches
should belong to one big series.  They can not be applied separately.

[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
[PATCH 2/4] ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
[PATCH 3/4] ASoC: imx: initialize dma_params burstsize just in imx-ssi
[PATCH 4/4] ASoC: imx: separate imx-pcm bits from imx-ssi driver
[PATCH 0/4] ASoC: merge imx into fsl
[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl

-- 
Regards,
Shawn
