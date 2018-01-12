From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: add fallback case for jack
	detection support" to the asoc tree
Date: Fri, 12 Jan 2018 12:28:28 +0000
Message-ID: <E1eZyRg-0006Ix-7m@debutante>
References: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB84266E07
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 13:28:42 +0100 (CET)
In-Reply-To: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org, Bard Liao <bardliao@realtek.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: add fallback case for jack detection support

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

>From 5954c4a1455c3bc42acb2c286744eae1aaa00918 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 11 Jan 2018 14:05:11 -0600
Subject: [PATCH] ASoC: rt5645: add fallback case for jack detection support

Commit 78f5605c0329 ("ASoC: rt5645: cleanup DMI matching code") did a
lot of useful cleanups. This patch adds a default case to enable
jack detection if there is no pdata, device property or quirk.

The chosen jd-mode3 is the most common and should limit the addition
of new DMI-based quirks. Existing DMI quirks which only set this mode
are left as is and not removed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index fbaf36aeb587..5292fca2f54f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3739,6 +3739,17 @@ static const struct dmi_system_id dmi_platform_data[] = {
 	{ }
 };
 
+static bool rt5645_check_dp(struct device *dev)
+{
+	if (device_property_present(dev, "realtek,in2-differential") ||
+	    device_property_present(dev, "realtek,dmic1-data-pin") ||
+	    device_property_present(dev, "realtek,dmic2-data-pin") ||
+	    device_property_present(dev, "realtek,jd-mode"))
+		return true;
+
+	return false;
+}
+
 static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 {
 	rt5645->pdata.in2_diff = device_property_read_bool(dev,
@@ -3779,8 +3790,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5645->pdata = *pdata;
-	else
+	else if (rt5645_check_dp(&i2c->dev))
 		rt5645_parse_dt(rt5645, &i2c->dev);
+	else
+		rt5645->pdata = jd_mode3_platform_data;
 
 	if (quirk != -1) {
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
-- 
2.15.1
