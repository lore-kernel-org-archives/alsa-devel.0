From: Bastiaan Jacques <b.jacques@planet.nl>
Subject: [PATCH ALSA-CVS] Add support for VIA VT8251 (AC'97)
Date: Sun, 16 Apr 2006 04:10:35 +0200
Message-ID: <200604160410.35227.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Add support for VIA VT8251 AC'97. Includes a workaround which ensures sound 
won't stop playing after one second of playback.

Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>

---

This patch adds support for the VIA VT8251 chipset which embeds an ALC653 
AC'97 codec. The ALC653 is detected and works correctly with the ALC655 
driver already in-tree. VIA also ships chipsets by the same name with a HDA 
controller.

Fortunately, the VT8251/AC97 is a continuation of the VT823x series, which 
makes this patch almost trivial. One issue that has prevented the chip from 
working is that for reasons unknown to me, the status register 
becomes "inactive" after about 10 frames of playback. This causes the 
previously reported [1] halting of playback after a second.

The problem is solved by sending a VIA_REG_CTRL_START, which makes the channel 
status active again.

Comments are welcome!

Bastiaan

[1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1622

Index: pci/via82xx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx.c,v
retrieving revision 1.194
diff -u -p -r1.194 via82xx.c
--- pci/via82xx.c	23 Mar 2006 16:11:32 -0000	1.194
+++ pci/via82xx.c	16 Apr 2006 02:05:37 -0000
@@ -123,6 +123,7 @@ module_param(enable, bool, 0444);
 #define VIA_REV_8233A		0x40	/* 1 rec, 1 multi-pb, spdf */
 #define VIA_REV_8235		0x50	/* 2 rec, 4 pb, 1 multi-pb, spdif */
 #define VIA_REV_8237		0x60
+#define VIA_REV_8251		0x70
 
 /*
  *  Direct registers
@@ -863,8 +864,15 @@ static snd_pcm_uframes_t snd_via8233_pcm
 		status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
 
 	if (!(status & VIA_REG_STAT_ACTIVE)) {
-		res = 0;
-		goto unlock;
+		/* An apparent bug in the 8251 is worked around by sending
+		 * a REG_CTRL_START. */
+		if (chip->revision == VIA_REV_8251)
+			snd_via82xx_pcm_trigger(substream,
+						SNDRV_PCM_TRIGGER_START);
+		else {
+			res = 0;
+			goto unlock;
+		}
 	}
 	if (count & 0xffffff) {
 		idx = count >> 24;
@@ -2313,6 +2321,7 @@ static struct via823x_info via823x_cards
 	{ VIA_REV_8233A, "VIA 8233A", TYPE_VIA8233A },
 	{ VIA_REV_8235, "VIA 8235", TYPE_VIA8233 },
 	{ VIA_REV_8237, "VIA 8237", TYPE_VIA8233 },
+	{ VIA_REV_8251, "VIA 8251", TYPE_VIA8233 },
 };
 
 /*
@@ -2341,6 +2350,7 @@ static int __devinit check_dxs_list(stru
 		{ .subvendor = 0x1043, .subdevice = 0x810d, .action = VIA_DXS_SRC }, /* ASUS */
 		{ .subvendor = 0x1043, .subdevice = 0x812a, .action = VIA_DXS_SRC    }, /* ASUS A8V Deluxe */ 
 		{ .subvendor = 0x1043, .subdevice = 0x8174, .action = VIA_DXS_SRC    }, /* ASUS */
+		{ .subvendor = 0x1043, .subdevice = 0x81b9, .action = VIA_DXS_SRC    }, /* ASUS A8V-MX */
 		{ .subvendor = 0x1071, .subdevice = 0x8375, .action = VIA_DXS_NO_VRA }, /* Vobis/Yakumo/Mitac notebook */
 		{ .subvendor = 0x1071, .subdevice = 0x8399, .action = VIA_DXS_NO_VRA }, /* Umax AB 595T (VIA K8N800A - VT8237) */
 		{ .subvendor = 0x10cf, .subdevice = 0x118e, .action = VIA_DXS_ENABLE }, /* FSC laptop */
@@ -2461,6 +2471,8 @@ static int __devinit snd_via82xx_probe(s
 			strcpy(card->driver, "VIA8233A");
 		else if (revision >= VIA_REV_8237)
 			strcpy(card->driver, "VIA8237"); /* no slog assignment */
+		else if (revision >= VIA_REV_8251)
+			strcpy(card->driver, "VIA8251");
 		else
 			strcpy(card->driver, "VIA8233");
 		break;


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
