From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 04/20] ARM: imx: convert audmux to a
	platform driver
Date: Mon, 5 Mar 2012 15:35:41 +0800
Message-ID: <20120305073538.GB16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-5-git-send-email-shawn.guo@linaro.org>
	<20120304190031.GT3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D19C103EE8
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 08:21:16 +0100 (CET)
Received: by iakh37 with SMTP id h37so5496774iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Mar 2012 23:21:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120304190031.GT3852@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, Richard Zhao <richard.zhao@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 04, 2012 at 08:00:31PM +0100, Sascha Hauer wrote:
...
> The audmux is a device completely internal to the i.MX and is registered
> without platform_data. I think we should do the device registration
> somewhere in the SoC specific code and not do it in each board.
> Also we now have platform_device_register_simple, we shouldn't use the
> imx_ variant in new code.
> 
Good point.  Then we do not need to add audmux device board by board.

-- 
Regards,
Shawn
