From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] ASoC: twl6040: Rename
	twl6040_is_path_unmuted -> twl6040_can_write_to_chip
Date: Fri, 29 Nov 2013 16:03:43 +0200
Message-ID: <1385733827-19831-2-git-send-email-peter.ujfalusi@ti.com>
References: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id EF13E261701
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 15:03:49 +0100 (CET)
In-Reply-To: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Matches more precisely of the functionality.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index f2f4bcb..ef13a50 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -219,8 +219,8 @@ static int twl6040_read_reg_volatile(struct snd_soc_codec *codec,
 	return value;
 }
 
-static bool twl6040_is_path_unmuted(struct snd_soc_codec *codec,
-				    unsigned int reg)
+static bool twl6040_can_write_to_chip(struct snd_soc_codec *codec,
+				  unsigned int reg)
 {
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
@@ -250,7 +250,7 @@ static int twl6040_write(struct snd_soc_codec *codec,
 		return -EIO;
 
 	twl6040_write_reg_cache(codec, reg, value);
-	if (twl6040_is_path_unmuted(codec, reg))
+	if (twl6040_can_write_to_chip(codec, reg))
 		return twl6040_reg_write(twl6040, reg, value);
 	else
 		return 0;
-- 
1.8.4.2
