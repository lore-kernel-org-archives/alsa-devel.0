From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 11:04:39 -0600
Message-ID: <476AA0A7.4090002@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>	<476A7B23.2040905@freescale.com>
	<s5h4ped4gl3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 57332103835
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 18:05:33 +0100 (CET)
In-Reply-To: <s5h4ped4gl3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> All?  No, only a few...
> For PCI, usually pci_set_dma_mask() and pci_set_consistent_dma_mask()
> are used, of course.

Hmm, ok I was wrong.  I took this code from the ASoC at91 driver.

Unfortunately, I don't understand what this code is trying to do.  The AT91 
driver isn't documented, so I don't even know if I need it.  Can someone explain 
what all this is?  What's the alternative to using a static global?

-- 
Timur Tabi
Linux kernel developer at Freescale
