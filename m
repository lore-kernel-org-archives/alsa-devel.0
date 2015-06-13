From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 2/4] ASoC: rt5640: Constify ACPI device ids and
	register map
Date: Sat, 13 Jun 2015 14:25:14 +0200
Message-ID: <1434198316-8400-3-git-send-email-minipli@googlemail.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 98BAA26057F
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:25:29 +0200 (CEST)
Received: by wifx6 with SMTP id x6so37082206wif.0
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:25:29 -0700 (PDT)
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
them writable at runtime. Also drop the unneeded RT5640_INIT_REG_LEN
define.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Bard Liao <bardliao@realtek.com
Cc: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 178e55d4d481..914681978222 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -51,7 +51,7 @@ static const struct regmap_range_cfg rt5640_ranges[] = {
 	  .window_len = 0x1, },
 };
 
-static struct reg_default init_list[] = {
+static const struct reg_default init_list[] = {
 	{RT5640_PR_BASE + 0x3d,	0x3600},
 	{RT5640_PR_BASE + 0x12,	0x0aa8},
 	{RT5640_PR_BASE + 0x14,	0x0aaa},
@@ -59,7 +59,6 @@ static struct reg_default init_list[] = {
 	{RT5640_PR_BASE + 0x21,	0xe0e0},
 	{RT5640_PR_BASE + 0x23,	0x1804},
 };
-#define RT5640_INIT_REG_LEN ARRAY_SIZE(init_list)
 
 static const struct reg_default rt5640_reg[] = {
 	{ 0x00, 0x000e },
@@ -2122,7 +2121,7 @@ MODULE_DEVICE_TABLE(of, rt5640_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5640_acpi_match[] = {
+static const struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
 	{ "10EC5640", 0 },
 	{ "10EC5642", 0 },
-- 
1.7.10.4
