From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] soc-core: let suspend/resume not called if the
	card is not instantiated
Date: Fri, 13 Nov 2009 12:51:18 +0800
Message-ID: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 450C62452A
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 05:51:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

It doesn't make sense to call suspend/resume of all cpu/codec dais even
they are not initialized and registered. This will cause many problems
foraudio PM.
The condition card is not instantiated covers codec is null, so delete
the check that codec is null.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/soc-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e2b6d75..097f3b9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -796,10 +796,7 @@ static int soc_suspend(struct device *dev)
 	struct snd_soc_codec *codec = card->codec;
 	int i;
 
-	/* If the initialization of this soc device failed, there is no codec
-	 * associated with it. Just bail out in this case.
-	 */
-	if (!codec)
+	if (!card->instantiated)
 		return 0;
 
 	/* Due to the resume being scheduled into a workqueue we could
@@ -940,6 +937,9 @@ static int soc_resume(struct device *dev)
 	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_dai *cpu_dai = card->dai_link[0].cpu_dai;
 
+	if (!card->instantiated)
+		return 0;
+
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
-- 
1.5.6.3
