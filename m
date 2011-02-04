From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH] ASoC: ep93xx-ac97: remove extra empty line
Date: Fri,  4 Feb 2011 12:22:55 +0200
Message-ID: <1296814975-15121-1-git-send-email-mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 451EC103AF6
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 11:25:17 +0100 (CET)
Received: by bwz10 with SMTP id 10so2532944bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Feb 2011 02:25:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/ep93xx/ep93xx-ac97.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-ac97.c b/sound/soc/ep93xx/ep93xx-ac97.c
index 68a0bae..104e95c 100644
--- a/sound/soc/ep93xx/ep93xx-ac97.c
+++ b/sound/soc/ep93xx/ep93xx-ac97.c
@@ -253,7 +253,6 @@ static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
 	struct ep93xx_ac97_info *info = snd_soc_dai_get_drvdata(dai);
 	unsigned v = 0;
 
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-- 
1.7.2.3
