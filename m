From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Fix null pointer dereference
Date: Tue,  7 Dec 2010 16:21:06 +0000
Message-ID: <1291738866-24470-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B735103840
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 17:21:08 +0100 (CET)
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

In case the codec driver did not provide a read/write function,
codec->driver->read|write will be NULL.  Ensure that we use the one
specified in codec->read|write to avoid oopsing when we access
the debugfs entries.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 392d336..078f9df 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -117,7 +117,7 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 			 * the register being volatile and the device being
 			 * powered off.
 			 */
-			ret = codec->driver->read(codec, i);
+			ret = codec->read(codec, i);
 			if (ret >= 0)
 				count += snprintf(buf + count,
 						  PAGE_SIZE - count,
@@ -228,7 +228,7 @@ static ssize_t codec_reg_write_file(struct file *file,
 		start++;
 	if (strict_strtoul(start, 16, &value))
 		return -EINVAL;
-	codec->driver->write(codec, reg, value);
+	codec->write(codec, reg, value);
 	return buf_size;
 }
 
-- 
1.7.3.3
