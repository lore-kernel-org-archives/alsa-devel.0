From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 3/4] ASoC: rt5670: Constify ACPI device ids and
	register map
Date: Sat, 13 Jun 2015 14:25:15 +0200
Message-ID: <1434198316-8400-4-git-send-email-minipli@googlemail.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 6004726058A
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:25:31 +0200 (CEST)
Received: by wiga1 with SMTP id a1so36866775wig.0
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:25:30 -0700 (PDT)
In-Reply-To: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mathias Krause <minipli@googlemail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Constify the ACPI device ID array and the register map, no need to have
them writable at runtime. Also drop the unneeded RT5670_INIT_REG_LEN
define.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com
---
 sound/soc/codecs/rt5670.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index cc7f84a150a7..f87a6dabbd49 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -51,12 +51,11 @@ static const struct regmap_range_cfg rt5670_ranges[] = {
 	  .window_len = 0x1, },
 };
 
-static struct reg_default init_list[] = {
+static const struct reg_default init_list[] = {
 	{ RT5670_PR_BASE + 0x14, 0x9a8a },
 	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
 	{ RT5670_PR_BASE + 0x3d, 0x3640 },
 };
-#define RT5670_INIT_REG_LEN ARRAY_SIZE(init_list)
 
 static const struct reg_default rt5670_reg[] = {
 	{ 0x00, 0x0000 },
@@ -2809,7 +2808,7 @@ static const struct i2c_device_id rt5670_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5670_acpi_match[] = {
+static const struct acpi_device_id rt5670_acpi_match[] = {
 	{ "10EC5670", 0},
 	{ },
 };
-- 
1.7.10.4
