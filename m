From: bgoswami@codeaurora.org
Subject: [PATCH 3/3] ALSA: jack: add switch event for
	unsupported jack types
Date: Fri, 24 May 2019 13:40:50 -0700
Message-ID: <1558730450-16580-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35000F8962F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 22:50:54 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, plai@codeaurora.org, Gopikrishnaiah Anandan <agopik@codeaurora.org>, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Banajit Goswami <bgoswami@codeaurora.org>

Add a jack switch event to report unsupported plug type.
This event can be used to report a headset or an extension
cable with GND/MIC swap etc., which may not be supported by
the device.

Signed-off-by: Gopikrishnaiah Anandan <agopik@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/core/jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 36b047b..4c21e48 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -40,6 +40,7 @@ struct snd_jack_kctl {
 	SW_JACK_PHYSICAL_INSERT,
 	SW_VIDEOOUT_INSERT,
 	SW_LINEIN_INSERT,
+	SW_UNSUPPORT_INSERT,
 };
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
