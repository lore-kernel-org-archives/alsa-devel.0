From: pascal.huerst@gmail.com
Subject: [PATCH] ASoC: cs4271: Increase delay time after reset
Date: Thu,  2 Apr 2015 10:17:40 +0200
Message-ID: <1427962660-23517-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, broonie@kernel.org, Pascal Huerst <pascal.huerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

The delay time after a reset in the codec probe callback was too short,
and did not work on certain hw because the codec needs more time to
power on. This increases the delay time from 1us to 1ms.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 sound/soc/codecs/cs4271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 7d3a6ac..e770ee6 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -561,10 +561,10 @@ static int cs4271_codec_probe(struct snd_soc_codec *codec)
 	if (gpio_is_valid(cs4271->gpio_nreset)) {
 		/* Reset codec */
 		gpio_direction_output(cs4271->gpio_nreset, 0);
-		udelay(1);
+		mdelay(1);
 		gpio_set_value(cs4271->gpio_nreset, 1);
 		/* Give the codec time to wake up */
-		udelay(1);
+		mdelay(1);
 	}
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
-- 
1.9.3
