From: Alexandrov Stansilav <neko@nya.ai>
Subject: [PATCH v3 1/2] ASoC: rt5640: Add "10EC3276" ACPI ID
Date: Fri,  6 Jan 2017 03:09:46 +0300
Message-ID: <2c5644584d8eff80090648810783ed3f37e4d4f8.1483660468.git.neko@nya.ai>
References: <cover.1483660468.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thorium.nya.ai (thorium.nya.ai [109.195.179.38])
 by alsa0.perex.cz (Postfix) with ESMTP id BACBB266E0D
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 01:09:54 +0100 (CET)
In-Reply-To: <cover.1483660468.git.neko@nya.ai>
In-Reply-To: <cover.1483660468.git.neko@nya.ai>
References: <cover.1483660468.git.neko@nya.ai>
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
Cc: vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add ACPI ID "10EC3276" for sound card found on notebook HP Pavilion X2 10-p000.
ACPI DSDT Table on this device describes this card as ALC3276, but it is in fact rt5640.

Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e29a6de..b857a71 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2313,6 +2313,7 @@ MODULE_DEVICE_TABLE(of, rt5640_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
+	{ "10EC3276", 0 },
 	{ "10EC5640", 0 },
 	{ "10EC5642", 0 },
 	{ "INTCCFFD", 0 },
-- 
2.10.2
