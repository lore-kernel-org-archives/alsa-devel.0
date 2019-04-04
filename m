From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 1/2] ASoC: tlv320aic32x4: Add Switch for
	Setting Common Mode Voltage
Date: Wed,  3 Apr 2019 21:01:54 -0700
Message-ID: <20190404040155.29246-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp81.ord1d.emailsrvr.com (smtp81.ord1d.emailsrvr.com
 [184.106.54.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3FD0F8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 06:02:15 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org

Add a switch for setting common mode voltage.  This can allow
for higher drive levels on the amplifier outputs.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index aec86fd6ac15..77df2cbdf5f4 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -242,6 +242,12 @@ static DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
 /* -12dB min, 0.5dB steps */
 static DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
 
+static const char * const lo_cm_text[] = {
+	"Full Chip", "1.65V",
+};
+
+static SOC_ENUM_SINGLE_DECL(lo_cm_enum, AIC32X4_CMMODE, 3, lo_cm_text);
+
 static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
 			AIC32X4_RDACVOL, 0, -0x7f, 0x30, 7, 0, tlv_pcm),
@@ -255,6 +261,7 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 			AIC32X4_HPRGAIN, 6, 0x01, 1),
 	SOC_DOUBLE_R("LO DAC Playback Switch", AIC32X4_LOLGAIN,
 			AIC32X4_LORGAIN, 6, 0x01, 1),
+	SOC_ENUM("LO Playback Common Mode Switch", lo_cm_enum),
 	SOC_DOUBLE_R("Mic PGA Switch", AIC32X4_LMICPGAVOL,
 			AIC32X4_RMICPGAVOL, 7, 0x01, 1),
 
-- 
2.19.1
