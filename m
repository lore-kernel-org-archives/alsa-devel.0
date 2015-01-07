From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Print codec->chip_name in
	autoconfig
Date: Wed,  7 Jan 2015 14:41:58 +0100
Message-ID: <1420638119-20885-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E8B32604BB
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 14:42:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This will help end users figure out what HDA codec they have.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 1ede822..6ec3775 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -409,10 +409,10 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	/*
 	 * debug prints of the parsed results
 	 */
-	codec_info(codec, "autoconfig: line_outs=%d (0x%x/0x%x/0x%x/0x%x/0x%x) type:%s\n",
-		   cfg->line_outs, cfg->line_out_pins[0], cfg->line_out_pins[1],
-		   cfg->line_out_pins[2], cfg->line_out_pins[3],
-		   cfg->line_out_pins[4],
+	codec_info(codec, "autoconfig for %s: line_outs=%d (0x%x/0x%x/0x%x/0x%x/0x%x) type:%s\n",
+		   codec->chip_name, cfg->line_outs, cfg->line_out_pins[0],
+		   cfg->line_out_pins[1], cfg->line_out_pins[2],
+		   cfg->line_out_pins[3], cfg->line_out_pins[4],
 		   cfg->line_out_type == AUTO_PIN_HP_OUT ? "hp" :
 		   (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT ?
 		    "speaker" : "line"));
-- 
1.9.1
