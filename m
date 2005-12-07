From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Subject: Re: [PATCH] add support for ALC880 8196
Date: Wed, 7 Dec 2005 11:39:33 -0200
Message-ID: <564d96fb0512070539h667d7c2x7fc8be395293c1ac@mail.gmail.com>
References: <564d96fb0512060520q7647727cld0e932582829a985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11699_24001238.1133962773138"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.198])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A813A171
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 14:39:34 +0100 (MET)
Received: by xproxy.gmail.com with SMTP id i31so215786wxd
        for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2005 05:39:33 -0800 (PST)
In-Reply-To: <564d96fb0512060520q7647727cld0e932582829a985@mail.gmail.com>
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

------=_Part_11699_24001238.1133962773138
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/6/05, Rafael Esp=EDndola <rafael.espindola@gmail.com> wrote:
> I have tested the patch by plugging a headphone to each output pin and
> tested both the mute and the volume controls of the left and right
> channel individually.
And that is why I didn't realized that LFE and Center are mono. When I
plugged the headphone one channel was in the left and the other in the
right. Duh!
My first 7.1 :)

A fixed patch is attached.

Ps.: IMHO "rear" is more descriptive (and is what is printed on the
plug) then "surround" in a 7.1 system.

Rafael

------=_Part_11699_24001238.1133962773138
Content-Type: application/octet-stream; name=alsa.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa.patch"

Index: alsa-kernel/pci/hda/patch_realtek.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_realtek.c,v
retrieving revision 1.37
diff -u -3 -p -u -r1.37 patch_realtek.c
--- alsa-kernel/pci/hda/patch_realtek.c	5 Dec 2005 19:42:22 -0000	1.37
+++ alsa-kernel/pci/hda/patch_realtek.c	7 Dec 2005 13:21:51 -0000
@@ -513,8 +513,8 @@ static struct hda_channel_mode alc880_si
 static struct snd_kcontrol_new alc880_six_stack_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Rear Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Rear Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
@@ -1657,6 +1657,7 @@ static struct hda_board_config alc880_cf
 	{ .modelname = "6stack", .config = ALC880_6ST },
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x81b4, .config = ALC880_6ST },
 	{ .pci_subvendor = 0x1019, .pci_subdevice = 0xa884, .config = ALC880_6ST }, /* Acer APFV */
+	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x8196, .config = ALC880_6ST },
 
 	{ .modelname = "6stack-digout", .config = ALC880_6ST_DIG },
 	{ .pci_subvendor = 0x2668, .pci_subdevice = 0x8086, .config = ALC880_6ST_DIG },



------=_Part_11699_24001238.1133962773138--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
