From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: hal2: Fix a typo in two comment lines
Date: Sat, 11 Nov 2017 19:15:06 +0100
Message-ID: <cebdb072-5ac8-b7c8-97b3-bc9c66838774@users.sourceforge.net>
References: <118a96d5-c52a-fd22-23d5-28f20de7ff22@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B0E2671BE
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 19:15:12 +0100 (CET)
In-Reply-To: <118a96d5-c52a-fd22-23d5-28f20de7ff22@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: trivial@kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 18:48:41 +0100

Add a missing character in these descriptions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/mips/hal2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 675c3aba794e..4fa5f161ef2d 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -388,7 +388,7 @@ static void hal2_setup_dac(struct snd_hal2 *hal2)
 	hal2_i_clearbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECTX);
 	/* Setup the HAL2 for playback */
 	hal2_set_dac_rate(hal2);
-	/* Set endianess */
+	/* Set endianness */
 	hal2_i_clearbit16(hal2, H2I_DMA_END, H2I_DMA_END_CODECTX);
 	/* Set DMA bus */
 	hal2_i_setbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
@@ -413,7 +413,7 @@ static void hal2_setup_adc(struct snd_hal2 *hal2)
 	hal2_i_clearbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECR);
 	/* Setup the HAL2 for record */
 	hal2_set_adc_rate(hal2);
-	/* Set endianess */
+	/* Set endianness */
 	hal2_i_clearbit16(hal2, H2I_DMA_END, H2I_DMA_END_CODECR);
 	/* Set DMA bus */
 	hal2_i_setbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
-- 
2.15.0
