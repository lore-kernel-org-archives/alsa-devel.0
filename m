From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] ASoC: core: support driver alias names for
	FE topology overrides
Date: Fri,  1 Mar 2019 19:08:51 -0600
Message-ID: <20190302010853.18115-2-pierre-louis.bossart@linux.intel.com>
References: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C99AEF896B8
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 02:09:06 +0100 (CET)
In-Reply-To: <20190302010853.18115-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When the same machine driver is reused between platforms but with a
different alias, using the driver name is not enough. Add additional
fallback case to use the card device name.

Tested on GeminiLake with bxt_da7219_max98357a machine driver

Suggested-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..e1671cfb3cf0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1974,10 +1974,13 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			continue;
 
 		/* for this machine ? */
+		if (!strcmp(component->driver->ignore_machine,
+			    card->dev->driver->name))
+			goto match;
 		if (strcmp(component->driver->ignore_machine,
-			   card->dev->driver->name))
+			   dev_name(card->dev)))
 			continue;
-
+match:
 		/* machine matches, so override the rtd data */
 		for_each_card_prelinks(card, i, dai_link) {
 
-- 
2.17.1
