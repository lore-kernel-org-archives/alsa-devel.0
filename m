From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: Remove unused snd_soc_machine_config
	declaration
Date: Wed, 19 Nov 2008 13:36:28 +0000
Message-ID: <1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081119133427.GA3687@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B44AD2461C
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:36:34 +0100 (CET)
In-Reply-To: <20081119133427.GA3687@rakim.wolfsonmicro.main>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fa1b99b..077dfe4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -228,7 +228,6 @@ struct snd_soc_dai_mode;
 struct snd_soc_pcm_runtime;
 struct snd_soc_dai;
 struct snd_soc_codec;
-struct snd_soc_machine_config;
 struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_clock_info;
-- 
1.5.6.5
