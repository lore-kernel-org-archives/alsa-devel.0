From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi 3.07.04
Date: Fri, 18 May 2007 13:36:48 +1200
Message-ID: <200705181336.48629.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep02.xtra.co.nz (fep02.xtra.co.nz [210.54.141.244])
	by alsa0.perex.cz (Postfix) with ESMTP id F2B6024338
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 03:36:52 +0200 (CEST)
Received: from zaphod.local ([125.237.107.166]) by fep02.xtra.co.nz with ESMTP
	id <20070518013645.QMKJ23876.fep02.xtra.co.nz@zaphod.local>
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 13:36:45 +1200
Content-Disposition: inline
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

Greetings,

There is a new patch for alsa-driver/pci/asihpi  here
http://audioscience.com/internet/download/alsa_driver3282_asihpi30704.patch

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

The accompanying patch also requires updated firmware 
http://audioscience.com/internet/download/firmware/asihpi_firmware-3.07.04.tar.bz2

Based on
http://audioscience.com/internet/download/hpklinux-3.07.04.tar.bz2
Release notes
http://audioscience.com/internet/download/drvnotes.txt
http://audioscience.com/internet/download/drvnotes_rc.txt

Main points
The bulk of this patch is addition of doxygen documentation to hpi.h and 
hpifunc.c. (hopefully coming to the end of this soon)

Add several new adapter types ASI6618, ASI6518. ASI8900
Bug fixes to ASI6416 DSP code
Filtered out some more conditionally not compiled for ALSA.

asihpi.c: experimental MMAP mode (disabled)
hpidebug.h: simplify debug macros
hpios_linux_kernel.h:  remove a layer of macros wrapping spinlocks
hpicmn.c: pull more common code from hpi backends
hpifunc.c: remove more obsolete functions
hpimsgx.c: remove dead code
hpios.h pOsReference now struct pci_dev* not void*
hpi6205.c: use power of 2 buffers (REQUIRES matching firmware)

--
Eliot
