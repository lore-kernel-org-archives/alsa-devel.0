From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix noise generator gain TLV
Date: Thu, 28 May 2015 14:28:12 +0100
Message-ID: <1432819692-30122-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E9A2265EAB
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 15:30:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Arizona codec drivers had an incorrect dB scaling for the
noise generator gain that started at 0dB and went upwards.
Actually the highest setting is 0dB.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    2 +-
 sound/soc/codecs/wm5110.c |    2 +-
 sound/soc/codecs/wm8997.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 0c6d1bc..d476221 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -42,7 +42,7 @@ struct wm5102_priv {
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
-static DECLARE_TLV_DB_SCALE(noise_tlv, 0, 600, 0);
+static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
 static const struct wm_adsp_region wm5102_dsp1_regions[] = {
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fbaeddb..3ee6cfd 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -167,7 +167,7 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
-static DECLARE_TLV_DB_SCALE(noise_tlv, 0, 600, 0);
+static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
 #define WM5110_NG_SRC(name, base) \
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index a4d1177..e7c81ba 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -40,7 +40,7 @@ struct wm8997_priv {
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
-static DECLARE_TLV_DB_SCALE(noise_tlv, 0, 600, 0);
+static DECLARE_TLV_DB_SCALE(noise_tlv, -13200, 600, 0);
 static DECLARE_TLV_DB_SCALE(ng_tlv, -10200, 600, 0);
 
 static const struct reg_default wm8997_sysclk_reva_patch[] = {
-- 
1.7.2.5
