From: bgoswami@codeaurora.org
Subject: [PATCH 1/3] ALSA: jack: Remove hard coding of
	jack_switch_types array size
Date: Fri, 24 May 2019 13:40:23 -0700
Message-ID: <1558730423-16490-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A6EAF806F7
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

The size for jack_switch_types array is currently controlled by
a MACRO 'SND_JACK_SWITCH_TYPES', whose value needs to be updated
everytime a new jack switch type is added. Remove this MACRO
and use ARRAY_SIZE instead to get size of the array.

Signed-off-by: Gopikrishnaiah Anandan <agopik@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 include/sound/jack.h | 3 ---
 sound/core/jack.c    | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 1e84bfb..b0791c5 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -68,9 +68,6 @@ enum snd_jack_types {
 	SND_JACK_BTN_5		= 0x0200,
 };
 
-/* Keep in sync with definitions above */
-#define SND_JACK_SWITCH_TYPES 6
-
 struct snd_jack {
 	struct list_head kctl_list;
 	struct snd_card *card;
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 84c2a17..36b047b 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -33,7 +33,7 @@ struct snd_jack_kctl {
 };
 
 #ifdef CONFIG_SND_JACK_INPUT_DEV
-static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
+static int jack_switch_types[] = {
 	SW_HEADPHONE_INSERT,
 	SW_MICROPHONE_INSERT,
 	SW_LINEOUT_INSERT,
@@ -250,7 +250,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 		jack->type = type;
 
-		for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
+		for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++)
 			if (type & (1 << i))
 				input_set_capability(jack->input_dev, EV_SW,
 						     jack_switch_types[i]);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
