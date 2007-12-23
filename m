From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Sat, 22 Dec 2007 20:58:21 -0600
Message-ID: <476DCECD.6040008@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>
	<476A7B23.2040905@freescale.com>	<20071220223943.GA24138@lixom.net>
	<476AEEB3.2010403@freescale.com> <476AF015.5040600@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 0717D24489
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 03:58:32 +0100 (CET)
In-Reply-To: <476AF015.5040600@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Wood <scottwood@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Scott Wood wrote:

>> None of the SOC nodes in any DTS have a "compatible" entry.
> 
> Not quite true; ep88xc, mpc8272ads, and pq2fads have them.

Ah ok.  So what should the compatible entry for 8641 be?

	compatible = "fsl,mpc8641"

That looks a lot like what a compatible entry for the CPU should be. 
How are we differentiating between the compatible cores and compatible SOCs?
