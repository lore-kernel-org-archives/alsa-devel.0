From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: removed unneeded hp_nid references.
Date: Fri, 05 Sep 2008 17:06:19 -0400
Message-ID: <48C19F4B.90607@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id A3280246E6
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 23:06:30 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Removed unneeded hp_nid references for 92hd73xx codec family.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 6ad6ef3..5b715a7 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -3775,17 +3775,14 @@ again:

 	switch (spec->multiout.num_dacs) {
 	case 0x3: /* 6 Channel */
-		spec->multiout.hp_nid = 0x17;
 		spec->mixer = stac92hd73xx_6ch_mixer;
 		spec->init = stac92hd73xx_6ch_core_init;
 		break;
 	case 0x4: /* 8 Channel */
-		spec->multiout.hp_nid = 0x18;
 		spec->mixer = stac92hd73xx_8ch_mixer;
 		spec->init = stac92hd73xx_8ch_core_init;
 		break;
 	case 0x5: /* 10 Channel */
-		spec->multiout.hp_nid = 0x19;
 		spec->mixer = stac92hd73xx_10ch_mixer;
 		spec->init = stac92hd73xx_10ch_core_init;
 	};
