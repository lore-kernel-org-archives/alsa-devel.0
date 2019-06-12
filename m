From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 6/6] Avoid pointer arithmetic on `void *`
Date: Tue, 11 Jun 2019 23:08:14 -0700
Message-ID: <20190612060814.13534-7-mforney@mforney.org>
References: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9413F896EA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:24 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id s11so8953645pfm.12
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:24 -0700 (PDT)
In-Reply-To: <20190612060814.13534-1-mforney@mforney.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The pointer operand to the binary `+` operator must be to a complete
object type.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 src/pcm/pcm_rate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 5dc8a927..fdcaa8de 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -300,10 +300,10 @@ static int snd_pcm_rate_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	rate->sareas = rate->pareas + channels;
 	rate->sareas[0].addr = (char *)rate->pareas[0].addr + ((cwidth * channels * cinfo->period_size) / 8);
 	for (chn = 0; chn < channels; chn++) {
-		rate->pareas[chn].addr = rate->pareas[0].addr + (cwidth * chn * cinfo->period_size) / 8;
+		rate->pareas[chn].addr = (char *)rate->pareas[0].addr + (cwidth * chn * cinfo->period_size) / 8;
 		rate->pareas[chn].first = 0;
 		rate->pareas[chn].step = cwidth;
-		rate->sareas[chn].addr = rate->sareas[0].addr + (swidth * chn * sinfo->period_size) / 8;
+		rate->sareas[chn].addr = (char *)rate->sareas[0].addr + (swidth * chn * sinfo->period_size) / 8;
 		rate->sareas[chn].first = 0;
 		rate->sareas[chn].step = swidth;
 	}
@@ -513,14 +513,14 @@ static void do_convert(const snd_pcm_channel_area_t *dst_areas,
 		const int16_t *src;
 		int16_t *dst;
 		if (! rate->src_buf)
-			src = src_areas->addr + src_offset * 2 * channels;
+			src = (int16_t *)src_areas->addr + src_offset * channels;
 		else {
 			convert_to_s16(rate, rate->src_buf, src_areas, src_offset,
 				       src_frames, channels);
 			src = rate->src_buf;
 		}
 		if (! rate->dst_buf)
-			dst = dst_areas->addr + dst_offset * 2 * channels;
+			dst = (int16_t *)dst_areas->addr + dst_offset * channels;
 		else
 			dst = rate->dst_buf;
 		rate->ops.convert_s16(rate->obj, dst, dst_frames, src, src_frames);
-- 
2.20.1
