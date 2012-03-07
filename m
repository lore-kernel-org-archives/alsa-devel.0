From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/3] ASoC: core: Add card mutex locking
	subclasses
Date: Wed,  7 Mar 2012 10:38:25 +0000
Message-ID: <1331116707-10016-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 99CC81045DF
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 11:38:49 +0100 (CET)
Received: by mail-we0-f171.google.com with SMTP id m1so4497156wer.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 02:38:33 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This is the first part of a change that is intended to improve
ASoC locking protection for DAPM and PCM operations.

This part of the series adds a mutex class for the soc_card mutex. The
SND_SOC_CARD_CLASS_INIT class is used for card initialisation only whilst the
SND_SOC_CARD_CLASS_PCM class is used for the forth coming Dynamic
PCM operations. The new mutex classes are required otherwise we will see a false
positive mutex deadlock warning between the card initialisation and the PCM
operations (something that would never deadlock in real life).

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2ebf787..70de2f8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -288,6 +288,11 @@ enum snd_soc_pcm_subclass {
 	SND_SOC_PCM_CLASS_BE	= 1,
 };
 
+enum snd_soc_card_subclass {
+	SND_SOC_CARD_CLASS_INIT	= 0,
+	SND_SOC_CARD_CLASS_PCM	= 1,
+};
+
 int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			     int source, unsigned int freq, int dir);
 int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c90bb01..acd0d93 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1416,7 +1416,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	struct snd_soc_dai_link *dai_link;
 	int ret, i, order;
 
-	mutex_lock(&card->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
 	if (card->instantiated) {
 		mutex_unlock(&card->mutex);
-- 
1.7.5.4
