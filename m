From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Wait for 400msec before
	concluding on value of RT5645_VENDOR_ID2" to the asoc tree
Date: Thu, 09 Nov 2017 17:42:50 +0000
Message-ID: <E1eCqqo-0006dk-Oj@debutante>
References: <20171109173552.21438-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EDEFD267852
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 18:42:57 +0100 (CET)
In-Reply-To: <20171109173552.21438-1-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Wait for 400msec before concluding on value of RT5645_VENDOR_ID2

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

>From 0c279a590fde66f4307c93ab2d4f680c7f41bbfa Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Thu, 9 Nov 2017 12:35:51 -0500
Subject: [PATCH] ASoC: rt5645: Wait for 400msec before concluding on value of
 RT5645_VENDOR_ID2

Minimum time required between power On of codec and read
of RT5645_VENDOR_ID2 is 400msec. We should wait that long
before reading the value.

TEST=Cold boot the device and check for sound device.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 23cc2cb8393f..5f24df4fae8e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -55,6 +55,8 @@ MODULE_PARM_DESC(quirk, "RT5645 pdata quirk override");
 
 #define RT5645_HWEQ_NUM 57
 
+#define TIME_TO_POWER_MS 400
+
 static const struct regmap_range_cfg rt5645_ranges[] = {
 	{
 		.name = "PR",
@@ -3784,6 +3786,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
+
+	/*
+	 * Read after 400msec, as it is the interval required between
+	 * read and power On.
+	 */
+	msleep(TIME_TO_POWER_MS);
 	regmap_read(regmap, RT5645_VENDOR_ID2, &val);
 
 	switch (val) {
-- 
2.15.0
