From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] [ALSA] Add ASoC drivers for
 the	Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 17:12:16 -0600
Message-ID: <4786A650.2080107@freescale.com>
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 932E42478A
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 00:13:47 +0100 (CET)
In-Reply-To: <fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> Does the driver access the DMA and GUTS registers directly?  If so,
> what do you have to protect against race conditions of other drivers
> accessing them also.

I don't have any more protection than any other driver that accesses SOC 
registers directly.  Last I heard, Zhang's DMA driver was in limbo, and that 
driver would be the best place to arbitrate DMA register access.  I was planning 
on adding arbitration support to that driver after both drivers were applied.

As for the GUTS driver, well, I just program a few registers at startup, and I 
don't think any other driver touches them.

-- 
Timur Tabi
Linux kernel developer at Freescale
