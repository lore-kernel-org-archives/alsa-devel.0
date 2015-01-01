From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: byt-rt5640: Fix
	snd_soc_dapm_ignore_suspend() calls
Date: Thu,  1 Jan 2015 11:23:44 +0100
Message-ID: <1420107825-28506-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 6799326049D
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 11:23:48 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

To work properly snd_soc_dapm_ignore_suspend() needs to be called on
endpoint widgets. In this case those are the board level Speaker and
Headphone widgets and not the CODEC output widgets that are connected to
them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/byt-rt5640.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index 0cba783..a51856e 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -171,13 +171,8 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 			return ret;
 	}
 
-	snd_soc_dapm_ignore_suspend(dapm, "HPOL");
-	snd_soc_dapm_ignore_suspend(dapm, "HPOR");
-
-	snd_soc_dapm_ignore_suspend(dapm, "SPOLP");
-	snd_soc_dapm_ignore_suspend(dapm, "SPOLN");
-	snd_soc_dapm_ignore_suspend(dapm, "SPORP");
-	snd_soc_dapm_ignore_suspend(dapm, "SPORN");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
 	return ret;
 }
-- 
1.8.0
