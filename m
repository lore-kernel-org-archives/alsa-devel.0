From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
 fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 07:08:00 -0500
Message-ID: <48526320.6070406@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121922h6a5e1e71l3707b5e7b8e6c62f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 6252E244BA
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 14:08:07 +0200 (CEST)
In-Reply-To: <9e4733910806121922h6a5e1e71l3707b5e7b8e6c62f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> You're loading the fabric driver as a platform driver controlled via
> Kconfig. Has any progress been made on a way to trigger loading it via
> the device tree?

What should I trigger it on?  For this idea to work, I need to have a 
node in the device tree that no other driver wants.  What node should 
that be?

> Why are you calling all of the mpc code fsl? Freescale makes other
> processors that start with imx, mcp, mac, mmc, m68...

The SSI device exists in both i.MX and MPC parts, so it makes sense to 
call that fsl_.  The DMA controller could exist on non-MPC parts, but 
currently it doesn't.  I called it fsl_dma.c just to be consistent.

If it turns out that there's a real name clash, we can always rename them.
