From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: sirf: remove duplicated bit-wise or of
	USP_RXFIFO_THD_INT
Date: Fri, 23 Feb 2018 12:41:17 +0000
Message-ID: <20180223124117.24686-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 706972678B5
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 13:41:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern USP_RXFIFO_THD_INT is being bit-wise or'd twice;
remove the redundant 2nd USP_RXFIFO_THD_INT

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sirf/sirf-usp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sirf/sirf-usp.h b/sound/soc/sirf/sirf-usp.h
index bf0201cb15bc..e22e13a619e8 100644
--- a/sound/soc/sirf/sirf-usp.h
+++ b/sound/soc/sirf/sirf-usp.h
@@ -154,7 +154,7 @@
 					USP_RX_IO_DMA_INT|\
 					USP_RXFIFO_FULL_INT|\
 					USP_RXFIFO_THD_INT|\
-					USP_RXFIFO_THD_INT|USP_RX_TIMEOUT_INT)
+					USP_RX_TIMEOUT_INT)
 
 #define USP_INT_ALL        0x1FFF
 
-- 
2.15.1
