From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Special AC97 patch for ASUS W1000/CMI9739 laptop.
Date: Sun, 23 Jan 2005 16:14:04 +0000
Message-ID: <41F3CD4C.6090506@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010003090401040600000905"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010003090401040600000905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes sound output on the ASUS W1000 laptop with the CMI9739 
chip. It wrongly reports that it has a SPDIF in, when in fact we wish to 
use the EAPD pin.

Signed off: James@superbug.demon.co.uk

--------------010003090401040600000905
Content-Type: text/plain;
 name="disable-spdif-in2.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disable-spdif-in2.diff.txt"

Index: alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.70
diff -u -r1.70 ac97_patch.c
--- alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c	20 Jan 2005 11:43:19 -0000	1.70
+++ alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c	23 Jan 2005 16:04:31 -0000
@@ -1916,6 +1916,15 @@
 	/* FIXME: set up GPIO */
 	snd_ac97_write_cache(ac97, 0x70, 0x0100);
 	snd_ac97_write_cache(ac97, 0x72, 0x0020);
+	/* Special exception for ASUS W1000/CMI9739. It does not have an SPDIF in. */
+	if (ac97->pci &&
+	     ac97->subsystem_vendor == 0x1043 &&
+	     ac97->subsystem_device == 0x1843) {
+		snd_ac97_write_cache(ac97, AC97_CM9739_SPDIF_CTRL,
+			snd_ac97_read(ac97, AC97_CM9739_SPDIF_CTRL) & ~0x01);
+		snd_ac97_write_cache(ac97, AC97_CM9739_MULTI_CHAN,
+			snd_ac97_read(ac97, AC97_CM9739_MULTI_CHAN) | (1 << 14));
+	}
 
 	return 0;
 }

--------------010003090401040600000905--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
