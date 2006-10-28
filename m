From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH] fix emu10k1 build in 1.0.13
Date: Sat, 28 Oct 2006 23:34:41 +0200
Message-ID: <20061028213441.GA797@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4134528F
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Oct 2006 23:34:27 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: "Gabor Z. Papp" <gzp@papp.hu>
List-Id: alsa-devel@alsa-project.org

Hi guys,

Gabor Z.Papp reported to me that alsa-driver-1.0.13 did not build under
2.4.34-pre4. I found there was a missing export-objs in the emu10k1
Makefile. This trivial patch fixes it.

Regards,
Willy

--- ./alsa-kernel/pci/emu10k1/Makefile.bad	2006-09-29 13:40:35 +0200
+++ ./alsa-kernel/pci/emu10k1/Makefile	2006-10-18 09:51:22 +0200
@@ -9,6 +9,8 @@
 snd-emu10k1-synth-objs := emu10k1_synth.o emu10k1_callback.o emu10k1_patch.o
 snd-emu10k1x-objs := emu10k1x.o
 
+export-objs := io.o memory.o voice.o
+
 #
 # this function returns:
 #   "m" - CONFIG_SND_SEQUENCER is m



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
