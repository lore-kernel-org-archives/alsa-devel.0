From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v6 4/5] ASoC: compress: Prevent multicodec for
	compressed stream
Date: Tue,  8 Jul 2014 23:19:37 +0200
Message-ID: <1404854378-25828-5-git-send-email-bcousson@baylibre.com>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7299D261ACB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 23:21:00 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id u56so6571413wes.7
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 14:21:00 -0700 (PDT)
In-Reply-To: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Multiple codecs does not make sense in the case of compressed
stream.

Exit with error if it happens.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Tested-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-compress.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index f96fb96..27c06ac 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -629,6 +629,11 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	char new_name[64];
 	int ret = 0, direction = 0;
 
+	if (rtd->num_codecs > 1) {
+		dev_err(rtd->card->dev, "Multicodec not supported for compressed stream\n");
+		return -EINVAL;
+	}
+
 	/* check client and interface hw capabilities */
 	snprintf(new_name, sizeof(new_name), "%s %s-%d",
 			rtd->dai_link->stream_name, codec_dai->name, num);
-- 
1.9.1
