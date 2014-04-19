From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: Change return type of
	snd_soc_write() to int
Date: Sat, 19 Apr 2014 10:43:57 +0200
Message-ID: <1397897042-20092-3-git-send-email-lars@metafoo.de>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-120.synserver.de
 [212.40.185.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 29470261A7C
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 10:44:11 +0200 (CEST)
In-Reply-To: <1397897042-20092-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sven Brandau <brandau@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The CODEC's write callback can return a negative error code, make sure to pass
that on correctly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 4 ++--
 sound/soc/soc-io.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index dda179d..de62475 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1126,8 +1126,8 @@ static inline struct snd_soc_platform *snd_soc_component_to_platform(
 
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
-unsigned int snd_soc_write(struct snd_soc_codec *codec,
-			   unsigned int reg, unsigned int val);
+int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int val);
 
 /* device driver data */
 
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 14bdf79..dc0c09d 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -31,8 +31,8 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
 }
 EXPORT_SYMBOL_GPL(snd_soc_read);
 
-unsigned int snd_soc_write(struct snd_soc_codec *codec,
-			   unsigned int reg, unsigned int val)
+int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int val)
 {
 	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
 	trace_snd_soc_reg_write(codec, reg, val);
-- 
1.8.0
