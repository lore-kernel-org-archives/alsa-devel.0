From: Rolf Stefan Wilke <stefan.wilke@uni-ulm.de>
Subject: Re: [PATCH] Emu10k1 - STAC9758 (fixes #2308)
Date: Tue, 6 Feb 2007 19:10:03 +0100
Message-ID: <200702061910.03320.stefan.wilke@uni-ulm.de>
References: <200702051916.35353.stefan.wilke@uni-ulm.de>
	<s5h7iuvy1bk.wl%tiwai@suse.de>
Reply-To: stefan.wilke@uni-ulm.de
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7RMyFDoWGtnKRzZ"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7iuvy1bk.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_7RMyFDoWGtnKRzZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your answer. I hope this is a more appropriate description; if not, 
let me know. I'm unexperienced, yet eager to learn ;-)

Summary: The following patch (hopefully) fixes bug #2308 for users of STAC9758

For some time now, some users of STAC9758 (emu10k1) would have no sound on 
their front channels. This can be fixed (at least for me) by unmuting  head 
phone volume and setting it to 0dB before removing the "Front Playback" 
control. For details, cf.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2308
Find the appropriate patch attached.

Credits to: Raymond

Signed-off-by: Rolf Stefan Wilke <stefan.wilke@uni-ulm.de>

 


--Boundary-00=_7RMyFDoWGtnKRzZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="emumixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="emumixer.patch"

--- alsa-driver-1.0.14rc2.orig/alsa-kernel/pci/emu10k1/emumixer.c	2007-01-15 14:25:27.000000000 +0100
+++ alsa-driver-1.0.14rc2/alsa-kernel/pci/emu10k1/emumixer.c	2007-02-06 18:34:51.000000000 +0100
@@ -1582,6 +1582,7 @@
 			if (emu->ac97->id == AC97_ID_STAC9758) {
 				emu->rear_ac97 = 1;
 				snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE|AC97SLOT_REAR_LEFT|AC97SLOT_REAR_RIGHT);
+				snd_ac97_write_cache(emu->ac97, AC97_HEADPHONE, 0x0202);
 			}
 			/* remove unused AC97 controls */
 			snd_ac97_write_cache(emu->ac97, AC97_SURROUND_MASTER, 0x0202);

--Boundary-00=_7RMyFDoWGtnKRzZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_7RMyFDoWGtnKRzZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_7RMyFDoWGtnKRzZ--
