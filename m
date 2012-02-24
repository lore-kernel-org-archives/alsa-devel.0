From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: imx: add an explicit Kconfig
 option for imx-ssi driver
Date: Fri, 24 Feb 2012 11:37:52 +0800
Message-ID: <20120224033750.GB4441@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
	<4F465DD0.1020304@freescale.com>
	<20120224012850.GA4441@S2101-09.ap.freescale.net>
	<4F46FD09.5020700@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id EB05524414
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 04:24:20 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so476484pbc.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 19:24:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F46FD09.5020700@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 02:59:22AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > That's what I'm doing.  But to be clear, imx-ssi driver will still
> > exist for all those non-DT i.MX platforms.  We are supporting DT for
> > imx5 and imx6, but have not seen a plan to migrate all those old i.MX
> > platforms to DT.
> 
> On PowerPC, we handle this by creating cuImages.  These are kernel images 
> that have a DTB built-in.  Perhaps something like that is needed for ARM?
> 
We have the similar support on ARM (dtb can be appended to zImage).
It resolves the problem that boot loader does not support DT.  However
what I'm saying is that we do not have a plan to add DT support for
those old i.MX SoCs like imx1, imx2, imx3 in kernel.  That said, the
kernel running on those platforms are not aware of DT.

-- 
Regards,
Shawn
