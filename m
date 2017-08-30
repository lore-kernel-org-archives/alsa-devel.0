From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] ASoC: rt5645: Add jack detection workaround
 for MINIX Z83-4 based devices
Date: Wed, 30 Aug 2017 16:07:36 +1000
Message-ID: <c98257b6-a5bc-a1b6-5194-cc29b6aec571@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B15D266C52
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 08:07:42 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id r187so3724526pfr.5
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 23:07:42 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices requires jd_mode=3
to make the jack detection work. Using a BIOS DMI product of "Z83-4"
will match both devices of 'NEO Z83-4' and 'Z83-4 Pro'.

Signed-off-by: Ian W Morrison <ianwmorrison@gmail.com>
---
 sound/soc/codecs/rt5645.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ec5816..7d889b6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3637,6 +3637,21 @@ static int rt5645_resume(struct snd_soc_codec *codec)
        {}
 };

+static struct rt5645_platform_data minix_z83_4_platform_data = {
+       .jd_mode = 3,
+};
+
+static struct dmi_system_id dmi_platform_minix_z83_4[] = {
+       {
+               .ident = "MINIX Z83-4",
+               .matches = {
+                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
+                       DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
+               },
+       },
+       { }
+};
+
 static bool rt5645_check_dp(struct device *dev)
 {
        if (device_property_present(dev, "realtek,in2-differential") ||
@@ -3689,6 +3704,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
                rt5645->pdata = general_platform_data;
        else if (dmi_check_system(dmi_platform_gpd_win))
                rt5645->pdata = gpd_win_platform_data;
+       else if (dmi_check_system(dmi_platform_minix_z83_4))
+               rt5645->pdata = minix_z83_4_platform_data;

        if (quirk != -1) {
                rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
-- 
1.9.1
