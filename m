From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: rt5645: add fallback case for jack
	detection support
Date: Wed,  3 Jan 2018 12:42:41 -0600
Message-ID: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D9FC2676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 19:42:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans de Goede <hdegoede@redhat.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Commit 78f5605c0329 ("ASoC: rt5645: cleanup DMI matching code") did a
lot of useful cleanups, but the logic is a bit flawed: if there is no
DMI match on an ACPI machine, the code reads non-existent properties.

Re-add previous code that checked for the existence of those
properties and a fallback mode to enable jd-mode3 if there is no
pdata, device property or quirk. This will help avoid having to add
new DMI quirks when only the jd-mode is needed for headset playback.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ebc4f5970f24..476020445f65 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3687,6 +3687,17 @@ static const struct dmi_system_id dmi_platform_data[] = {
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
@@ -3727,8 +3738,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
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
2.14.1
