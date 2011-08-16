From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: claim the IRQ when the fsl_ssi
 device is probed, not opened
Date: Tue, 16 Aug 2011 22:41:02 +0000
Message-ID: <4E4AF1FE.9010907@freescale.com>
References: <1313534150-6642-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 42DAF10383B
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 00:41:09 +0200 (CEST)
In-Reply-To: <1313534150-6642-1-git-send-email-timur@freescale.com>
Content-Language: en-US
Content-ID: <2F4524173828F34685890CE2F309C654@freescale.net>
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
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> The PowerPC Freescale SSI driver is claiming the IRQ when the IRQ when
> the device is opened, which means that the /proc/interrupts entry for
> the SSI exists only during playback or capture.  This also meant that
> the user won't know that the IRQ number is wrong until he tries to use
> the device.  Instead, we should claim the IRQ when the device is probed.
>
> Signed-off-by: Timur Tabi<timur@freescale.com>

Ugh, somehow I got my patches criss-crossed.  Ignore this, please.  I'll 
post a V2 in just a minute.
