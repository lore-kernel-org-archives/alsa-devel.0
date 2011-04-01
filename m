From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/2] ASoC: format_register_str: Don't clip
	register values
Date: Fri,  1 Apr 2011 14:50:44 -0600
Message-ID: <1301691044-24080-2-git-send-email-swarren@nvidia.com>
References: <1301691044-24080-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 95FB910384F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 22:50:55 +0200 (CEST)
In-Reply-To: <1301691044-24080-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

wordsize is used as the textual width of a register address.

regsize is used as the textual width of a register value.

The assignments to these values were swapped. In the case of WM8903, which
has 8-bit register addresses and 16-bit register values, this caused the
register values to be clipped to 2 digits instead of the full 4.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4dda589..b76b74d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -92,8 +92,8 @@ static int min_bytes_needed(unsigned long val)
 static int format_register_str(struct snd_soc_codec *codec,
 			       unsigned int reg, char *buf, size_t len)
 {
-	int wordsize = codec->driver->reg_word_size * 2;
-	int regsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
+	int wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
+	int regsize = codec->driver->reg_word_size * 2;
 	int ret;
 	char tmpbuf[len + 1];
 	char regbuf[regsize + 1];
@@ -132,8 +132,8 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
 	size_t total = 0;
 	loff_t p = 0;
 
-	wordsize = codec->driver->reg_word_size * 2;
-	regsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
+	wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
+	regsize = codec->driver->reg_word_size * 2;
 
 	len = wordsize + regsize + 2 + 1;
 
-- 
1.7.1
