From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] ASoC: rt5645: Constify ACPI device ids
Date: Sat,  2 Jan 2016 23:23:56 +0100
Message-ID: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D33A7260440
 for <alsa-devel@alsa-project.org>; Sat,  2 Jan 2016 23:24:54 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id f206so167552947wmf.0
 for <alsa-devel@alsa-project.org>; Sat, 02 Jan 2016 14:24:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org

Constify the ACPI device ID array, no need to have it writable at
runtime. Also drop the unused RT5645_INIT_REG_LEN define.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5645.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ef76940f9dcb..38a0b60a7f6e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -64,7 +64,6 @@ static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
 };
-#define RT5645_INIT_REG_LEN ARRAY_SIZE(init_list)
 
 static const struct reg_sequence rt5650_init_list[] = {
 	{0xf6,	0x0100},
@@ -3326,7 +3325,7 @@ static const struct i2c_device_id rt5645_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5645_acpi_match[] = {
+static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
 	{ "10EC5650", 0 },
 	{},
-- 
1.7.10.4
