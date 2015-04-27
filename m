From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: Add helper function getting CODEC's
	DAPM context
Date: Mon, 27 Apr 2015 22:13:22 +0200
Message-ID: <1430165606-3072-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-223.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 497F02612D2
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:13:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DAPM context in the snd_soc_codec struct is redundant and scheduled to
be replaced by the DAPM context in the snd_soc_component struct. This patch
introduces a new helper function snd_soc_codec_get_dapm() which should be
used for getting the DAPM context for a CODEC rather then directly
accessing the dapm field. Once there are no more direct users of the dapm
field left it is possible to transparently switch all drivers to the
component DAPM context by updating snd_soc_codec_get_dapm() function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f6226914..d57dc7c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -819,7 +819,7 @@ struct snd_soc_codec {
 	/* component */
 	struct snd_soc_component component;
 
-	/* dapm */
+	/* Don't access this directly, use snd_soc_codec_get_dapm() */
 	struct snd_soc_dapm_context dapm;
 
 #ifdef CONFIG_DEBUG_FS
@@ -1282,6 +1282,18 @@ static inline struct snd_soc_dapm_context *snd_soc_component_get_dapm(
 }
 
 /**
+ * snd_soc_codec_get_dapm() - Returns the DAPM context for the CODEC
+ * @codec: The CODEC for which to get the DAPM context
+ *
+ * Note: Use this function instead of directly accessing the CODEC's dapm field
+ */
+static inline struct snd_soc_dapm_context *snd_soc_codec_get_dapm(
+	struct snd_soc_codec *codec)
+{
+	return &codec->dapm;
+}
+
+/**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
  *
-- 
1.8.0
