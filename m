From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/17] Ensure PCMs are suspended
Date: Thu, 10 Jan 2008 13:17:04 +0000
Message-ID: <1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id AC0B72457F
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:18 +0100 (CET)
In-Reply-To: <1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <lg@opensource.wolfsonmicro.com>

This fixes a bug whereby PCMs were not being suspended when the rest of the
audio subsystem was suspended.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    3 +++
 sound/soc/soc-core.c |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c69b58c..e32fa2f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -448,6 +448,9 @@ struct snd_soc_dai_link  {
 
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_codec *codec);
+
+	/* DAI pcm */
+	struct snd_pcm *pcm;
 };
 
 /* SoC machine */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b159734..680dea9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -646,6 +646,10 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 			dai->dai_ops.digital_mute(dai, 1);
 	}
 
+	/* suspend all pcms */
+	for (i = 0; i < machine->num_links; i++)
+		snd_pcm_suspend_all(machine->dai_link[i].pcm);
+
 	if (machine->suspend_pre)
 		machine->suspend_pre(pdev, state);
 
@@ -880,6 +884,7 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 		return ret;
 	}
 
+	dai_link->pcm = pcm;
 	pcm->private_data = rtd;
 	soc_pcm_ops.mmap = socdev->platform->pcm_ops->mmap;
 	soc_pcm_ops.pointer = socdev->platform->pcm_ops->pointer;
-- 
1.5.3.8
