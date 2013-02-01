From: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2200: Add Rx ANC input select control
Date: Fri,  1 Feb 2013 15:40:41 +0000
Message-ID: <1359733241-26633-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78C0526522D
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2013 16:41:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Change-Id: Iee28d1898327633a3166dd340410a37796959c0c
---
 sound/soc/codecs/wm2200.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index bdd3d80..a915c76 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1109,6 +1109,16 @@ static int wm2200_mixer_values[] = {
 	static WM2200_MUX_CTL_DECL(name##_aux5); \
 	static WM2200_MUX_CTL_DECL(name##_aux6);
 
+static const char *wm2200_rxanc_input_sel_texts[] = {
+	"None", "IN1", "IN2", "IN3",
+};
+
+static const struct soc_enum wm2200_rxanc_input_sel =
+	SOC_ENUM_SINGLE(WM2200_RXANC_SRC,
+			WM2200_IN_RXANC_SEL_SHIFT,
+			ARRAY_SIZE(wm2200_rxanc_input_sel_texts),
+			wm2200_rxanc_input_sel_texts);
+
 static const struct snd_kcontrol_new wm2200_snd_controls[] = {
 SOC_SINGLE("IN1 High Performance Switch", WM2200_IN1L_CONTROL,
 	   WM2200_IN1_OSR_SHIFT, 1, 0),
@@ -1168,6 +1178,7 @@ SOC_DOUBLE_R_TLV("OUT2 Digital Volume", WM2200_DAC_DIGITAL_VOLUME_2L,
 		 digital_tlv),
 SOC_DOUBLE("OUT2 Switch", WM2200_PDM_1, WM2200_SPK1L_MUTE_SHIFT,
 	   WM2200_SPK1R_MUTE_SHIFT, 1, 1),
+SOC_ENUM("RxANC Src", wm2200_rxanc_input_sel),
 };
 
 WM2200_MIXER_ENUMS(OUT1L, WM2200_OUT1LMIX_INPUT_1_SOURCE);
-- 
1.7.2.5
