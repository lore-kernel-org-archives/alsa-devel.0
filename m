From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 2 Jan 2008 12:08:30 -0600
Message-ID: <20080102180830.GC4398@loki.buserror.net>
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
	<20071220223943.GA24138@lixom.net> <476AEEB3.2010403@freescale.com>
	<476AF015.5040600@freescale.com> <476DCECD.6040008@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 27A7E243CD
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 19:08:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <476DCECD.6040008@freescale.com>
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
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 22, 2007 at 08:58:21PM -0600, Timur Tabi wrote:
> Scott Wood wrote:
>
>>> None of the SOC nodes in any DTS have a "compatible" entry.
>>
>> Not quite true; ep88xc, mpc8272ads, and pq2fads have them.
>
> Ah ok.  So what should the compatible entry for 8641 be?
>
> 	compatible = "fsl,mpc8641"

Yes.

> That looks a lot like what a compatible entry for the CPU should be.

I guess technically the cpu should list something like fsl,e600 (or
whatever suffix is relevant).

-Scott
