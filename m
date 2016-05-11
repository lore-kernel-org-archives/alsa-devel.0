From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: max98371 Remove duplicate entry in
	max98371_reg
Date: Wed, 11 May 2016 11:48:11 +0800
Message-ID: <1462938491.444.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
 [209.85.220.68])
 by alsa0.perex.cz (Postfix) with ESMTP id EE76B2604AA
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 05:48:20 +0200 (CEST)
Received: by mail-pa0-f68.google.com with SMTP id gh9so2600380pac.0
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:48:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98371.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 21fae09..cf0a39b 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -107,7 +107,6 @@ static const struct reg_default max98371_reg[] = {
 	{ 0x39, 0x00 },
 	{ 0x3A, 0x00 },
 	{ 0x3B, 0x00 },
-	{ 0x3B, 0x00 },
 	{ 0x3C, 0x00 },
 	{ 0x3D, 0x00 },
 	{ 0x3E, 0x00 },
-- 
2.5.0
