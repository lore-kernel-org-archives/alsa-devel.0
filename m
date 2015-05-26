From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: dummy: make local data static
Date: Tue, 26 May 2015 14:41:48 +0200
Message-ID: <1432644112-16543-2-git-send-email-tiwai@suse.de>
References: <1432644112-16543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EBC2C2614E0
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:41:53 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BA6E2ACEF
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:41:53 +0000 (UTC)
In-Reply-To: <1432644112-16543-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Add missing prefix to make some local data static.

Spotted by sparse:
  sound/drivers/dummy.c:159:20: warning: symbol 'model_emu10k1' was not declared. Should it be static?
  sound/drivers/dummy.c:165:20: warning: symbol 'model_rme9652' was not declared. Should it be static?
  ....

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index d11baaf0f0b4..5912f440d30f 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -156,13 +156,13 @@ static int emu10k1_playback_constraints(struct snd_pcm_runtime *runtime)
 	return 0;
 }
 
-struct dummy_model model_emu10k1 = {
+static struct dummy_model model_emu10k1 = {
 	.name = "emu10k1",
 	.playback_constraints = emu10k1_playback_constraints,
 	.buffer_bytes_max = 128 * 1024,
 };
 
-struct dummy_model model_rme9652 = {
+static struct dummy_model model_rme9652 = {
 	.name = "rme9652",
 	.buffer_bytes_max = 26 * 64 * 1024,
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
@@ -172,7 +172,7 @@ struct dummy_model model_rme9652 = {
 	.periods_max = 2,
 };
 
-struct dummy_model model_ice1712 = {
+static struct dummy_model model_ice1712 = {
 	.name = "ice1712",
 	.buffer_bytes_max = 256 * 1024,
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
@@ -182,7 +182,7 @@ struct dummy_model model_ice1712 = {
 	.periods_max = 1024,
 };
 
-struct dummy_model model_uda1341 = {
+static struct dummy_model model_uda1341 = {
 	.name = "uda1341",
 	.buffer_bytes_max = 16380,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
@@ -192,7 +192,7 @@ struct dummy_model model_uda1341 = {
 	.periods_max = 255,
 };
 
-struct dummy_model model_ac97 = {
+static struct dummy_model model_ac97 = {
 	.name = "ac97",
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.channels_min = 2,
@@ -202,7 +202,7 @@ struct dummy_model model_ac97 = {
 	.rate_max = 48000,
 };
 
-struct dummy_model model_ca0106 = {
+static struct dummy_model model_ca0106 = {
 	.name = "ca0106",
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.buffer_bytes_max = ((65536-64)*8),
@@ -216,7 +216,7 @@ struct dummy_model model_ca0106 = {
 	.rate_max = 192000,
 };
 
-struct dummy_model *dummy_models[] = {
+static struct dummy_model *dummy_models[] = {
 	&model_emu10k1,
 	&model_rme9652,
 	&model_ice1712,
-- 
2.4.1
