From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ALSA: Add support for wildcard msbits
	constraints
Date: Mon, 29 Dec 2014 18:43:37 +0100
Message-ID: <1419875018-30812-2-git-send-email-lars@metafoo.de>
References: <1419875018-30812-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC91261585
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 18:43:43 +0100 (CET)
In-Reply-To: <1419875018-30812-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently the msbits constraints requires to specify a specific sample
format width for which the constraint should be applied. But often the
number of most significant bits is not sample format specific, but rather a
absolute limit. E.g. the PCM interface might accept 32-bit and 24-bit
samples, but the DAC has a 16-bit resolution and throws away the LSBs. In
this case for both 32-bit and 24-bit format msbits should be set to 16. This
patch extends snd_pcm_hw_constraint_msbits() so that a wildcard constraint
can be setup that is applied for all formats with a sample width larger than
the specified msbits. Choosing the wildcard constraint is done by setting
the sample width parameter of the function to 0.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/core/pcm_lib.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index b0c1535..db05e04 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1299,8 +1299,14 @@ static int snd_pcm_hw_rule_msbits(struct snd_pcm_hw_params *params,
 	int width = l & 0xffff;
 	unsigned int msbits = l >> 16;
 	struct snd_interval *i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
-	if (snd_interval_single(i) && snd_interval_value(i) == width)
+
+	if (!snd_interval_single(i))
+		return 0;
+
+	if ((snd_interval_value(i) == width) ||
+	    (width == 0 && snd_interval_value(i) > msbits))
 		params->msbits = min_not_zero(params->msbits, msbits);
+
 	return 0;
 }
 
@@ -1311,6 +1317,11 @@ static int snd_pcm_hw_rule_msbits(struct snd_pcm_hw_params *params,
  * @width: sample bits width
  * @msbits: msbits width
  *
+ * This constraint will set the number of most significant bits (msbits) if a
+ * sample format with the specified width has been select. If width is set to 0
+ * the msbits will be set for any sample format with a width larger than the
+ * specified msbits.
+ *
  * Return: Zero if successful, or a negative error code on failure.
  */
 int snd_pcm_hw_constraint_msbits(struct snd_pcm_runtime *runtime, 
-- 
1.8.0
