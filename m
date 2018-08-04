From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 02/12] ASoC: rt5631: use true and false for boolean values
Date: Sat, 4 Aug 2018 16:49:55 -0500
Message-ID: <76b053970c83ca02ef016b39108754b4bf83527a.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/rt5631.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index e52e467..865f49a 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -105,9 +105,9 @@ static bool rt5631_volatile_register(struct device *dev, unsigned int reg)
 	case RT5631_INDEX_ADD:
 	case RT5631_INDEX_DATA:
 	case RT5631_EQ_CTRL:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -164,9 +164,9 @@ static bool rt5631_readable_register(struct device *dev, unsigned int reg)
 	case RT5631_VENDOR_ID:
 	case RT5631_VENDOR_ID1:
 	case RT5631_VENDOR_ID2:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
