From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 05/12] ASoC: cs4270: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:52:01 -0500
Message-ID: <b499e94ee4c9cd58b2cf07888f7723daf3a40a7f.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/cs4270.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 2a7a416..3c266ee 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -219,7 +219,7 @@ static bool cs4270_reg_is_volatile(struct device *dev, unsigned int reg)
 {
 	/* Unreadable registers are considered volatile */
 	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
-		return 1;
+		return true;
 
 	return reg == CS4270_CHIPID;
 }
-- 
2.7.4
