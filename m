From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] [ALSA] Add ASoC drivers for
	the	Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 18:24:50 -0600
Message-ID: <20080111002450.GA13291@lixom.net>
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
	<4786A650.2080107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C6EC247B5
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 01:15:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4786A650.2080107@freescale.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 10, 2008 at 05:12:16PM -0600, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > Does the driver access the DMA and GUTS registers directly?  If so,
> > what do you have to protect against race conditions of other drivers
> > accessing them also.
> 
> I don't have any more protection than any other driver that accesses SOC 
> registers directly.  Last I heard, Zhang's DMA driver was in limbo, and that 
> driver would be the best place to arbitrate DMA register access.  I was planning 
> on adding arbitration support to that driver after both drivers were applied.

Having been in a similar situation myself (needing to share resources
between DMA, ethernet and function offload), I recommend creating a
separate small library that all those drivers use, instead of making
some sort of dependency between drivers in completely different parts
of the kernel.


-Olof
