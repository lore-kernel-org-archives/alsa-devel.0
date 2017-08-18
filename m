From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/14] ASoC: fsl: constify snd_soc_dai_ops
	structures
Date: Fri, 18 Aug 2017 17:36:01 +0530
Message-ID: <1503057971-16033-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F1F82677B9
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 14:06:35 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 83so14808675pgb.4
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 05:06:35 -0700 (PDT)
In-Reply-To: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c  | 2 +-
 sound/soc/fsl/fsl_esai.c  | 2 +-
 sound/soc/fsl/fsl_spdif.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 8cfffa7..806d399 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -542,7 +542,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_asrc_dai_ops = {
+static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
 	.hw_params    = fsl_asrc_dai_hw_params,
 	.hw_free      = fsl_asrc_dai_hw_free,
 	.trigger      = fsl_asrc_dai_trigger,
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 809a069..cef79a1 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -620,7 +620,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_esai_dai_ops = {
+static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
 	.startup = fsl_esai_startup,
 	.shutdown = fsl_esai_shutdown,
 	.trigger = fsl_esai_trigger,
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 1ff467c..7e6cc4d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -626,7 +626,7 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_spdif_dai_ops = {
+static const struct snd_soc_dai_ops fsl_spdif_dai_ops = {
 	.startup = fsl_spdif_startup,
 	.hw_params = fsl_spdif_hw_params,
 	.trigger = fsl_spdif_trigger,
-- 
1.9.1
