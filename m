From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ASoC: tas5086: fix TAS5086_CLOCK_CONTROL
	register size
Date: Thu, 27 Jun 2013 21:59:10 +0200
Message-ID: <1372363151-31082-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FD20265636
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 21:58:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The TAS5086_CLOCK_CONTROL also has a size of 1 byte.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index fec9a28..84c3f27 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -130,7 +130,7 @@ static const struct reg_default tas5086_reg_defaults[] = {
 static int tas5086_register_size(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case TAS5086_DEV_ID ... TAS5086_BKNDERR:
+	case TAS5086_CLOCK_CONTROL ... TAS5086_BKNDERR:
 		return 1;
 	case TAS5086_INPUT_MUX:
 	case TAS5086_PWM_OUTPUT_MUX:
-- 
1.8.1.4
