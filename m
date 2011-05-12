From: jinyoungp@nvidia.com
Subject: [PATCH 3/3] ASoC: codecs: max98088: Added digital mute
	function in DAI1 and DAI2
Date: Thu, 12 May 2011 14:58:38 +0900
Message-ID: <1305179918-19317-4-git-send-email-jinyoungp@nvidia.com>
References: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 48A282446F
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 07:59:14 +0200 (CEST)
In-Reply-To: <1305179918-19317-1-git-send-email-jinyoungp@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, Jin Park <jinyoungp@nvidia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jin Park <jinyoungp@nvidia.com>

Added digital mute function in DAI1 and DAI2.

Signed-off-by: Jin Park <jinyoungp@nvidia.com>
---
 sound/soc/codecs/max98088.c |   32 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98088.h |   13 +++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index c520093..b5ccf37 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1582,6 +1582,36 @@ static int max98088_dai2_set_fmt(struct snd_soc_dai *codec_dai,
        return 0;
 }
 
+static int max98088_dai1_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+       int reg;
+
+       if (mute)
+               reg = M98088_DAI_MUTE;
+       else
+               reg = 0;
+
+       snd_soc_update_bits(codec, M98088_REG_2F_LVL_DAI1_PLAY,
+                           M98088_DAI_MUTE_MASK, reg);
+       return 0;
+}
+
+static int max98088_dai2_digital_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+       int reg;
+
+       if (mute)
+               reg = M98088_DAI_MUTE;
+       else
+               reg = 0;
+
+       snd_soc_update_bits(codec, M98088_REG_31_LVL_DAI2_PLAY,
+                           M98088_DAI_MUTE_MASK, reg);
+       return 0;
+}
+
 static void max98088_sync_cache(struct snd_soc_codec *codec)
 {
        u16 *reg_cache = codec->reg_cache;
@@ -1643,12 +1673,14 @@ static struct snd_soc_dai_ops max98088_dai1_ops = {
        .set_sysclk = max98088_dai_set_sysclk,
        .set_fmt = max98088_dai1_set_fmt,
        .hw_params = max98088_dai1_hw_params,
+       .digital_mute = max98088_dai1_digital_mute,
 };
 
 static struct snd_soc_dai_ops max98088_dai2_ops = {
        .set_sysclk = max98088_dai_set_sysclk,
        .set_fmt = max98088_dai2_set_fmt,
        .hw_params = max98088_dai2_hw_params,
+       .digital_mute = max98088_dai2_digital_mute,
 };
 
 static struct snd_soc_dai_driver max98088_dai[] = {
diff --git a/sound/soc/codecs/max98088.h b/sound/soc/codecs/max98088.h
index 56554c7..be89a4f 100644
--- a/sound/soc/codecs/max98088.h
+++ b/sound/soc/codecs/max98088.h
@@ -133,6 +133,19 @@
        #define M98088_REC_LINEMODE             (1<<7)
        #define M98088_REC_LINEMODE_MASK        (1<<7)
 
+/* M98088_REG_2D_MIX_SPK_CNTL */
+       #define M98088_MIX_SPKR_GAIN_MASK       (3<<2)
+       #define M98088_MIX_SPKR_GAIN_SHIFT      2
+       #define M98088_MIX_SPKL_GAIN_MASK       (3<<0)
+       #define M98088_MIX_SPKL_GAIN_SHIFT      0
+
+/* M98088_REG_2F_LVL_DAI1_PLAY, M98088_REG_31_LVL_DAI2_PLAY */
+       #define M98088_DAI_MUTE                 (1<<7)
+       #define M98088_DAI_MUTE_MASK            (1<<7)
+       #define M98088_DAI_VOICE_GAIN_MASK      (3<<4)
+       #define M98088_DAI_ATTENUATION_MASK     (0xF<<0)
+       #define M98088_DAI_ATTENUATION_SHIFT    0
+
 /* M98088_REG_35_LVL_MIC1, M98088_REG_36_LVL_MIC2 */
        #define M98088_MICPRE_MASK              (3<<5)
        #define M98088_MICPRE_SHIFT             5
-- 
1.7.1


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
