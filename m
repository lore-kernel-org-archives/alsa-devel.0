From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] sound: HDA: remove an unused field from struct
	hda_codec
Date: Wed, 12 Jun 2019 11:36:54 -0500
Message-ID: <20190612163654.3966-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98EC6F806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:37:12 +0200 (CEST)
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
Cc: tiwai@suse.de, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

The .jacks field in struct hda_codec is unused and seems to be a
duplicate of .jacktbl, remove it.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hda_codec.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index a7c602576b68..0b0a6a2ffb35 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -268,9 +268,6 @@ struct hda_codec {
 	unsigned long jackpoll_interval; /* In jiffies. Zero means no poll, rely on unsol events */
 	struct delayed_work jackpoll_work;
 
-	/* jack detection */
-	struct snd_array jacks;
-
 	int depop_delay; /* depop delay in ms, -1 for default delay time */
 
 	/* fix-up list */
-- 
2.20.1
