From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/17] ASoC: wm5102: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:05 +0200
Message-ID: <1397503872-20864-11-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 912582656BC
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:28 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAPM_VALUE_MUX and SOC_DAPM_VALUE_ENUM are deprecated and merely an
alias for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so
we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm5102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 7a04653..3c1dfeb 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -970,7 +970,7 @@ static const struct soc_enum wm5102_aec_loopback =
 			      wm5102_aec_loopback_values);
 
 static const struct snd_kcontrol_new wm5102_aec_loopback_mux =
-	SOC_DAPM_VALUE_ENUM("AEC Loopback", wm5102_aec_loopback);
+	SOC_DAPM_ENUM("AEC Loopback", wm5102_aec_loopback);
 
 static const struct snd_soc_dapm_widget wm5102_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
@@ -1204,7 +1204,7 @@ SND_SOC_DAPM_AIF_IN("SLIMRX8", NULL, 0,
 
 ARIZONA_DSP_WIDGETS(DSP1, "DSP1"),
 
-SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
+SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
 		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
 		       &wm5102_aec_loopback_mux),
 
-- 
1.8.0
