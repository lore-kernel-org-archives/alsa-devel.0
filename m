From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: fix NULL pointer dereference in
	soc_suspend()
Date: Wed,  3 Jun 2009 17:44:49 +0200
Message-ID: <1244043889-3024-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B9031038BA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 17:45:10 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In case the initalization of an soc_device failed, there is no codec
associated with it. soc_suspend() will still dereference the pointer
and cause an Ooops when entering the sleep mode.

This happens on our board with a multi-target kernel image when booted
on a machine without audio circuits.

This patch makes the code bail out very early in this special case.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1cd149b..4545a15 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -632,6 +632,12 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	struct snd_soc_codec *codec = card->codec;
 	int i;
 
+	/* If the initialization of this soc device failed, there is no codec
+	 * associated with it. Just bail out in this case.
+	 */
+	if (!codec)
+		return 0;
+
 	/* Due to the resume being scheduled into a workqueue we could
 	* suspend before that's finished - wait for it to complete.
 	 */
-- 
1.6.3.1
