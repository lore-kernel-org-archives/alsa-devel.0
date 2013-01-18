From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - don't compare with yourself in
	fill_input_pin_labels
Date: Fri, 18 Jan 2013 15:43:02 +0100
Message-ID: <1358520183-2908-3-git-send-email-david.henningsson@canonical.com>
References: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 566C0265F3F
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 15:43:03 +0100 (CET)
In-Reply-To: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
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

Just stumbled over this one while reading the code.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 13e13df..a5b87c5 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2555,7 +2555,7 @@ static int fill_input_pin_labels(struct hda_codec *codec)
 
 		label = hda_get_autocfg_input_label(codec, cfg, i);
 		idx = 0;
-		for (j = i; j >= 0; j--) {
+		for (j = i-1; j >= 0; j--) {
 			if (spec->input_labels[j] &&
 			    !strcmp(spec->input_labels[j], label)) {
 				idx = spec->input_label_idxs[j] + 1;
-- 
1.7.9.5
