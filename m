From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/6] ASoC: Intel: byt-max98090: Do not report
	SND_JACK_LINEIN
Date: Mon, 23 Jun 2014 16:29:39 +0300
Message-ID: <1403530182-5400-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AC48F2610A0
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 15:29:58 +0200 (CEST)
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

Headset jack has only mono microphone input.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/byt-max98090.c
index 3d06440278ec..165ab6d6c4a3 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/byt-max98090.c
@@ -84,7 +84,7 @@ static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 		.name		= "mic-gpio",
 		.idx		= 1,
 		.invert		= 1,
-		.report		= SND_JACK_MICROPHONE | SND_JACK_LINEIN,
+		.report		= SND_JACK_MICROPHONE,
 		.debounce_time	= 200,
 	},
 };
-- 
2.0.0
