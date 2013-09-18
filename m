From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Tue, 17 Sep 2013 23:10:24 -0700
Message-ID: <1379484624-11029-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id F2AB4261AA7
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 08:10:02 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id q10so6571962pdj.20
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 23:10:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@linaro.org
Cc: liam.r.girdwood@linux.intel.com, Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 02b80773de37 (ASoC: rt5640: Add ACPI probing support.) causes
a warning due to unreferenced variable on non-ACPI configs such as
tegra_defconfig on ARM:

  sound/soc/codecs/rt5640.c:2085:30: warning: 'rt5640_acpi_match' defined but not used [-Wunused-variable]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 sound/soc/codecs/rt5640.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0bfb960..a856706 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2082,11 +2082,13 @@ static const struct i2c_device_id rt5640_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
 
+#if CONFIG_ACPI
 static struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
+#endif
 
 static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
 {
-- 
1.7.10.4
