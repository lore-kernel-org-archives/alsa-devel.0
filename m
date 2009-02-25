From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: Fix Zylonite voice interface stereo
	configurations
Date: Wed, 25 Feb 2009 10:48:19 +0000
Message-ID: <1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32A692443F
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 11:48:24 +0100 (CET)
In-Reply-To: <20090225104701.GA20221@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We always run in the first timeslot of one.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/zylonite.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index ec2fb76..0140a25 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -127,9 +127,8 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai,
-				       params_channels(params),
-				       params_channels(params));
+	/* We're not really in network mode but the emulation wants this. */
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.1.3
