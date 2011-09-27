From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: ssm2602: Set initial bias level to
	standby
Date: Tue, 27 Sep 2011 11:08:47 +0200
Message-ID: <1317114528-16736-2-git-send-email-lars@metafoo.de>
References: <1317114528-16736-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-133.synserver.de (smtp-out-134.synserver.de
	[212.40.185.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 60A8910392D
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 11:09:27 +0200 (CEST)
In-Reply-To: <1317114528-16736-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Set the initial bias level to standby during CODEC probe instead of leaving the
CODEC powered off.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 32d6c51..c9e0fdb 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -577,7 +577,12 @@ static int ssm260x_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	ssm2602_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
 }
 
 /* remove everything here */
-- 
1.7.2.5
