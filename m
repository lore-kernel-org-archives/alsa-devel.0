From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: use GFP_KERNEL
	instead of GFP_ATOMIC
Date: Tue, 18 Jun 2019 15:04:26 +0800
Message-ID: <20190618070426.35405-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22E58F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 09:04:48 +0200 (CEST)
Received: by mail-qt1-x84a.google.com with SMTP id i9so8880841qtc.15
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 00:04:48 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: dgreid@google.com, alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com, cychiang@google.com, tzungbi@google.com
List-Id: alsa-devel@alsa-project.org

Change the memory allocation flag from GFP_ATOMIC to GFP_KERNEL because
probe of platform device is unlikely a place where cannot sleep.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
It might be a typo introduced from copied-and-pasted.

 sound/soc/intel/boards/sof_rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index e2e5f97d9920..02138aa8a850 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -498,7 +498,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 	int dmic_num, hdmi_num;
 	int ret, ssp_amp, ssp_codec;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
2.22.0.410.gd8fdbe21b5-goog
