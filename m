From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/6] ASoC: Intel: byt-max98090: Fix jack type
	in order to report correctly
Date: Mon, 23 Jun 2014 16:29:40 +0300
Message-ID: <1403530182-5400-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9200D26162E
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 15:30:02 +0200 (CEST)
In-Reply-To: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org

Pass actual jack type bitmask to snd_soc_jack_new() in order to report
also microphone detections and not only headphone. While at it change also
jack name and pass also SND_JACK_LINEOUT type.

Reported-by: Jin Yao <yao.jin@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-max98090.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/byt-max98090.c
index 165ab6d6c4a3..3e2e7152ae66 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/byt-max98090.c
@@ -108,7 +108,8 @@ static int byt_max98090_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	/* Enable jack detection */
-	ret = snd_soc_jack_new(codec, "Headphone", SND_JACK_HEADPHONE, jack);
+	ret = snd_soc_jack_new(codec, "Headset",
+			       SND_JACK_LINEOUT | SND_JACK_HEADSET, jack);
 	if (ret)
 		return ret;
 
-- 
2.0.0
