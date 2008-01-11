From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] [ALSA] Add ASoC drivers for
 the	Freescale MPC8610 SoC
Date: Fri, 11 Jan 2008 09:08:36 -0600
Message-ID: <47878674.7010705@freescale.com>
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
	<4786A650.2080107@freescale.com> <20080111002450.GA13291@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 324032449D
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 16:08:45 +0100 (CET)
In-Reply-To: <20080111002450.GA13291@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Olof Johansson wrote:

> Having been in a similar situation myself (needing to share resources
> between DMA, ethernet and function offload), I recommend creating a
> separate small library that all those drivers use, instead of making
> some sort of dependency between drivers in completely different parts
> of the kernel.

Well, the DMA driver should be in soon.  Actually, it should be in now, because 
I saw a blurb in this month's Linux Journal about it.  As soon as I find it :-), 
I'll post a new patch that adds arbitration.

-- 
Timur Tabi
Linux kernel developer at Freescale
