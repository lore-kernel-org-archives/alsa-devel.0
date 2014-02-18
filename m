From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 064/102] ASoC: ak4641: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:20 +0100
Message-ID: <1392723517-12772-37-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BFA052655EF
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
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

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ak4641.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 94cbe508dd37..684b56f2856a 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -113,14 +113,14 @@ static const DECLARE_TLV_DB_SCALE(alc_tlv, -800, 50, 0);
 static const DECLARE_TLV_DB_SCALE(aux_in_tlv, -2100, 300, 0);
 
 
-static const struct soc_enum ak4641_mono_out_enum =
-	SOC_ENUM_SINGLE(AK4641_SIG1, 6, 2, ak4641_mono_out);
-static const struct soc_enum ak4641_hp_out_enum =
-	SOC_ENUM_SINGLE(AK4641_MODE2, 2, 2, ak4641_hp_out);
-static const struct soc_enum ak4641_mic_select_enum =
-	SOC_ENUM_SINGLE(AK4641_MIC, 1, 2, ak4641_mic_select);
-static const struct soc_enum ak4641_mic_or_dac_enum =
-	SOC_ENUM_SINGLE(AK4641_BTIF, 4, 2, ak4641_mic_or_dac);
+static SOC_ENUM_SINGLE_DECL(ak4641_mono_out_enum,
+			    AK4641_SIG1, 6, ak4641_mono_out);
+static SOC_ENUM_SINGLE_DECL(ak4641_hp_out_enum,
+			    AK4641_MODE2, 2, ak4641_hp_out);
+static SOC_ENUM_SINGLE_DECL(ak4641_mic_select_enum,
+			    AK4641_MIC, 1, ak4641_mic_select);
+static SOC_ENUM_SINGLE_DECL(ak4641_mic_or_dac_enum,
+			    AK4641_BTIF, 4, ak4641_mic_or_dac);
 
 static const struct snd_kcontrol_new ak4641_snd_controls[] = {
 	SOC_ENUM("Mono 1 Output", ak4641_mono_out_enum),
-- 
1.8.5.2
