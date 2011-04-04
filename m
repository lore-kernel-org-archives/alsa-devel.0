From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix comment width in soc-cache.c
Date: Mon,  4 Apr 2011 17:56:24 +0900
Message-ID: <1301907384-13094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 435BD10380E
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 15:32:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Lines should be less than 80 columns.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 5655fce..3e7f691 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -393,10 +393,11 @@ static int snd_soc_16_16_spi_write(void *control_data, const char *data,
 #define snd_soc_16_16_spi_write NULL
 #endif
 
-/* Primitive bulk write support for soc-cache.  The data pointed to by `data' needs
- * to already be in the form the hardware expects including any leading register specific
- * data.  Any data written through this function will not go through the cache as it
- * only handles writing to volatile or out of bounds registers.
+/* Primitive bulk write support for soc-cache.  The data pointed to by
+ * `data' needs to already be in the form the hardware expects
+ * including any leading register specific data.  Any data written
+ * through this function will not go through the cache as it only
+ * handles writing to volatile or out of bounds registers.
  */
 static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int reg,
 				     const void *data, size_t len)
-- 
1.7.4.1
