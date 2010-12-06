From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Replace use of strncpy() with
	strlcpy()
Date: Mon,  6 Dec 2010 15:42:17 +0000
Message-ID: <1291650137-7484-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04E4E1038BE
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 16:42:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

By using strncpy() if the source string does not have a null byte in the
first n bytes, then the destination string is not null-terminated.
This can be fixed in a two-step process by manually null-terminating the
array after the use of strncpy() or by using strlcpy().

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd284a7..e586616 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3202,7 +3202,7 @@ static inline char *fmt_single_name(struct device *dev, int *id)
 	if (dev_name(dev) == NULL)
 		return NULL;
 
-	strncpy(name, dev_name(dev), NAME_SIZE);
+	strlcpy(name, dev_name(dev), NAME_SIZE);
 
 	/* are we a "%s.%d" name (platform and SPI components) */
 	found = strstr(name, dev->driver->name);
@@ -3225,7 +3225,7 @@ static inline char *fmt_single_name(struct device *dev, int *id)
 
 			/* sanitize component name for DAI link creation */
 			snprintf(tmp, NAME_SIZE, "%s.%s", dev->driver->name, name);
-			strncpy(name, tmp, NAME_SIZE);
+			strlcpy(name, tmp, NAME_SIZE);
 		} else
 			*id = 0;
 	}
-- 
1.7.3.3
