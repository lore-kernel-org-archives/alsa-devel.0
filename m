From: Timur Tabi <timur@freescale.com>
Subject: Any OSS changes from kernel 2.6.21 to 2.6.23?
	Something broke.
Date: Fri, 02 Nov 2007 10:36:54 -0500
Message-ID: <472B4416.8060009@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DB68B2434E
	for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2007 16:36:58 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lA2FatEp002815
	for <alsa-devel@alsa-project.org>; Fri, 2 Nov 2007 08:36:55 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lA2FasxN008666
	for <alsa-devel@alsa-project.org>; Fri, 2 Nov 2007 10:36:55 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a customer who says that mplayer (using OSS) does not work when he tries 
a kernel based on 2.6.23-rc4, but it works when he uses a kernel based on 
2.6.21.  Everything else is the same (including the version of alsa-lib), so I 
presume something broke in the OSS emulation in the kernel.  Unfortunately, our 
git repositories for these trees are not compatible, so I can't use git-bisect 
to narrow the problem down.

Is it possible to back-level the ALSA support in the kernel itself?  Can I just 
download ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.XX.tar.bz2 and 
follow the instructions in the INSTALL file?

If you update the kernel, are you supposed to use the latest alsa-lib as well? 
For a given kernel, how do I know what the right version of alsa-lib is?

-- 
Timur Tabi
Linux kernel developer at Freescale
