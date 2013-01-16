From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: hda - do not add non-existing Mic
	boost controls
Date: Wed, 16 Jan 2013 15:58:43 +0100
Message-ID: <1358348325-308-2-git-send-email-david.henningsson@canonical.com>
References: <1358348325-308-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A0FE62616D2
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 15:58:43 +0100 (CET)
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

If the input node does not have any volume capable input amp,
don't add such a control.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 3ef38da..72325a9 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2820,6 +2820,9 @@ static int parse_mic_boost(struct hda_codec *codec)
 			struct nid_path *path;
 			unsigned int val;
 
+			if (!nid_has_volume(codec, nid, HDA_INPUT))
+				continue;
+
 			label = hda_get_autocfg_input_label(codec, cfg, i);
 			if (prev_label && !strcmp(label, prev_label))
 				type_idx++;
-- 
1.7.9.5
