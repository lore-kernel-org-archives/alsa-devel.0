From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: rt286: Constify dmi_system_id table
Date: Sun, 28 Jun 2015 11:40:22 +0800
Message-ID: <1435462822.15772.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C5AA2605E1
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 05:40:28 +0200 (CEST)
Received: by padev16 with SMTP id ev16so87897260pad.0
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 20:40:27 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

dmi_check_system() takes "const struct dmi_system_id *", so make the
dmi_system_id table const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt286.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 5c43e26..382fedb 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1108,7 +1108,7 @@ static const struct acpi_device_id rt286_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
 
-static struct dmi_system_id force_combo_jack_table[] = {
+static const struct dmi_system_id force_combo_jack_table[] = {
 	{
 		.ident = "Intel Wilson Beach",
 		.matches = {
@@ -1118,7 +1118,7 @@ static struct dmi_system_id force_combo_jack_table[] = {
 	{ }
 };
 
-static struct dmi_system_id dmi_dell_dino[] = {
+static const struct dmi_system_id dmi_dell_dino[] = {
 	{
 		.ident = "Dell Dino",
 		.matches = {
-- 
2.1.0
