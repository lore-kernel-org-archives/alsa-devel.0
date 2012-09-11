From: Timur Tabi <timur@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 1/2] [v2] ASoC: fsl: use
 snd_soc_register_card to register the card
Date: Tue, 11 Sep 2012 15:05:45 -0500
Message-ID: <504F9999.4090405@freescale.com>
References: <1347380607-1564-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 by alsa0.perex.cz (Postfix) with ESMTP id E2C192615E0
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 22:05:54 +0200 (CEST)
In-Reply-To: <1347380607-1564-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Use snd_soc_register_card() instead of platform_device_alloc("soc-audio")
> to register the sound card from the machine drivers.
> 
> Although platform_device_alloc is officially deprecated, it is still used
> by several other drivers.  Unfortunately, something is broken somewhere
> and the Freescale drivers don't register properly when using it.  Since
> we need to transition to snd_soc_register_card() anyway, this fixes the
> problem and updates our code at the same time.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Ugh, I forgot to update the _remove function.  I'll post a v3 patch soon.
 Sorry.

-- 
Timur Tabi
Linux kernel developer at Freescale
