From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 102/102] ASoC: wm_adsp: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:48 +0100
Message-ID: <1392724308-13375-22-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CC226576D
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f9fd56444a14..34e79d26922b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -273,10 +273,10 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 }
 
 static const struct soc_enum wm_adsp_fw_enum[] = {
-	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
-	SOC_ENUM_SINGLE(0, 1, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
-	SOC_ENUM_SINGLE(0, 2, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
-	SOC_ENUM_SINGLE(0, 3, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
+	SOC_ENUM_SINGLE_CONST(0, 0, wm_adsp_fw_text),
+	SOC_ENUM_SINGLE_CONST(0, 1, wm_adsp_fw_text),
+	SOC_ENUM_SINGLE_CONST(0, 2, wm_adsp_fw_text),
+	SOC_ENUM_SINGLE_CONST(0, 3, wm_adsp_fw_text),
 };
 
 const struct snd_kcontrol_new wm_adsp1_fw_controls[] = {
-- 
1.8.5.2
