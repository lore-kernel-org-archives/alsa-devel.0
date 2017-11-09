From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH v3] ASoC: rt5645: Wait for 400msec before
	concluding on value of RT5645_VENDOR_ID2
Date: Thu,  9 Nov 2017 12:35:51 -0500
Message-ID: <20171109173552.21438-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00166267826
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 18:36:02 +0100 (CET)
Received: by mail-qt0-f193.google.com with SMTP id n61so8612413qte.10
 for <alsa-devel@alsa-project.org>; Thu, 09 Nov 2017 09:36:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
Cc: tiwai@suse.de, Bard Liao <bardliao@realtek.com>, Alex Deucher <alexander.deucher@amd.com>, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

Minimum time required between power On of codec and read
of RT5645_VENDOR_ID2 is 400msec. We should wait that long
before reading the value.

TEST=Cold boot the device and check for sound device.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

v2: rework the patch based on mailing list discussion.
    Just wait before reading the register.
v3: Drop the extra read

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
2.13.6
