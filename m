From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/5] ALSA: hda: Remove unused variable
Date: Tue,  1 Jul 2014 17:02:54 +0530
Message-ID: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id BAFB6261A7F
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 13:36:30 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id w10so9969218pde.17
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 04:36:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

'status' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
All patches in this series only compile tested.
---
 sound/pci/hda/hda_tegra.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index a366ba9293a8..8cd7b06eecef 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -272,13 +272,9 @@ static int hda_tegra_resume(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
-	int status;
 
 	hda_tegra_enable_clocks(hda);
 
-	/* Read STATESTS before controller reset */
-	status = azx_readw(chip, STATESTS);
-
 	hda_tegra_init(hda);
 
 	azx_init_chip(chip, 1);
-- 
1.7.9.5
