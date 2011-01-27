From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: Fix typo in snd_soc_dapm_put_volsw
Date: Thu, 27 Jan 2011 14:54:05 -0700
Message-ID: <1296165245-10828-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B41F10380A
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 22:54:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

This fixes a regression introduced by:
97404f2e0386ac147cec00fc5d89ea475b04bd78
ASoC: Do DAPM control updates in the middle of DAPM sequences

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-dapm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0f94fd0..d0342aa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1779,7 +1779,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	unsigned int val, val_mask;
+	unsigned int val;
 	int connect, change;
 	struct snd_soc_dapm_update update;
 
@@ -1787,13 +1787,13 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	if (invert)
 		val = max - val;
-	val_mask = mask << shift;
+	mask = mask << shift;
 	val = val << shift;
 
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 
-	change = snd_soc_test_bits(widget->codec, reg, val_mask, val);
+	change = snd_soc_test_bits(widget->codec, reg, mask, val);
 	if (change) {
 		if (val)
 			/* new connection */
-- 
1.7.1
