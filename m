From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: via82xx: DXS channels
Date: Tue, 13 Jan 2004 00:33:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040112223351.GA8592@onion.home.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi!

I tested DXS channels of my via82xx chip.  My motherboard is ASRock
K7VT2 and the kernel is 2.6.1-mm2.

With dxs_support=1 option DXS channels did not work (bad sound quality)
but they did with dxs_support=4.

I noticed the volume ranges for DXS channels are wrong (0-255),
should be 0-31.  Here is a patch which fixes the problem and adds
ASRock K7VT2 to the dxs_whitelist.  I don't know if this works on other
motherboards!

   Timo
--kORqDWCi7qDJ0mEj
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="via82xx.patch"

--- sound/pci/via82xx.c.orig	2004-01-12 15:56:21.000000000 +0200
+++ sound/pci/via82xx.c	2004-01-13 00:12:48.721787059 +0200
@@ -1481,7 +1481,7 @@ static int snd_via8233_dxs_volume_info(s
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 0xff;
+	uinfo->value.integer.max = 31;
 	return 0;
 }
 
@@ -1489,8 +1489,8 @@ static int snd_via8233_dxs_volume_get(sn
 {
 	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int idx = snd_ctl_get_ioff(kcontrol, &ucontrol->id);
-	ucontrol->value.integer.value[0] = 0xff - chip->playback_volume[idx][0];
-	ucontrol->value.integer.value[1] = 0xff - chip->playback_volume[idx][1];
+	ucontrol->value.integer.value[0] = 31 - chip->playback_volume[idx][0];
+	ucontrol->value.integer.value[1] = 31 - chip->playback_volume[idx][1];
 	return 0;
 }
 
@@ -1502,13 +1502,13 @@ static int snd_via8233_dxs_volume_put(sn
 	unsigned char val;
 	int change;
 
-	val = 0xff - ucontrol->value.integer.value[0];
+	val = 31 - ucontrol->value.integer.value[0];
 	change = val != chip->playback_volume[idx][0];
 	if (change) {
 		chip->playback_volume[idx][0] = val;
 		outb(val, port + VIA_REG_OFS_PLAYBACK_VOLUME_L);
 	}
-	val = 0xff - ucontrol->value.integer.value[1];
+	val = 31 - ucontrol->value.integer.value[1];
 	change |= val != chip->playback_volume[idx][1];
 	if (change) {
 		chip->playback_volume[idx][1] = val;
@@ -1986,6 +1986,7 @@ static int __devinit check_dxs_list(stru
 		{ .vendor = 0x1043, .device = 0x80a1, .action = VIA_DXS_NO_VRA }, /* ASUS A7V8-X */
 		{ .vendor = 0x1043, .device = 0x80b0, .action = VIA_DXS_ENABLE }, /* ASUS A7V600 */
 		{ .vendor = 0x10cf, .device = 0x118e, .action = VIA_DXS_ENABLE }, /* FSC laptop */
+		{ .vendor = 0x1106, .device = 0x4161, .action = VIA_DXS_NO_VRA }, /* ASRock K7VT2 */
 		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
 		{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_ENABLE }, /* Gigabyte GA-7VAXP */
 		{ .vendor = 0x147b, .device = 0x1401, .action = VIA_DXS_ENABLE }, /* ABIT KD7(-RAID) */

--kORqDWCi7qDJ0mEj--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
