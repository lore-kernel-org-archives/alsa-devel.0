From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/3] ASoC: sglt5000: Provide the reg_stride
	field
Date: Thu,  4 Jul 2013 20:01:01 -0300
Message-ID: <1372978863-4872-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f50.google.com (mail-yh0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F912657EC
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 01:01:49 +0200 (CEST)
Received: by mail-yh0-f50.google.com with SMTP id i72so641481yha.23
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 16:01:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

sgtl5000 has 16-bit registers, and only even numbers are valid for its registers
addresses.

Let regmap knows about this feature by specifying the 'reg_stride' field, so 
that it can access only the valid registers.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix the description in the commit log

 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d441559..7c99f3c 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1470,6 +1470,7 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 static const struct regmap_config sgtl5000_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
+	.reg_stride = 2,
 
 	.max_register = SGTL5000_MAX_REG_OFFSET,
 	.volatile_reg = sgtl5000_volatile,
-- 
1.8.1.2
