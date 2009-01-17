From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: fix invalid power mapping masks
Date: Sat, 17 Jan 2009 18:47:27 -0500
Message-ID: <49726E0F.7080707@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id CC7671037F4
	for <alsa-devel@alsa-project.org>; Sun, 18 Jan 2009 00:47:40 +0100 (CET)
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

Fixed invalid power mappings for ports 0xd and 0xe on 93hd83xxx codecs.
They were shifted right one too many bits.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index faef1ca..a4d4afe 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -334,7 +334,7 @@ static hda_nid_t stac92hd83xxx_slave_dig_outs[2] = {
 };
 
 static unsigned int stac92hd83xxx_pwr_mapping[4] = {
-	0x03, 0x0c, 0x10, 0x40,
+	0x03, 0x0c, 0x20, 0x80,
 };
 
 static hda_nid_t stac92hd83xxx_amp_nids[1] = {
