From: Zinx Verituse <zinx@epicsol.org>
Subject: patch, and other via82xx (VT8235) capture problems
Date: Wed, 22 Oct 2003 23:48:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031023044843.GA19701@bliss>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've attached a patch to fix a bug in the via82xx driver,
but I suspect the register is wrong for the VT8235 because
when I set the Input Source to 'Mic', no interrupts seem
to be getting triggered:

arecord: pcm_read:1110: read error: Input/output error

But as 'Line', it works (albeit with significantly reduced voltage and volume)

Are the specs for the VT8235 available anywhere?

Useful info:
Kernel: Linux 2.6.0-test7 (patched bug exists in CVS tree, too)
On-board sound card: 00:11.5 Class 0401: 1106:3059 (rev 50)
Motherboard: A7V333-X

-- 
Zinx Verituse

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-2.6.0-test7-via82xx-capture-source-fix.diff"

--- linux-2.6.0-test7/sound/pci/via82xx.c.orig	2003-10-22 23:09:56.000000000 -0500
+++ linux-2.6.0-test7/sound/pci/via82xx.c	2003-10-22 23:05:48.000000000 -0500
@@ -1382,7 +1382,7 @@
 static int snd_via8233_capture_source_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long port = chip->port + kcontrol->id.index ? (VIA_REG_CAPTURE_CHANNEL + 0x10) : VIA_REG_CAPTURE_CHANNEL;
+	unsigned long port = chip->port + (kcontrol->id.index ? (VIA_REG_CAPTURE_CHANNEL + 0x10) : VIA_REG_CAPTURE_CHANNEL);
 	ucontrol->value.enumerated.item[0] = inb(port) & VIA_REG_CAPTURE_CHANNEL_MIC ? 1 : 0;
 	return 0;
 }
@@ -1390,7 +1390,7 @@
 static int snd_via8233_capture_source_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned long port = chip->port + kcontrol->id.index ? (VIA_REG_CAPTURE_CHANNEL + 0x10) : VIA_REG_CAPTURE_CHANNEL;
+	unsigned long port = chip->port + (kcontrol->id.index ? (VIA_REG_CAPTURE_CHANNEL + 0x10) : VIA_REG_CAPTURE_CHANNEL);
 	unsigned long flags;
 	u8 val, oval;
 

--PEIAKu/WMn1b1Hv9--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
