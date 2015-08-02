From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/42] ASoC: adau1373: Replace
	TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:31 +0200
Message-ID: <1438528810-23498-4-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 3291B2606CA
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:19 +0200 (CEST)
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

DECLARE_TLV_DB_RANGE() has the advantage over using TLV_DB_RANGE_HEAD()
that it automatically calculates the number of items in the TLV and is
hence less prone to manual error.

Generate using the following coccinelle script

// <smpl>
@@
declarer name DECLARE_TLV_DB_RANGE;
identifier tlv;
constant x;
@@
-unsigned int tlv[] = {
-	TLV_DB_RANGE_HEAD(x),
+DECLARE_TLV_DB_RANGE(tlv,
	...
-};
+);
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 6c96860..fe1353a 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -320,13 +320,12 @@ static const struct reg_default adau1373_reg_defaults[] = {
 	{ ADAU1373_DIGEN,		0x00 },
 };
 
-static const unsigned int adau1373_out_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(adau1373_out_tlv,
 	0, 7, TLV_DB_SCALE_ITEM(-7900, 400, 1),
 	8, 15, TLV_DB_SCALE_ITEM(-4700, 300, 0),
 	16, 23, TLV_DB_SCALE_ITEM(-2300, 200, 0),
-	24, 31, TLV_DB_SCALE_ITEM(-700, 100, 0),
-};
+	24, 31, TLV_DB_SCALE_ITEM(-700, 100, 0)
+);
 
 static const DECLARE_TLV_DB_MINMAX(adau1373_digital_tlv, -9563, 0);
 static const DECLARE_TLV_DB_SCALE(adau1373_in_pga_tlv, -1300, 100, 1);
@@ -381,12 +380,11 @@ static const char *adau1373_bass_hpf_cutoff_text[] = {
 	"158Hz", "232Hz", "347Hz", "520Hz",
 };
 
-static const unsigned int adau1373_bass_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(adau1373_bass_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-600, 600, 1),
 	3, 4, TLV_DB_SCALE_ITEM(950, 250, 0),
-	5, 7, TLV_DB_SCALE_ITEM(1400, 150, 0),
-};
+	5, 7, TLV_DB_SCALE_ITEM(1400, 150, 0)
+);
 
 static SOC_ENUM_SINGLE_DECL(adau1373_bass_lpf_cutoff_enum,
 	ADAU1373_BASS1, 5, adau1373_bass_lpf_cutoff_text);
@@ -414,11 +412,10 @@ static SOC_ENUM_SINGLE_DECL(adau1373_3d_level_enum,
 static SOC_ENUM_SINGLE_DECL(adau1373_3d_cutoff_enum,
 	ADAU1373_3D_CTRL1, 0, adau1373_3d_cutoff_text);
 
-static const unsigned int adau1373_3d_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(adau1373_3d_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
-	1, 7, TLV_DB_LINEAR_ITEM(-1800, -120),
-};
+	1, 7, TLV_DB_LINEAR_ITEM(-1800, -120)
+);
 
 static const char *adau1373_lr_mux_text[] = {
 	"Mute",
-- 
2.1.4
