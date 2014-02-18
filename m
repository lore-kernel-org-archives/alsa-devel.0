From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 101/102] ASoC: wm9713: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:47 +0100
Message-ID: <1392724308-13375-21-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB29265772
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
 sound/soc/codecs/wm9713.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index acea8927905b..87a520727429 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -92,26 +92,26 @@ static const char *wm9713_mic_select[] = {"Mic 1", "Mic 2 A", "Mic 2 B"};
 static const char *wm9713_micb_select[] = {"MPB", "MPA"};
 
 static const struct soc_enum wm9713_enum[] = {
-SOC_ENUM_SINGLE(AC97_LINE, 3, 4, wm9713_mic_mixer), /* record mic mixer 0 */
-SOC_ENUM_SINGLE(AC97_VIDEO, 14, 4, wm9713_rec_mux), /* record mux hp 1 */
-SOC_ENUM_SINGLE(AC97_VIDEO, 9, 4, wm9713_rec_mux),  /* record mux mono 2 */
-SOC_ENUM_SINGLE(AC97_VIDEO, 3, 8, wm9713_rec_src),  /* record mux left 3 */
-SOC_ENUM_SINGLE(AC97_VIDEO, 0, 8, wm9713_rec_src),  /* record mux right 4*/
-SOC_ENUM_DOUBLE(AC97_CD, 14, 6, 2, wm9713_rec_gain), /* record step size 5 */
-SOC_ENUM_SINGLE(AC97_PCI_SVID, 14, 4, wm9713_alc_select), /* alc source select 6*/
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 14, 4, wm9713_mono_pga), /* mono input select 7 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 11, 8, wm9713_spk_pga), /* speaker left input select 8 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 8, 8, wm9713_spk_pga), /* speaker right input select 9 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 6, 3, wm9713_hp_pga), /* headphone left input 10 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 4, 3, wm9713_hp_pga), /* headphone right input 11 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 2, 4, wm9713_out3_pga), /* out 3 source 12 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN, 0, 4, wm9713_out4_pga), /* out 4 source 13 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN_MIC, 13, 8, wm9713_dac_inv), /* dac invert 1 14 */
-SOC_ENUM_SINGLE(AC97_REC_GAIN_MIC, 10, 8, wm9713_dac_inv), /* dac invert 2 15 */
-SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 15, 2, wm9713_bass), /* bass control 16 */
-SOC_ENUM_SINGLE(AC97_PCI_SVID, 5, 2, wm9713_ng_type), /* noise gate type 17 */
-SOC_ENUM_SINGLE(AC97_3D_CONTROL, 12, 3, wm9713_mic_select), /* mic selection 18 */
-SOC_ENUM_SINGLE(MICB_MUX, 0, 2, wm9713_micb_select), /* mic selection 19 */
+SOC_ENUM_SINGLE_CONST(AC97_LINE, 3, wm9713_mic_mixer), /* record mic mixer 0 */
+SOC_ENUM_SINGLE_CONST(AC97_VIDEO, 14, wm9713_rec_mux), /* record mux hp 1 */
+SOC_ENUM_SINGLE_CONST(AC97_VIDEO, 9, wm9713_rec_mux),  /* record mux mono 2 */
+SOC_ENUM_SINGLE_CONST(AC97_VIDEO, 3, wm9713_rec_src),  /* record mux left 3 */
+SOC_ENUM_SINGLE_CONST(AC97_VIDEO, 0, wm9713_rec_src),  /* record mux right 4*/
+SOC_ENUM_DOUBLE_CONST(AC97_CD, 14, 6, wm9713_rec_gain), /* record step size 5 */
+SOC_ENUM_SINGLE_CONST(AC97_PCI_SVID, 14, wm9713_alc_select), /* alc source select 6*/
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 14, wm9713_mono_pga), /* mono input select 7 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 11, wm9713_spk_pga), /* speaker left input select 8 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 8, wm9713_spk_pga), /* speaker right input select 9 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 6, wm9713_hp_pga), /* headphone left input 10 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 4, wm9713_hp_pga), /* headphone right input 11 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 2, wm9713_out3_pga), /* out 3 source 12 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN, 0, wm9713_out4_pga), /* out 4 source 13 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN_MIC, 13, wm9713_dac_inv), /* dac invert 1 14 */
+SOC_ENUM_SINGLE_CONST(AC97_REC_GAIN_MIC, 10, wm9713_dac_inv), /* dac invert 2 15 */
+SOC_ENUM_SINGLE_CONST(AC97_GENERAL_PURPOSE, 15, wm9713_bass), /* bass control 16 */
+SOC_ENUM_SINGLE_CONST(AC97_PCI_SVID, 5, wm9713_ng_type), /* noise gate type 17 */
+SOC_ENUM_SINGLE_CONST(AC97_3D_CONTROL, 12, wm9713_mic_select), /* mic selection 18 */
+SOC_ENUM_SINGLE_CONST(MICB_MUX, 0, wm9713_micb_select), /* mic selection 19 */
 };
 
 static const DECLARE_TLV_DB_SCALE(out_tlv, -4650, 150, 0);
-- 
1.8.5.2
