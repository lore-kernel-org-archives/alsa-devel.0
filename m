From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - Make sure fill_all_dac_nids is
	called for digital only codecs
Date: Wed, 16 Jan 2013 15:58:45 +0100
Message-ID: <1358348325-308-4-git-send-email-david.henningsson@canonical.com>
References: <1358348325-308-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F2C264EAA
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 15:58:44 +0100 (CET)
In-Reply-To: <1358348325-308-1-git-send-email-david.henningsson@canonical.com>
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

Otherwise no PCM will be built for codecs without analog I/O.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index a05cbab..e671c77 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1510,8 +1510,6 @@ static int parse_output_paths(struct hda_codec *codec)
 	bool best_wired = true, best_mio = true;
 	bool hp_spk_swapped = false;
 
-	fill_all_dac_nids(codec);
-
 	best_cfg = kmalloc(sizeof(*best_cfg), GFP_KERNEL);
 	if (!best_cfg)
 		return -ENOMEM;
@@ -3422,6 +3420,8 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 		cfg = &spec->autocfg;
 	}
 
+	fill_all_dac_nids(codec);
+
 	if (!cfg->line_outs) {
 		if (cfg->dig_outs || cfg->dig_in_pin) {
 			spec->multiout.max_channels = 2;
-- 
1.7.9.5
