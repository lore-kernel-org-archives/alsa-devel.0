From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 09:28:47 +0800
Message-ID: <20120225012845.GF24268@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id EA097243BF
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 02:15:07 +0100 (CET)
Received: by dady9 with SMTP id y9so3399513dad.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:15:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120224141207.GI5450@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 02:12:07PM +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 10:09:41PM +0800, Shawn Guo wrote:
> > The fsl_ssi probe function detects the client machine name using model
> > property of the device tree.  But it will not work for the ARM client
> > machines which are to be added.  The model property is given as a
> > descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> > Instead, the compatible property gives the machine name.
> 
> The ARM machines really shouldn't be using the bindings that PowerPC is
> using for the machine as they conflate the machine driver with the SSI
> binding.  The idiom for new systems is that machine drivers should be
> first class devices in the device tree referencing the SSI and CODEC.
> 
> The current bindings should be preserved for existing systems of course.

Per discussion [1], the whole point we move to fsl_ssi is that we can
reuse the DT support already in fsl_ssi.  If it's something we should
not use for IMX, I fail to see why we should make this move.

Regards,
Shawn

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/6637
