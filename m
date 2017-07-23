From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/4] ASoC: rt5665: constify acpi_device_id.
Date: Sun, 23 Jul 2017 22:53:27 +0530
Message-ID: <1500830607-17268-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500830607-17268-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500830607-17268-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

acpi_device_id are not supposed to change at runtime. All functions
working with acpi_device_id provided by <acpi/acpi_bus.h> work with
const acpi_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 370ed54d..526935a 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4927,7 +4927,7 @@ MODULE_DEVICE_TABLE(of, rt5665_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5665_acpi_match[] = {
+static const struct acpi_device_id rt5665_acpi_match[] = {
 	{"10EC5665", 0,},
 	{"10EC5666", 0,},
 	{"10EC5668", 0,},
-- 
2.7.4
