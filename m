From: Rajan Vaja <rajan.vaja@gmail.com>
Subject: [PATCH] ASoC: mop500_ab8500: Add a NULL pointer check
	in mop500_ab8500_machine_init()
Date: Wed, 20 May 2015 10:20:54 +0530
Message-ID: <1432097454-3643-1-git-send-email-rajan.vaja@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B55E826043E
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 06:51:06 +0200 (CEST)
Received: by padbw4 with SMTP id bw4so52771841pad.0
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:51:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rajan.vaja@gmail.com, lars@metafoo.de, tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Avoid possible crash (NULL pointer dereference) by making
sure that dem_kzalloc() is successful.

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
---
 sound/soc/ux500/mop500_ab8500.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index b81a7a4c..85d810d 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -372,6 +372,10 @@ int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
 	/* Create driver private-data struct */
 	drvdata = devm_kzalloc(dev, sizeof(struct mop500_ab8500_drvdata),
 			GFP_KERNEL);
+
+	if (!drvdata)
+		return -ENOMEM;
+
 	snd_soc_card_set_drvdata(rtd->card, drvdata);
 
 	/* Setup clocks */
-- 
1.7.9.5
