From: =?ISO-8859-1?Q?Jonathan_Ph=E9nix?= <jonathan@linuxant.com>
Subject: [PATCH] Output MFG information for HDA devices
Date: Thu, 14 Jun 2007 16:35:53 -0400
Message-ID: <4671A6A9.2080201@linuxant.com>
Reply-To: jonathan@linuxant.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090003050309010100000101"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oasis.linuxant.com (oasis.linuxant.com [63.246.136.80])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E256247C7
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 22:35:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090003050309010100000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

this patch output information about the MFG (Modem Function Group) to=20
the /proc/asound/card?/codec#? file. This information is important to=20
identify if a HDA device has a modem or not.

Regards,

Jonathan Ph=E9nix
Technical specialist / Linuxant
www.linuxant.com
jonathan@linuxant.com



--------------090003050309010100000101
Content-Type: text/x-patch;
 name="alsa-hg-mfg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-hg-mfg.patch"

searching for changes
changeset:   5106:c63e54409236
tag:         tip
user:        root@silver
date:        Thu Jun 14 13:48:53 2007 -0400
summary:     Added MFG in HDA /proc output

diff -r 96495fe7cc13 -r c63e54409236 pci/hda/hda_proc.c
--- a/pci/hda/hda_proc.c	Thu Jun 14 12:58:23 2007 +0200
+++ b/pci/hda/hda_proc.c	Thu Jun 14 13:48:53 2007 -0400
@@ -250,6 +250,12 @@ static void print_codec_info(struct snd_
 	snd_iprintf(buffer, "Vendor Id: 0x%x\n", codec->vendor_id);
 	snd_iprintf(buffer, "Subsystem Id: 0x%x\n", codec->subsystem_id);
 	snd_iprintf(buffer, "Revision Id: 0x%x\n", codec->revision_id);
+
+	if (codec->mfg)
+		snd_iprintf(buffer, "Modem Function Group: 0x%x\n", codec->mfg);
+	else
+		snd_iprintf(buffer, "No Modem Function Group found\n");
+
 	if (! codec->afg)
 		return;
 	snd_iprintf(buffer, "Default PCM:\n");


--------------090003050309010100000101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090003050309010100000101--
