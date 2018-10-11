From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Sort DHT Rot Pnt Volume in
	reverse order" to the asoc tree
Date: Thu, 11 Oct 2018 15:45:55 +0100 (BST)
Message-ID: <20181011144555.D64CD11223ED@debutante.sirena.org.uk>
References: <20181010232222.52340-4-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ACEF12677F0
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 16:45:59 +0200 (CEST)
In-Reply-To: <20181010232222.52340-4-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, Ryan Lee <ryans.lee@maximintegrated.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a23f5dc8448694a0ffe2127a04aa5787b9cf9e5f Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Wed, 10 Oct 2018 23:26:17 +0000
Subject: [PATCH] ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 37f8bcdd8e35..a09d01318f79 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -471,12 +471,12 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_spkgain_min_tlv,
 	0, 9, TLV_DB_SCALE_ITEM(800, 100, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation_point_tlv,
-	0, 1, TLV_DB_SCALE_ITEM(-50, -50, 0),
-	2, 7, TLV_DB_SCALE_ITEM(-200, -100, 0),
-	8, 9, TLV_DB_SCALE_ITEM(-1000, -200, 0),
-	10, 11, TLV_DB_SCALE_ITEM(-1500, -300, 0),
-	12, 13, TLV_DB_SCALE_ITEM(-2000, -200, 0),
-	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
+	0, 1, TLV_DB_SCALE_ITEM(-3000, 500, 0),
+	2, 4, TLV_DB_SCALE_ITEM(-2200, 200, 0),
+	5, 6, TLV_DB_SCALE_ITEM(-1500, 300, 0),
+	7, 9, TLV_DB_SCALE_ITEM(-1000, 200, 0),
+	10, 13, TLV_DB_SCALE_ITEM(-500, 100, 0),
+	14, 15, TLV_DB_SCALE_ITEM(-100, 50, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
 	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
@@ -617,7 +617,7 @@ SOC_SINGLE("DHT Switch", MAX98373_R20D4_DHT_EN,
 SOC_SINGLE_TLV("DHT Min Volume", MAX98373_R20D1_DHT_CFG,
 	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0, max98373_dht_spkgain_min_tlv),
 SOC_SINGLE_TLV("DHT Rot Pnt Volume", MAX98373_R20D1_DHT_CFG,
-	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0, max98373_dht_rotation_point_tlv),
+	MAX98373_DHT_ROT_PNT_SHIFT, 15, 1, max98373_dht_rotation_point_tlv),
 SOC_SINGLE_TLV("DHT Attack Step Volume", MAX98373_R20D2_DHT_ATTACK_CFG,
 	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
 SOC_SINGLE_TLV("DHT Release Step Volume", MAX98373_R20D3_DHT_RELEASE_CFG,
-- 
2.19.0.rc2
