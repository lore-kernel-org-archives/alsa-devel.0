From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: claim the IRQ when the fsl_ssi
 device is probed, not opened
Date: Wed, 17 Aug 2011 10:04:34 +0900
Message-ID: <20110817010433.GC27099@opensource.wolfsonmicro.com>
References: <1313534865-7795-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55C5B10383B
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 03:04:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313534865-7795-1-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 16, 2011 at 06:47:45PM -0400, Timur Tabi wrote:
> The PowerPC Freescale SSI driver is claiming the IRQ when the IRQ when
> the device is opened, which means that the /proc/interrupts entry for
> the SSI exists only during playback or capture.  This also meant that
> the user won't know that the IRQ number is wrong until he tries to use
> the device.  Instead, we should claim the IRQ when the device is probed.

Applied, thanks.
