From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs35l34: Remove CS35L34_CHIP_ID from
	cs35l34_readable_register
Date: Tue, 25 Oct 2016 22:39:36 +0800
Message-ID: <1477406376-16054-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA6F2665B1
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 16:39:59 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id s8so19846617pfj.2
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 07:39:59 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

CS35L34_CHIP_ID is not a register address, it's the value read from
CS35L34_DEVID_AB/CD/E registers.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l34.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 4045383..e0f672a 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -145,7 +145,6 @@ static bool cs35l34_volatile_register(struct device *dev, unsigned int reg)
 static bool cs35l34_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case	CS35L34_CHIP_ID:
 	case	CS35L34_DEVID_AB:
 	case	CS35L34_DEVID_CD:
 	case	CS35L34_DEVID_E:
-- 
2.7.4
