From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 01/12] ASoC: max9850: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:49:02 -0500
Message-ID: <99d07804559a7dfd13658f76b2071aef32b92204.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/max9850.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 74d7f52..6e61345 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -52,9 +52,9 @@ static bool max9850_volatile_register(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case MAX9850_STATUSA:
 	case MAX9850_STATUSB:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
