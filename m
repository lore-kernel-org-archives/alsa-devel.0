From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] ASoC: max9867: Constify max9867_reg and
	max9867_regmap
Date: Sat, 20 Feb 2016 10:54:11 +0800
Message-ID: <1455936851.19371.2.camel@ingics.com>
References: <1455936752.19371.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF67266B02
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 03:54:16 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id ho8so61410275pac.2
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 18:54:16 -0800 (PST)
In-Reply-To: <1455936752.19371.0.camel@ingics.com>
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
 sound/soc/codecs/max9867.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 70b5406..ab7a94d 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -436,7 +436,7 @@ static bool max9867_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct reg_default max9867_reg[] = {
+static const struct reg_default max9867_reg[] = {
 	{ 0x04, 0x00 },
 	{ 0x05, 0x00 },
 	{ 0x06, 0x00 },
@@ -459,7 +459,7 @@ static struct reg_default max9867_reg[] = {
 	{ 0x17, 0x00 },
 };
 
-static struct regmap_config max9867_regmap = {
+static const struct regmap_config max9867_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
 	.max_register	= MAX9867_REVISION,
-- 
2.1.4
