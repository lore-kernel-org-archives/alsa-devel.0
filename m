From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 04/12] ASoC: wm8990: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:51:01 -0500
Message-ID: <3d81e99b93dbe0d5b84083d3fdf6c86b44f210ef.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8990.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 411b9ee..457bc43 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -40,9 +40,9 @@ static bool wm8990_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8990_RESET:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
