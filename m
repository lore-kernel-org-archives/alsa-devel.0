From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/17] ASoC: rt5640: Add "10EC3276" ACPI ID
Date: Thu, 26 Jan 2017 14:09:31 -0600
Message-ID: <1485461385-14544-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F6CD267774
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:22 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Alexandrov Stansilav <neko@nya.ai>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Alexandrov Stansilav <neko@nya.ai>

Add ACPI ID "10EC3276" for sound card found on notebook HP Pavilion X2 10-p000.
ACPI DSDT Table on this device describes this card as ALC3276, but it is in fact rt5640.

Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

Notes:
    Acked-by: Vinod Koul <vinod.koul@intel.com> on alsa-devel but
    Mark was not copied and the author did not resend the patches

 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 33e080f..1584ccc 100644
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
2.7.4
