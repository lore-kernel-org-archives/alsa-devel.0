From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/15] ALSA: hda - Add Conexant CX20751/2/3/4
	codec support
Date: Mon, 14 May 2012 17:32:02 +0200
Message-ID: <1337009526-26256-12-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D52D24A22
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E7E8390B1D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
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

These are almost compatible with the older Conexant codecs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 2cfcec0..a03fc33 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4559,6 +4559,10 @@ static int patch_conexant_auto(struct hda_codec *codec)
  */
 
 static const struct hda_codec_preset snd_hda_preset_conexant[] = {
+	{ .id = 0x14f11510, .name = "CX20751/2",
+	  .patch = patch_conexant_auto },
+	{ .id = 0x14f11511, .name = "CX20753/4",
+	  .patch = patch_conexant_auto },
 	{ .id = 0x14f15045, .name = "CX20549 (Venice)",
 	  .patch = patch_cxt5045 },
 	{ .id = 0x14f15047, .name = "CX20551 (Waikiki)",
@@ -4596,6 +4600,8 @@ static const struct hda_codec_preset snd_hda_preset_conexant[] = {
 	{} /* terminator */
 };
 
+MODULE_ALIAS("snd-hda-codec-id:14f11510");
+MODULE_ALIAS("snd-hda-codec-id:14f11511");
 MODULE_ALIAS("snd-hda-codec-id:14f15045");
 MODULE_ALIAS("snd-hda-codec-id:14f15047");
 MODULE_ALIAS("snd-hda-codec-id:14f15051");
-- 
1.7.9.2
