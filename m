From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
 Something broke.
Date: Fri, 02 Nov 2007 18:11:05 +0100
Message-ID: <1194023465.19772.1219244387@webmail.messagingengine.com>
References: <472B4416.8060009@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5E75D24459
	for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2007 18:11:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <472B4416.8060009@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I have a customer who says that mplayer (using OSS) does not work when he tries
> a kernel based on 2.6.23-rc4, but it works when he uses a kernel based on
> 2.6.21.  Everything else is the same (including the version of alsa-lib), so I
> presume something broke in the OSS emulation in the kernel.

It could also be a change in the driver.

And it would be nice to know what "does not work" actually means.

> Is it possible to back-level the ALSA support in the kernel itself?

The alsa-kernel tree is only compatible with the current development
kernel.

The alsa-driver package works with older kernels, but must be compiled
seperately.

> Can I just download ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.XX.tar.bz2
> and follow the instructions in the INSTALL file?

Yes.

> If you update the kernel, are you supposed to use the latest alsa-lib as well? 

No; the kernel and lib versions are more or less independent.


HTH
Clemens
