From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 100/102] ASoC: wm9712: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:46 +0100
Message-ID: <1392724308-13375-20-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 674E626576C
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
 sound/soc/codecs/wm9712.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index c5eb746087b4..0327fff492bb 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -74,18 +74,18 @@ static const DECLARE_TLV_DB_SCALE(main_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(boost_tlv, 0, 2000, 0);
 
 static const struct soc_enum wm9712_enum[] = {
-SOC_ENUM_SINGLE(AC97_PCI_SVID, 14, 4, wm9712_alc_select),
-SOC_ENUM_SINGLE(AC97_VIDEO, 12, 4, wm9712_alc_mux),
-SOC_ENUM_SINGLE(AC97_AUX, 9, 4, wm9712_out3_src),
-SOC_ENUM_SINGLE(AC97_AUX, 8, 2, wm9712_spk_src),
-SOC_ENUM_SINGLE(AC97_REC_SEL, 12, 4, wm9712_rec_adc),
-SOC_ENUM_SINGLE(AC97_MASTER_TONE, 15, 2, wm9712_base),
-SOC_ENUM_DOUBLE(AC97_REC_GAIN, 14, 6, 2, wm9712_rec_gain),
-SOC_ENUM_SINGLE(AC97_MIC, 5, 4, wm9712_mic),
-SOC_ENUM_SINGLE(AC97_REC_SEL, 8, 8, wm9712_rec_sel),
-SOC_ENUM_SINGLE(AC97_REC_SEL, 0, 8, wm9712_rec_sel),
-SOC_ENUM_SINGLE(AC97_PCI_SVID, 5, 2, wm9712_ng_type),
-SOC_ENUM_SINGLE(0x5c, 8, 2, wm9712_diff_sel),
+SOC_ENUM_SINGLE_CONST(AC97_PCI_SVID, 14, wm9712_alc_select),
+SOC_ENUM_SINGLE_CONST(AC97_VIDEO, 12, wm9712_alc_mux),
+SOC_ENUM_SINGLE_CONST(AC97_AUX, 9, wm9712_out3_src),
+SOC_ENUM_SINGLE_CONST(AC97_AUX, 8, wm9712_spk_src),
+SOC_ENUM_SINGLE_CONST(AC97_REC_SEL, 12, wm9712_rec_adc),
+SOC_ENUM_SINGLE_CONST(AC97_MASTER_TONE, 15, wm9712_base),
+SOC_ENUM_DOUBLE_CONST(AC97_REC_GAIN, 14, 6, wm9712_rec_gain),
+SOC_ENUM_SINGLE_CONST(AC97_MIC, 5, wm9712_mic),
+SOC_ENUM_SINGLE_CONST(AC97_REC_SEL, 8, wm9712_rec_sel),
+SOC_ENUM_SINGLE_CONST(AC97_REC_SEL, 0, wm9712_rec_sel),
+SOC_ENUM_SINGLE_CONST(AC97_PCI_SVID, 5, wm9712_ng_type),
+SOC_ENUM_SINGLE_CONST(0x5c, 8, wm9712_diff_sel),
 };
 
 static const struct snd_kcontrol_new wm9712_snd_ac97_controls[] = {
-- 
1.8.5.2
