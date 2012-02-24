From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: imx: add an explicit Kconfig
 option for imx-ssi driver
Date: Fri, 24 Feb 2012 09:28:53 +0800
Message-ID: <20120224012850.GA4441@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
	<4F465DD0.1020304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2475E24348
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 02:15:20 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so374747pbc.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 17:15:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F465DD0.1020304@freescale.com>
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

On Thu, Feb 23, 2012 at 09:40:00AM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Since when do you work for Linaro?
> 
Since one year ago, as Freescale assignee to Linaro.  So I'm still
employed by Freescale.

> > ---
> >  sound/soc/imx/Kconfig  |    7 +++++++
> >  sound/soc/imx/Makefile |    4 ++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
> > index 863a6b4..b9de8a8 100644
> > --- a/sound/soc/imx/Kconfig
> > +++ b/sound/soc/imx/Kconfig
> > @@ -8,6 +8,9 @@ menuconfig SND_IMX_SOC
> >  
> >  if SND_IMX_SOC
> >  
> > +config SND_SOC_IMX_SSI
> > +	tristate
> > +
> 
> I was hoping to see sound/soc/imx disappear completely, and all IMX
> support move into sound/soc/fsl.  After all, i.MX is a Freescale name.
> 
That's what I'm doing.  But to be clear, imx-ssi driver will still
exist for all those non-DT i.MX platforms.  We are supporting DT for
imx5 and imx6, but have not seen a plan to migrate all those old i.MX
platforms to DT.

-- 
Regards,
Shawn
