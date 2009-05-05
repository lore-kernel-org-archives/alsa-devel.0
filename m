From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 18/18] ASoC: Remove redundant codec pointer
	from DAIs
Date: Tue,  5 May 2009 11:02:31 +0100
Message-ID: <1241517751-2634-18-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13D16103800
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:36 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DAI structure has two pointers to the codec, one in the body of the
DAI and one in a union for a parent pointer.  Drop the parent pointer
version.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index a997c2c..496dc30 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -205,11 +205,8 @@ struct snd_soc_dai {
 	/* DAI private data */
 	void *private_data;
 
-	/* parent codec/platform */
-	union {
-		struct snd_soc_codec *codec;
-		struct snd_soc_platform *platform;
-	};
+	/* parent platform */
+	struct snd_soc_platform *platform;
 
 	struct list_head list;
 };
-- 
1.6.2.4
