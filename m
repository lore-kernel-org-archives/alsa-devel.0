From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: oxygen: Xonar DG(X): make model_xonar_dg
	const
Date: Thu, 14 Sep 2017 19:34:15 +0530
Message-ID: <1505397855-10618-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FEFF266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 16:04:39 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id g65so1552243pfe.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 07:04:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it not modified anywhere. It is only used during a
copy operation. Also, add const to the declaration in header.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/oxygen/xonar_dg.h       | 2 +-
 sound/pci/oxygen/xonar_dg_mixer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index d461df3..5a07cda 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -51,6 +51,6 @@ void dump_cs4245_registers(struct oxygen *chip,
 void dg_resume(struct oxygen *chip);
 void dg_cleanup(struct oxygen *chip);
 
-extern struct oxygen_model model_xonar_dg;
+extern const struct oxygen_model model_xonar_dg;
 
 #endif
diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index b885dac..d22fbe8 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -449,7 +449,7 @@ static int dg_mixer_init(struct oxygen *chip)
 	return 0;
 }
 
-struct oxygen_model model_xonar_dg = {
+const struct oxygen_model model_xonar_dg = {
 	.longname = "C-Media Oxygen HD Audio",
 	.chip = "CMI8786",
 	.init = dg_init,
-- 
1.9.1
