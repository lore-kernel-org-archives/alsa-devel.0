From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - simplify azx_has_pm_runtime
Date: Wed, 15 Apr 2015 13:29:05 +0200
Message-ID: <1429097345-8303-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B3232605F9
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 13:29:02 +0200 (CEST)
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

Because AZX_DCAPS_PM_RUNTIME is always defined as non-zero, the
initial part of the expression can be skipped.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_controller.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index be1b7de..0efdb09 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -404,7 +404,7 @@ struct azx {
 	((chip)->ops->reg_readb((dev)->sd_addr + AZX_REG_##reg))
 
 #define azx_has_pm_runtime(chip) \
-	(!AZX_DCAPS_PM_RUNTIME || ((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME))
+	((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME)
 
 /* PCM setup */
 static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
-- 
1.9.1
