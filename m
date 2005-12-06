From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Subject: [PATCH] add support for ALC880 8196
Date: Tue, 6 Dec 2005 11:20:07 -0200
Message-ID: <564d96fb0512060520q7647727cld0e932582829a985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1926_24452779.1133875207724"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.203])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BD441A4
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 14:20:08 +0100 (MET)
Received: by xproxy.gmail.com with SMTP id i31so20844wxd
        for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2005 05:20:07 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_1926_24452779.1133875207724
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have an ASUS P5GD1-HVM (=3D=3D P5GD1-VM ?). It has a ALC800 with
pci_subdevice =3D 8196.  It is almost equal to a ALC880_6ST. In the
attached patch I have changed the definition of alc880_six_stack_mixer
a little bit to match the card pins. I don't know if this change is
valid. If it isn't I can submit a new patch that puts the 8196 in a
category of its own.

I have tested the patch by plugging a headphone to each output pin and
tested both the mute and the volume controls of the left and right
channel individually.

Rafael =C1vila de Esp=EDndola

------=_Part_1926_24452779.1133875207724
Content-Type: application/octet-stream; name=alsa.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa.patch"

Index: alsa-kernel/pci/hda/patch_realtek.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_realtek.c,v
retrieving revision 1.37
diff -u -3 -p -u -r1.37 patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c	5 Dec 2005 19:42:22 -0000	1.37
+++ alsa-kernel/pci/hda/patch_realtek.c	6 Dec 2005 13:04:27 -0000
@@ -513,12 +513,10 @@ static struct hda_channel_mode alc880_si
 static struct snd_kcontrol_new alc880_six_stack_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Rear Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Rear Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Center Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Center Playback Switch", 0x0e, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
@@ -1657,6 +1655,7 @@ static struct hda_board_config alc880_cf
 	{ .modelname = "6stack", .config = ALC880_6ST },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x81b4, .config = ALC880_6ST },
 	{ .pci_subvendor = 0x1019, .pci_subdevice = 0xa884, .config = ALC880_6ST }, /* Acer APFV */
+	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x8196, .config = ALC880_6ST },
 
 	{ .modelname = "6stack-digout", .config = ALC880_6ST_DIG },
 	{ .pci_subvendor = 0x2668, .pci_subdevice = 0x8086, .config = ALC880_6ST_DIG },






------=_Part_1926_24452779.1133875207724--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
