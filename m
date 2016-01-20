From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: avoid unused variable warning for
	rt5659_acpi_match
Date: Wed, 20 Jan 2016 11:43:48 +0100
Message-ID: <2238845.aZnycJVYKR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A9A260412
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 11:44:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The newly added rt5659 codec driver unconditionally defines an
ACPI device match table but then uses ACPI_PTR() to remove the
only reference to it, so we get a harmless build warning:

sound/soc/codecs/rt5659.c:4200:30: warning: 'rt5659_acpi_match' defined but not used [-Wunused-variable]
 static struct acpi_device_id rt5659_acpi_match[] = {

This removes the ACPI_PTR() to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is a harmless regression against v4.4, found on ARM randconfig builds

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index c166d9394c69..5a1d789ba58d 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4201,7 +4201,7 @@ struct i2c_driver rt5659_i2c_driver = {
 		.name = "rt5659",
 		.owner = THIS_MODULE,
 		.of_match_table = rt5659_of_match,
-		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
+		.acpi_match_table = rt5659_acpi_match,
 	},
 	.probe = rt5659_i2c_probe,
 	.remove = rt5659_i2c_remove,
