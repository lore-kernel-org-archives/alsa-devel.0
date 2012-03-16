From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 10:52:21 +0800
Message-ID: <20120316025219.GB7632@S2101-09.ap.freescale.net>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
	<20120316020111.GE6065@S2101-09.ap.freescale.net>
	<4F62A06C.5000304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EA571046BB
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 03:51:52 +0100 (CET)
Received: by iakh37 with SMTP id h37so5373023iak.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 19:51:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F62A06C.5000304@freescale.com>
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

On Fri, Mar 16, 2012 at 02:07:42AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> 
> > This could probably change to check whether property codec-handle is
> > present under SSI node to decide if it runs with "old binding" or
> > "new binding".
> 
> I guess that's how we need to do it.  The SSI driver should not be looking 
> for /sound node, but that's the most reliable way to know if we have a new 
> or old binding.
> 
...
> >> This prohibits me from using the new binding on any future PowerPC parts,
> >> because it clearly says "iMX" on everything.
> >
> > I think we can change it later when the future PowerPC parts come to
> > use the new binding.  In any case, I do not see this is an issue that
> > should block the whole series.
> 
> At least get rid of any unnecessary references to "imx".
> 
So something like this?

        /*
         * If codec-handle property is missing from SSI node, we assume
         * that the machine driver uses new binding which does not require
         * SSI driver to trigger machine driver's probe.
         */
        if (!of_get_property(np, "codec-handle", NULL)) {
                if (ssi_private->ssi_on_imx) {
                        ssi_private->imx_pcm_pdev =
                                platform_device_register_simple("imx-pcm-audio",
                                                                -1, NULL, 0);
                        if (IS_ERR(ssi_private->imx_pcm_pdev)) {
                                ret = PTR_ERR(ssi_private->imx_pcm_pdev);
                                goto error_dev;
                        }
                }
                /* success for new binding case */
                return 0;
        }

It does not reduce any reference to "imx" actually.  If you think it's
worth another iteration of the series, I will post v5 for it.

-- 
Regards,
Shawn
