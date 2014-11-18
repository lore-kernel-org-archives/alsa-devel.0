From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: rt286: build warning of section mismatch
Date: Tue, 18 Nov 2014 17:42:54 +0530
Message-ID: <1416312774-4472-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Sudip Mukherjee <sudip@vectorindia.org>

while building we were getting the following build warning:

Section mismatch in reference from the function rt286_i2c_probe()
to the variable .init.data:force_combo_jack_table
The function rt286_i2c_probe() references
the variable __initdata force_combo_jack_table.
This is often because rt286_i2c_probe lacks a __initdata
annotation or the annotation of force_combo_jack_table is wrong.

we were getting the warning as force_combo_jack_table was marked
with __initdata

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 2e818aa..2cd4fe4 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1206,7 +1206,7 @@ static const struct acpi_device_id rt286_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
 
-static struct dmi_system_id force_combo_jack_table[] __initdata = {
+static struct dmi_system_id force_combo_jack_table[] = {
 	{
 		.ident = "Intel Wilson Beach",
 		.matches = {
-- 
1.8.1.2
