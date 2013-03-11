From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: core: fix possible memory leak in snd_soc_bytes_put()
Date: Tue, 12 Mar 2013 00:35:14 +0800
Message-ID: <CAPgLHd_DuPDciAt9Qdn-1K2CSL14GDKt6XR+8gaac8hgvLScaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

'data' is malloced in snd_soc_bytes_put() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/soc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b7e84a7..93341de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3140,7 +3140,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	if (params->mask) {
 		ret = regmap_read(codec->control_data, params->base, &val);
 		if (ret != 0)
-			return ret;
+			goto out;
 
 		val &= params->mask;
 
@@ -3158,13 +3158,15 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 			((u32 *)data)[0] |= cpu_to_be32(val);
 			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 	}
 
 	ret = regmap_raw_write(codec->control_data, params->base,
 			       data, len);
 
+out:
 	kfree(data);
 
 	return ret;
