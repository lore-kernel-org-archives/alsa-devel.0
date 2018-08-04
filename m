From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 11/12] ASoC: da9055: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:55:28 -0500
Message-ID: <f12e76b64d4f5a3d10ae949b3a050be62c107bd9.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/da9055.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index afdf90c..f6a7bf9 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1041,9 +1041,9 @@ static bool da9055_volatile_register(struct device *dev,
 	case DA9055_HP_R_GAIN_STATUS:
 	case DA9055_LINE_GAIN_STATUS:
 	case DA9055_ALC_CIC_OP_LVL_DATA:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
