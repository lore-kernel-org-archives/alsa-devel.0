From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 37/42] ASoC: wm8991: Don't use range container
	for TLVs with one entry
Date: Sun,  2 Aug 2015 17:20:05 +0200
Message-ID: <1438528810-23498-38-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA4E264F52
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:59 +0200 (CEST)
In-Reply-To: <1438528810-23498-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, Anish Kumar <yesanishhere@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For TLVs with only a single entry it is not necessary to use a range
container. Use DECLARE_TLV_DB_LINEAR() directly instead of a combination of
TLV_DB_RANGE_HEAD() and TLV_DB_LINEAR_ITEM().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8991.c | 52 ++++++++---------------------------------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 709d16e..c9ee0ac 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -111,45 +111,14 @@ static bool wm8991_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static const unsigned int rec_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(-1500, 600),
-};
-
-static const unsigned int in_pga_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 0x1F, TLV_DB_LINEAR_ITEM(-1650, 3000),
-};
-
-static const unsigned int out_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(0, -2100),
-};
-
-static const unsigned int out_pga_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 127, TLV_DB_LINEAR_ITEM(-7300, 600),
-};
-
-static const unsigned int out_omix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(-600, 0),
-};
-
-static const unsigned int out_dac_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 255, TLV_DB_LINEAR_ITEM(-7163, 0),
-};
-
-static const unsigned int in_adc_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 255, TLV_DB_LINEAR_ITEM(-7163, 1763),
-};
-
-static const unsigned int out_sidetone_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 31, TLV_DB_LINEAR_ITEM(-3600, 0),
-};
+static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
+static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650, 3000);
+static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, 0, -2100);
+static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300, 600);
+static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
+static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163, 0);
+static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163, 1763);
+static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv, -3600, 0);
 
 static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
@@ -429,10 +398,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 }
 
 /* INMIX dB values */
-static const unsigned int in_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(-1200, 600),
-};
+static const DECLARE_TLV_DB_LINEAR(in_mix_tlv, -1200, 600);
 
 /* Left In PGA Connections */
 static const struct snd_kcontrol_new wm8991_dapm_lin12_pga_controls[] = {
-- 
2.1.4
