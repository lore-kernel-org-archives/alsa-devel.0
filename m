From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with
 imx pcm and machine drivers
Date: Fri, 9 Mar 2012 09:51:30 +0800
Message-ID: <20120309015128.GI2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
	<20120308191526.GQ3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9E4910BBF3
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 02:51:41 +0100 (CET)
Received: by iakh37 with SMTP id h37so1785380iak.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 17:51:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308191526.GQ3852@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2012 at 08:15:26PM +0100, Sascha Hauer wrote:
...
> > @@ -796,6 +862,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
> >  
> >  static const struct of_device_id fsl_ssi_ids[] = {
> >  	{ .compatible = "fsl,mpc8610-ssi", },
> > +	{ .compatible = "fsl,imx1-ssi", },
> 
> imx1 seems wrong here. The register layout has changed significantly between
> i.MX1 and i.MX21.
> 
Yeah, that's right.  You indeed know i.MX1 much better than me.  Will
change to:

  .compatible = "fsl,imx21-ssi"

-- 
Regards,
Shawn
