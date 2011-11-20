From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [GIT PULL] fixes for wrong DB_RANGE_HEADER sizes
Date: Sun, 20 Nov 2011 22:56:19 +0100
Message-ID: <4EC97783.60305@ladisch.de>
References: <4EC91ADF.30702@ladisch.de>
	<20111120210245.GD2976@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5AD1A24411
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 22:56:35 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 10C382086A
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 16:56:32 -0500 (EST)
In-Reply-To: <20111120210245.GD2976@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> I'm sorry, I'm not going to pull this as I've never seen the patches and
> you've not even described the issue you're trying to fix.

Sorry, I didn't mean to omit that.


This patch series fixes several drivers where TLV_DB_RANGE_HEAD() was
used with a wrong number of entries, which resulted in a missing entry
(in rt5631) or in some surplus entries with random data being returned
(all other drivers).


The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.alsa-project.org/alsa-kprivate.git DB_RANGE-size-fixes

Clemens Ladisch (7):
      ASoC: adau1373: fix DB_RANGE size
      ASoC: rt5631: fix DB_RANGE size
      ASoC: sgtl5000: fix DB_RANGE size
      ASoC: wm8962: fix DB_RANGE size
      ASoC: wm8993: fix DB_RANGE size
      ASoC: wm9090: fix DB_RANGE size
      ASoC: wm_hubs: fix DB_RANGE size

 sound/soc/codecs/adau1373.c |    2 +-
 sound/soc/codecs/rt5631.c   |    2 +-
 sound/soc/codecs/sgtl5000.c |    2 +-
 sound/soc/codecs/wm8962.c   |    4 ++--
 sound/soc/codecs/wm8993.c   |    2 +-
 sound/soc/codecs/wm9090.c   |    6 +++---
 sound/soc/codecs/wm_hubs.c  |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 1ccf8dd..45c6302 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -245,7 +245,7 @@ static const char *adau1373_bass_hpf_cutoff_text[] = {
 };

 static const unsigned int adau1373_bass_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+	TLV_DB_RANGE_HEAD(3),
 	0, 2, TLV_DB_SCALE_ITEM(-600, 600, 1),
 	3, 4, TLV_DB_SCALE_ITEM(950, 250, 0),
 	5, 7, TLV_DB_SCALE_ITEM(1400, 150, 0),
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 27a078c..4646e80 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -177,7 +177,7 @@ static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -95625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52}dB */
 static unsigned int mic_bst_tlv[] = {
-	TLV_DB_RANGE_HEAD(6),
+	TLV_DB_RANGE_HEAD(7),
 	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d15695d..bbcf921 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -365,7 +365,7 @@ static const DECLARE_TLV_DB_SCALE(capture_6db_attenuate, -600, 600, 0);

 /* tlv for mic gain, 0db 20db 30db 40db */
 static const unsigned int mic_gain_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+	TLV_DB_RANGE_HEAD(2),
 	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 	1, 3, TLV_DB_SCALE_ITEM(2000, 1000, 0),
 };
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 91d3c6d..53edd9a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1973,7 +1973,7 @@ static int wm8962_reset(struct snd_soc_codec *codec)
 static const DECLARE_TLV_DB_SCALE(inpga_tlv, -2325, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mixin_tlv, -1500, 300, 0);
 static const unsigned int mixinpga_tlv[] = {
-	TLV_DB_RANGE_HEAD(7),
+	TLV_DB_RANGE_HEAD(5),
 	0, 1, TLV_DB_SCALE_ITEM(0, 600, 0),
 	2, 2, TLV_DB_SCALE_ITEM(1300, 1300, 0),
 	3, 4, TLV_DB_SCALE_ITEM(1800, 200, 0),
@@ -1988,7 +1988,7 @@ static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(hp_tlv, -700, 100, 0);
 static const unsigned int classd_tlv[] = {
-	TLV_DB_RANGE_HEAD(7),
+	TLV_DB_RANGE_HEAD(2),
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
 	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
 };
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index eec8e14..d1a142f4 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -512,7 +512,7 @@ static const DECLARE_TLV_DB_SCALE(drc_comp_threash, -4500, 75, 0);
 static const DECLARE_TLV_DB_SCALE(drc_comp_amp, -2250, 75, 0);
 static const DECLARE_TLV_DB_SCALE(drc_min_tlv, -1800, 600, 0);
 static const unsigned int drc_max_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+	TLV_DB_RANGE_HEAD(2),
 	0, 2, TLV_DB_SCALE_ITEM(1200, 600, 0),
 	3, 3, TLV_DB_SCALE_ITEM(3600, 0, 0),
 };
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 2b5252c..f94c060 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -177,19 +177,19 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec)
 }

 static const unsigned int in_tlv[] = {
-	TLV_DB_RANGE_HEAD(6),
+	TLV_DB_RANGE_HEAD(3),
 	0, 0, TLV_DB_SCALE_ITEM(-600, 0, 0),
 	1, 3, TLV_DB_SCALE_ITEM(-350, 350, 0),
 	4, 6, TLV_DB_SCALE_ITEM(600, 600, 0),
 };
 static const unsigned int mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+	TLV_DB_RANGE_HEAD(2),
 	0, 2, TLV_DB_SCALE_ITEM(-1200, 300, 0),
 	3, 3, TLV_DB_SCALE_ITEM(0, 0, 0),
 };
 static const DECLARE_TLV_DB_SCALE(out_tlv, -5700, 100, 0);
 static const unsigned int spkboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(7),
+	TLV_DB_RANGE_HEAD(2),
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
 	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
 };
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 84f33d4..48e61e9 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -40,7 +40,7 @@ static const DECLARE_TLV_DB_SCALE(outmix_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(spkmixout_tlv, -1800, 600, 1);
 static const DECLARE_TLV_DB_SCALE(outpga_tlv, -5700, 100, 0);
 static const unsigned int spkboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(7),
+	TLV_DB_RANGE_HEAD(2),
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
 	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
 };
