From: Rolf Stefan Wilke <stefan.wilke@uni-ulm.de>
Subject: [PATCH] Emu10k1 - STAC9758 (fixes #2308)
Date: Mon, 5 Feb 2007 19:16:35 +0100
Message-ID: <200702051916.35353.stefan.wilke@uni-ulm.de>
Reply-To: stefan.wilke@uni-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
Cc: James@superbug.demon.co.uk
List-Id: alsa-devel@alsa-project.org

The following patch fixes bug #2308 [no sound on front channel for 
emu10k1 - sigmatel STAC9758]; at least for me. Thanks to Raymond at bugtrack!

	Stefan

--- alsa-driver-1.0.14rc2.orig/alsa-kernel/pci/emu10k1/emumixer.c       
2007-01-15 14:25:27.000000000 +0100
+++ alsa-driver-1.0.14rc2/alsa-kernel/pci/emu10k1/emumixer.c    2007-02-05 
19:10:48.000000000 +0100
@@ -1582,6 +1582,7 @@
                        if (emu->ac97->id == AC97_ID_STAC9758) {
                                emu->rear_ac97 = 1;
                                snd_emu10k1_ptr_write(emu, AC97SLOT, 0, 
AC97SLOT_CNTR|AC97SLOT_LFE|AC97SLOT_REAR_LEFT|AC97SLOT_REAR_RIGHT);
+                               snd_ac97_write_cache(emu->ac97, 0x04, 0x0202);
                        }
                        /* remove unused AC97 controls */
                        snd_ac97_write_cache(emu->ac97, AC97_SURROUND_MASTER, 
0x0202);

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
