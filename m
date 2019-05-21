From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677-spi: Handle over reading when
	flipping bytes" to the asoc tree
Date: Tue, 21 May 2019 21:32:43 +0100 (BST)
Message-ID: <20190521203243.9A6CE1126D23@debutante.sirena.org.uk>
References: <20190517014341.133938-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DB9DF8972D
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:51 +0200 (CEST)
In-Reply-To: <20190517014341.133938-1-cujomalainey@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677-spi: Handle over reading when flipping bytes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7b8164c1a29ce8ef91672c50ceac5c14475f5601 Mon Sep 17 00:00:00 2001
From: Curtis Malainey <cujomalainey@chromium.org>
Date: Thu, 16 May 2019 18:43:40 -0700
Subject: [PATCH] ASoC: rt5677-spi: Handle over reading when flipping bytes

There is a case when a we want to read a large number of bytes that
require a burst but is not a multiple of the word size (8). When this
happens rt5677_spi_reverse will run off the end of the buffer. The
solution is to tell spi_reverse the actual size of the destination and
stop if we reach it even if we have data left that we read.

Cc: Ben Zhang <benzh@chromium.org>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
