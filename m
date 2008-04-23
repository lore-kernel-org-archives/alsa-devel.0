From: Timur Tabi <timur@freescale.com>
Subject: Re: SoC sound support for imx27
Date: Wed, 23 Apr 2008 10:44:18 -0500
Message-ID: <480F5952.9060007@freescale.com>
References: <200804231654.44526.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 357D624610
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 17:44:23 +0200 (CEST)
In-Reply-To: <200804231654.44526.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Juergen Beisert wrote:
> Hi,
> 
> I'm going to adapt Freescale's i.MX27 CPU to the SoC sound support via I2S.

Are you talking about the SSI device?  There already is an FSL SSI driver in
sound/soc/fsl, but it's for PowerPC, not i.MX.  I'd be happy to work with you in
making it cross-platform.

-- 
Timur Tabi
Linux kernel developer at Freescale
