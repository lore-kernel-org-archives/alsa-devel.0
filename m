From: Chen Gang <gang.chen@sunrus.com.cn>
Subject: [PATCH] sound: soc: soc-pcm: Remove useless varialbe 'i'
Date: Sat, 03 Jan 2015 17:45:57 +0800
Message-ID: <54A7BA55.3020607@sunrus.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

'i' is useless in soc_pcm_set_msb(), so remove it, the related warning
(with allmodconfig under s390):

    CC [M]  sound/soc/soc-pcm.o
  sound/soc/soc-pcm.c: In function 'soc_pcm_set_msb':
  sound/soc/soc-pcm.c:307:11: warning: unused variable 'i' [-Wunused-variable]
    int ret, i;
             ^

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 sound/soc/soc-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d6e8d6b..6b0136e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -304,7 +304,7 @@ static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
 static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int ret, i;
+	int ret;
 
 	if (!bits)
 		return;
-- 
1.7.9.5
