From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: Simplify format_register_str() without
	stack usages
Date: Tue, 26 May 2015 14:40:14 +0200
Message-ID: <1432644014-16475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 430E726520E
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:40:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Instead of allocating two string buffers on stack and copying them
back, manipulate directly the target string buffer.  This simplifies
the code well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 23732523f87c..ee86f84b7ccc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -92,30 +92,21 @@ static int format_register_str(struct snd_soc_codec *codec,
 	int wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
 	int regsize = codec->driver->reg_word_size * 2;
 	int ret;
-	char tmpbuf[len + 1];
-	char regbuf[regsize + 1];
-
-	/* since tmpbuf is allocated on the stack, warn the callers if they
-	 * try to abuse this function */
-	WARN_ON(len > 63);
 
 	/* +2 for ': ' and + 1 for '\n' */
 	if (wordsize + regsize + 2 + 1 != len)
 		return -EINVAL;
 
-	ret = snd_soc_read(codec, reg);
-	if (ret < 0) {
-		memset(regbuf, 'X', regsize);
-		regbuf[regsize] = '\0';
-	} else {
-		snprintf(regbuf, regsize + 1, "%.*x", regsize, ret);
-	}
-
-	/* prepare the buffer */
-	snprintf(tmpbuf, len + 1, "%.*x: %s\n", wordsize, reg, regbuf);
-	/* copy it back to the caller without the '\0' */
-	memcpy(buf, tmpbuf, len);
+	sprintf(buf, "%.*x: ", wordsize, reg);
+	buf += wordsize + 2;
 
+	ret = snd_soc_read(codec, reg);
+	if (ret < 0)
+		memset(buf, 'X', regsize);
+	else
+		sprintf(buf, "%.*x", regsize, ret);
+	buf[regsize] = '\n';
+	/* no NUL-termination needed */
 	return 0;
 }
 
-- 
2.4.1
