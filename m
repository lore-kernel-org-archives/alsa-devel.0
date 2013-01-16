From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: hda - Check array bounds in
	get_input_path
Date: Wed, 16 Jan 2013 11:45:35 +0100
Message-ID: <1358333137-9415-2-git-send-email-david.henningsson@canonical.com>
References: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D6A7A2625F6
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 11:45:36 +0100 (CET)
In-Reply-To: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
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

This gives us some additional safety.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 932e6a1..577acc4 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2397,8 +2397,16 @@ static int create_input_ctls(struct hda_codec *codec)
 static struct nid_path *get_input_path(struct hda_codec *codec, int adc_idx, int imux_idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	if (imux_idx < 0 || imux_idx >= HDA_MAX_NUM_INPUTS) {
+		snd_BUG();
+		return NULL;
+	}
 	if (spec->dyn_adc_switch)
 		adc_idx = spec->dyn_adc_idx[imux_idx];
+	if (adc_idx < 0 || adc_idx >= AUTO_CFG_MAX_OUTS) {
+		snd_BUG();
+		return NULL;
+	}
 	return snd_hda_get_path_from_idx(codec, spec->input_paths[imux_idx][adc_idx]);
 }
 
-- 
1.7.9.5
