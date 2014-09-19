From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/5] ASoC: max98090: Remove structure member
	extmic_mux from private data
Date: Fri, 19 Sep 2014 14:48:19 +0300
Message-ID: <1411127301-366-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CA909261AC3
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:48:38 +0200 (CEST)
In-Reply-To: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is no other use for extmic_mux than setting it to zero so remove it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 1 -
 sound/soc/codecs/max98090.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 3e27de1f473b..f2a3f30a5d9f 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2333,7 +2333,6 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	max98090->lin_state = 0;
 	max98090->pa1en = 0;
 	max98090->pa2en = 0;
-	max98090->extmic_mux = 0;
 
 	ret = snd_soc_read(codec, M98090_REG_REVISION_ID);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index a16319512182..84ca3f4f4403 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1541,7 +1541,6 @@ struct max98090_priv {
 	u8 lin_state;
 	unsigned int pa1en;
 	unsigned int pa2en;
-	unsigned int extmic_mux;
 	unsigned int sidetone;
 	bool master;
 };
-- 
2.1.0
