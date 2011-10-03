From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix naming of input jacks for IDT
	parser
Date: Mon, 03 Oct 2011 16:45:00 +0200
Message-ID: <4E89CA6C.7030800@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040603080804090909080905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9EFDE243BE
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 16:45:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040603080804090909080905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Actually, it's just Sigmatel that wants to make things its own way, 
making life harder for us in userspace. Make the driver more uniform by 
removing this code.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040603080804090909080905
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-naming-of-input-jacks-for-IDT-parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-naming-of-input-jacks-for-IDT-parser.patch"

>From c883421ded828cec42ab90e55b36811593f2012e Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 3 Oct 2011 16:25:42 +0200
Subject: [PATCH] ALSA: HDA: Fix naming of input jacks for IDT parser

The Sigmatel/IDT parser should have the same naming convention 
for input jacks as the other codecs have.

BugLink: http://bugs.launchpad.net/bugs/859704
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 987e3cf..dd977b6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4130,22 +4130,14 @@ static int stac92xx_add_jack(struct hda_codec *codec,
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 	int def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	int connectivity = get_defcfg_connect(def_conf);
-	char name[32];
-	int err;
 
 	if (connectivity && connectivity != AC_JACK_PORT_FIXED)
 		return 0;
 
-	snprintf(name, sizeof(name), "%s at %s %s Jack",
-		snd_hda_get_jack_type(def_conf),
-		snd_hda_get_jack_connectivity(def_conf),
-		snd_hda_get_jack_location(def_conf));
-
-	err = snd_hda_input_jack_add(codec, nid, type, name);
-	if (err < 0)
-		return err;
-#endif /* CONFIG_SND_HDA_INPUT_JACK */
+	return snd_hda_input_jack_add(codec, nid, type, NULL);
+#else
 	return 0;
+#endif /* CONFIG_SND_HDA_INPUT_JACK */
 }
 
 static int stac_add_event(struct sigmatel_spec *spec, hda_nid_t nid,
-- 
1.7.5.4


--------------040603080804090909080905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040603080804090909080905--
