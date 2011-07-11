From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH 2/2] ASoC: STA32x: Preserve reserved register
	bits
Date: Mon, 11 Jul 2011 17:01:24 +0200
Message-ID: <1310396484-23371-3-git-send-email-js@sig21.net>
References: <1310396484-23371-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 9916924519
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 17:01:46 +0200 (CEST)
In-Reply-To: <1310396484-23371-1-git-send-email-js@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Chip documentation explicitly requires that the reset values
of reserved register bits are left untouched.  It is possible
there are differences between STA326 and STA328 or future
chip revisions in these bits, and clobbering them might
cause malfunction.

Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 sound/soc/codecs/sta32x.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 9bf944c..409d89d 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -756,6 +756,22 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < STA32X_REGISTER_COUNT; i++)
 		snd_soc_cache_write(codec, i, sta32x_regs[i]);
 
+	/* preserve reset values of reserved register bits */
+	snd_soc_cache_write(codec, STA32X_CONFC,
+			    codec->hw_read(codec, STA32X_CONFC));
+	snd_soc_cache_write(codec, STA32X_CONFE,
+			    codec->hw_read(codec, STA32X_CONFE));
+	snd_soc_cache_write(codec, STA32X_CONFF,
+			    codec->hw_read(codec, STA32X_CONFF));
+	snd_soc_cache_write(codec, STA32X_MMUTE,
+			    codec->hw_read(codec, STA32X_MMUTE));
+	snd_soc_cache_write(codec, STA32X_AUTO1,
+			    codec->hw_read(codec, STA32X_AUTO1));
+	snd_soc_cache_write(codec, STA32X_AUTO3,
+			    codec->hw_read(codec, STA32X_AUTO3));
+	snd_soc_cache_write(codec, STA32X_C3CFG,
+			    codec->hw_read(codec, STA32X_C3CFG));
+
 	/* FIXME enable thermal warning adjustment and recovery  */
 	snd_soc_update_bits(codec, STA32X_CONFA,
 			    STA32X_CONFA_TWAB | STA32X_CONFA_TWRB, 0);
-- 
1.7.5.4
