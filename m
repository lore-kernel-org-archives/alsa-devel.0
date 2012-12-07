From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: sigmadsp: Fix endianness conversion issue
Date: Fri,  7 Dec 2012 18:30:51 +0100
Message-ID: <1354901451-31820-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-243.synserver.de (smtp-out-243.synserver.de
 [212.40.185.243])
 by alsa0.perex.cz (Postfix) with ESMTP id A6B9726511F
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 18:31:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The 'addr' field of the sigma_action struct is stored as big endian in the
firmware file.

Cc: stable@vger.kernel.org
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sigmadsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 5be42bf..4068f24 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -225,7 +225,7 @@ EXPORT_SYMBOL(process_sigma_firmware);
 static int sigma_action_write_regmap(void *control_data,
 	const struct sigma_action *sa, size_t len)
 {
-	return regmap_raw_write(control_data, le16_to_cpu(sa->addr),
+	return regmap_raw_write(control_data, be16_to_cpu(sa->addr),
 		sa->payload, len - 2);
 }
 
-- 
1.8.0
