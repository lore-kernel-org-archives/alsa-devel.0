From: Alexandrov Stansilav <neko@nya.ai>
Subject: [PATCH v2 1/2] ASoC: rt5640: Add support for rt5640
	sound card found on HP Pavilion x2 10-p000 tablet.
Date: Wed,  4 Jan 2017 15:22:12 +0300
Message-ID: <9e2493401df1f2f0419fa175b4fc9a84eb971e28.1483531270.git.neko@nya.ai>
References: <cover.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thorium.nya.ai (thorium.nya.ai [109.195.179.38])
 by alsa0.perex.cz (Postfix) with ESMTP id D715D2674E7
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 13:22:17 +0100 (CET)
In-Reply-To: <cover.1483531270.git.neko@nya.ai>
In-Reply-To: <cover.1483531270.git.neko@nya.ai>
References: <cover.1483531270.git.neko@nya.ai>
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
