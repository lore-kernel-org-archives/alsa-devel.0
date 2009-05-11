From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] ASoC: soc-core: fix crash when removing not
	instantiated card
Date: Mon, 11 May 2009 13:04:55 +0300
Message-ID: <1242036295-29085-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cathcart.site5.com (cathcart.site5.com [74.54.107.137])
	by alsa0.perex.cz (Postfix) with ESMTP id E3F9F24751
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 12:05:02 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mike Rapoport <mike@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

If the card was not instantiated in snd_soc_instantiate_card, calling
soc-remove will crash because some of codec, cpu_dai and card .remove
methods are called twice.
Fix this by returning from soc_remove immediately.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 sound/soc/soc-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 99712f6..1cd149b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -954,6 +954,9 @@ static int soc_remove(struct platform_device *pdev)
 	struct snd_soc_platform *platform = card->platform;
 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 
+	if (!card->instantiated)
+		return 0;
+
 	run_delayed_work(&card->delayed_work);
 
 	if (platform->remove)
-- 
1.5.6.4
