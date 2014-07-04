From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v5 4/5] ASoC: compress: Prevent multicodec for
	compressed stream
Date: Fri,  4 Jul 2014 18:07:54 +0200
Message-ID: <1404490075-24997-5-git-send-email-bcousson@baylibre.com>
References: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 26A50265A31
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 18:09:34 +0200 (CEST)
Received: by mail-we0-f178.google.com with SMTP id x48so1860504wes.37
 for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2014 09:09:33 -0700 (PDT)
In-Reply-To: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Multiple codecs does not make sense in the case of compressed
stream.

Exit with error if it happens.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Cc: Vinod Koul <vinod.koul@intel.com>
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
