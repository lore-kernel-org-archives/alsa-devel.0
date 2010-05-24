From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: fix uninitialised variable in siu_dai.c
Date: Mon, 24 May 2010 10:55:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005241051190.2611@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 9E0C12457A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 10:55:06 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Strangely, the compiler doesn't warn about this one, but I really don't 
see how this can be correct. Am I being blind?

 sound/soc/sh/siu_dai.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index d86ee1b..eeed5ed 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -588,6 +588,8 @@ static int siu_dai_prepare(struct snd_pcm_substream *substream,
 		ret = siu_dai_spbstart(port_info);
 		if (ret < 0)
 			goto fail;
+	} else {
+		ret = 0;
 	}
 
 	port_info->play_cap |= self;
-- 
1.6.2.4
