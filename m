From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Don't use async I/O
Date: Tue, 16 Dec 2014 17:08:18 +0000
Message-ID: <1418749698-10667-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE970260654
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 18:08:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmial.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The only user of the async I/O support in ASoC is SPI which was using it to
avoid needless context thrashing and minimise controller runtime PM bounces.
The SPI framework has now been enhanced so that even normal spi_sync() calls
won't suffer these effects so we don't need to handle this in ASoC and in
fact it can be more efficient not to since we don't need to set up and tear
down the buffers needed to manage asynchronous I/O.

The async completions that DAPM does are left in place so drivers can use
them, they are very cheap if there is no asynchronous work queued.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5136bb1f982..fe06b028130f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -517,8 +517,8 @@ static int soc_dapm_update_bits(struct snd_soc_dapm_context *dapm,
 {
 	if (!dapm->component)
 		return -EIO;
-	return snd_soc_component_update_bits_async(dapm->component, reg,
-		mask, value);
+	return snd_soc_component_update_bits(dapm->component, reg,
+					     mask, value);
 }
 
 static int soc_dapm_test_bits(struct snd_soc_dapm_context *dapm,
-- 
2.1.3
