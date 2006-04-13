From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Missing definition for DMA_31BIT_MASK on older kernels
Date: Thu, 13 Apr 2006 11:26:15 +0200
Message-ID: <20060413092615.GB28195@turing.informatik.uni-halle.de>
References: <20060412222516.GJ13693@neu.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A362A15C
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 11:27:12 +0200 (MEST)
Received: from mserv1.urz.uni-halle.de ([141.48.3.145] helo=mserv1)
	 by mailgate2.urz.uni-halle.de with esmtp  (Exim 4.60)
	 id 1FTy6Z-0003r8-RR for <alsa-devel@alsa-project.org>
	 ; Thu, 13 Apr 2006 11:27:12 +0200
Received: from conversion-daemon.mail.uni-halle.de by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 HotFix 2.02 (built Oct 21 2004))
 id <0IXN00K01L3QXP@mail.uni-halle.de>
 (original mail from ladischc@informatik.uni-halle.de)
 for alsa-devel@alsa-project.org; Thu, 13 Apr 2006 11:26:32 +0200 (MEST)
Received: from turing.informatik.uni-halle.de
 (turing.informatik.Uni-Halle.DE [141.48.9.50])
 by mail.uni-halle.de (iPlanet Messaging Server 5.2 HotFix 2.02 (built Oct 21
 2004)) with ESMTP id <0IXN00EHEM7S5A@mail.uni-halle.de> for
 alsa-devel@alsa-project.org; Thu, 13 Apr 2006 11:26:16 +0200 (MEST)
Received: from turing.informatik.uni-halle.de (localhost [127.0.0.1])
	by turing.informatik.uni-halle.de (8.12.10+Sun/8.12.10)
 with ESMTP id k3D9QFaG028230	for <alsa-devel@alsa-project.org>; Thu,
 13 Apr 2006 11:26:15 +0200 (MEST)
Received: (from ladischc@localhost)	by turing.informatik.uni-halle.de
 (8.12.10+Sun/8.12.10/Submit)
 id k3D9QFNP028229	for alsa-devel@alsa-project.org; Thu,
 13 Apr 2006 11:26:15 +0200 (MEST)
In-reply-to: <20060412222516.GJ13693@neu.nirvana>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Axel Thimm wrote:
> alsa-kernel/pci/ali5451/ali5451.c uses DMA_31BIT_MASK which for the
> latest kernels is defined in include/linux/dma-mapping.h. Previous
> kernels don't have this constant defined.

Fixed now, thanks.


Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
