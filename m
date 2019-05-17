From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: rt5677-spi: Handle over reading when
	flipping bytes
Date: Thu, 16 May 2019 18:43:40 -0700
Message-ID: <20190517014341.133938-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43619F806E7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 03:43:57 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id y3so2538713plp.0
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 18:43:57 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

There is a case when a we want to read a large number of bytes that
require a burst but is not a multiple of the word size (8). When this
happens rt5677_spi_reverse will run off the end of the buffer. The
solution is to tell spi_reverse the actual size of the destination and
stop if we reach it even if we have data left that we read.

Cc: Ben Zhang <benzh@chromium.org>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/codecs/rt5677-spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 84b6bd8b50e1..a4dfa0345c6e 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -101,7 +101,7 @@ static void rt5677_spi_reverse(u8 *dst, u32 dstlen, const u8 *src, u32 srclen)
 	u32 word_size = min_t(u32, dstlen, 8);
 
 	for (w = 0; w < dstlen; w += word_size) {
-		for (i = 0; i < word_size; i++) {
+		for (i = 0; i < word_size && i + w < dstlen; i++) {
 			si = w + word_size - i - 1;
 			dst[w + i] = si < srclen ? src[si] : 0;
 		}
@@ -152,8 +152,9 @@ int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
 		status |= spi_sync(g_spi, &m);
 		mutex_unlock(&spi_mutex);
 
+
 		/* Copy data back to caller buffer */
-		rt5677_spi_reverse(cb + offset, t[1].len, body, t[1].len);
+		rt5677_spi_reverse(cb + offset, len - offset, body, t[1].len);
 	}
 	return status;
 }
-- 
2.21.0.1020.gf2820cf01a-goog
