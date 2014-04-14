From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/17] ASoC: mc13783: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:00 +0200
Message-ID: <1397503872-20864-6-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5F02656B2
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:22 +0200 (CEST)
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

SND_SOC_DAPM_VIRT_MUX and SOC_DAPM_ENUM_VIRT are deprecated and merely an alias
for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so we can
eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/mc13783.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 9029e20..0b0a4ca 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -409,7 +409,7 @@ static const char * const adcl_enum_text[] = {
 static SOC_ENUM_SINGLE_VIRT_DECL(adcl_enum, adcl_enum_text);
 
 static const struct snd_kcontrol_new left_input_mux =
-	SOC_DAPM_ENUM_VIRT("Route", adcl_enum);
+	SOC_DAPM_ENUM("Route", adcl_enum);
 
 static const char * const adcr_enum_text[] = {
 	"MC1R", "MC2", "RXINR", "TXIN",
@@ -418,7 +418,7 @@ static const char * const adcr_enum_text[] = {
 static SOC_ENUM_SINGLE_VIRT_DECL(adcr_enum, adcr_enum_text);
 
 static const struct snd_kcontrol_new right_input_mux =
-	SOC_DAPM_ENUM_VIRT("Route", adcr_enum);
+	SOC_DAPM_ENUM("Route", adcr_enum);
 
 static const struct snd_kcontrol_new samp_ctl =
 	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 3, 1, 0);
@@ -478,9 +478,9 @@ static const struct snd_soc_dapm_widget mc13783_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("MC2 Amp", MC13783_AUDIO_TX, 9, 0, &mc2_amp_ctl),
 	SND_SOC_DAPM_SWITCH("TXIN Amp", MC13783_AUDIO_TX, 11, 0, &atx_amp_ctl),
 
-	SND_SOC_DAPM_VIRT_MUX("PGA Left Input Mux", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MUX("PGA Left Input Mux", SND_SOC_NOPM, 0, 0,
 			      &left_input_mux),
-	SND_SOC_DAPM_VIRT_MUX("PGA Right Input Mux", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MUX("PGA Right Input Mux", SND_SOC_NOPM, 0, 0,
 			      &right_input_mux),
 
 	SND_SOC_DAPM_MUX("Speaker Amp Source MUX", SND_SOC_NOPM, 0, 0,
-- 
1.8.0
