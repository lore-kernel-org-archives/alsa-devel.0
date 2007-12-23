From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Sat, 22 Dec 2007 21:23:48 -0600
Message-ID: <476DD4C4.5030708@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>
	<476A7B23.2040905@freescale.com>	<s5h4ped4gl3.wl%tiwai@suse.de>
	<75b66ecd0712202128n2f13adf2ie9a344e0c19d69ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 62E2624507
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 04:23:53 +0100 (CET)
In-Reply-To: <75b66ecd0712202128n2f13adf2ie9a344e0c19d69ad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

> Please use DMA_32BIT_MASK (see include/linux/dma-mapping.h) instead of
> 0xffffffff. 

No prob.  But did you see this comment:

/*
  * NOTE: do not use the below macros in new code and do not add new 
definitions
  * here.
  *
  * Instead, just open-code DMA_BIT_MASK(n) within your driver
  */

So I guess I should use DMA_BIT_MASK(32) instead.

> I've personally fixed a heisenbug in an ALSA driver
> caused by incorrectly typed DMA mask...

Can you explain to me what all of this does?  Is it okay to use a static 
u64 variable?  Why do so many drivers do it that way?  I don't even know 
if 0xFFFFFFFF is the right number for my platform.
