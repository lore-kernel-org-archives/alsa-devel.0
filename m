From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/1] ASoC: Fix typo in snd_soc_card update
	documentation
Date: Fri, 21 Nov 2008 15:08:23 +0000
Message-ID: <1227280103-25997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EA5924542
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 16:08:24 +0100 (CET)
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
 Documentation/sound/alsa/soc/machine.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index 4a9f51e..bab7711 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -9,7 +9,7 @@ the audio subsystem with the kernel as a platform device and is represented by
 the following struct:-
 
 /* SoC machine */
-struct snd_soc_card {_
+struct snd_soc_card {
 	char *name;
 
 	int (*probe)(struct platform_device *pdev);
-- 
1.5.6.5
