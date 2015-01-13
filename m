From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/29] ASoC: wm8961: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:21 +0100
Message-ID: <1421141255-21477-15-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id B69AD2619E3
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:27:58 +0100 (CET)
In-Reply-To: <1421141255-21477-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8961.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index eeffd05..95e2c1b 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -194,7 +194,7 @@ static bool wm8961_readable(struct device *dev, unsigned int reg)
 static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	u16 hp_reg = snd_soc_read(codec, WM8961_ANALOGUE_HP_0);
 	u16 cp_reg = snd_soc_read(codec, WM8961_CHARGE_PUMP_1);
 	u16 pwr_reg = snd_soc_read(codec, WM8961_PWR_MGMT_2);
@@ -286,7 +286,7 @@ static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 static int wm8961_spk_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	u16 pwr_reg = snd_soc_read(codec, WM8961_PWR_MGMT_2);
 	u16 spk_reg = snd_soc_read(codec, WM8961_CLASS_D_CONTROL_1);
 
-- 
1.8.0
