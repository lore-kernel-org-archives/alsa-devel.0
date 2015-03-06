From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ALSA: ac97: ac97_patch: Simplify
	patch_vt1613_specific()
Date: Fri,  6 Mar 2015 13:41:42 -0300
Message-ID: <1425660102-5419-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DA9265DE2
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 17:41:55 +0100 (CET)
Received: by qcvs11 with SMTP id s11so17724596qcv.7
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 08:41:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Fabio Estevam <fabio.estevam@freescale.com>, mail@maciej.szmigiero.name, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

We can simplify the code by returning patch_build_controls() directly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/pci/ac97/ac97_patch.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index eca2210..f4234ed 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -3360,14 +3360,8 @@ AC97_SINGLE("DC Offset removal", 0x5a, 10, 1, 0),
 
 static int patch_vt1613_specific(struct snd_ac97 *ac97)
 {
-	int err;
-
-	err = patch_build_controls(ac97, &snd_ac97_controls_vt1613[0],
-				ARRAY_SIZE(snd_ac97_controls_vt1613));
-	if (err)
-		return err;
-
-	return 0;
+	return patch_build_controls(ac97, &snd_ac97_controls_vt1613[0],
+				    ARRAY_SIZE(snd_ac97_controls_vt1613));
 };
 
 static const struct snd_ac97_build_ops patch_vt1613_ops = {
-- 
1.9.1
