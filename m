From: Simon Munton <simon-alsa@munton.demon.co.uk>
Subject: Patch for Dell Precision 530 and Dell Dimension 8300
Date: Sat, 20 Sep 2003 19:51:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309201951.06767.simon-alsa@munton.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using alsa 0.9.6 on a Dell Precision 530 and a Dell Dimension 8300, and I 
need to use the patch below to get the volume controls to correspond to the 
correct speakers.


--- alsa-kernel/pci/intel8x0.c.orig	2003-07-24 06:53:57.000000000 +0100
+++ alsa-kernel/pci/intel8x0.c	2003-09-13 21:11:45.000000000 +0100
@@ -1562,6 +1562,8 @@
 	{ 0x8086, 0x4d44, "Intel D850EMV2", AC97_TUNE_HP_ONLY },
 	/* { 0x4144, 0x5360, "AMD64 Motherboard", AC97_TUNE_HP_ONLY }, */ /* FIXME: 
this seems invalid */
 	{ 0x1043, 0x80b0, "ASUS P4PE Mobo", AC97_TUNE_SWAP_SURROUND },
+	{ 0x1028, 0x00d8, "Dell Precision 530", AC97_TUNE_HP_ONLY },
+	{ 0x1028, 0x0157, "Dell Dimension 8300", AC97_TUNE_SWAP_SURROUND },
 	{ } /* terminator */
 };




Any chance of this being added to the next release?

--
Simon Munton



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
