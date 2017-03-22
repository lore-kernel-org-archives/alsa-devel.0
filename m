From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: blackfin: constify snd_soc_ops structures
Date: Wed, 22 Mar 2017 18:21:35 +0530
Message-ID: <1490187095-12846-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E365B2673BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:51:50 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id 81so22408965pgh.3
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 05:51:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

Cross compiled the .o files for blackfin architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/blackfin/bfin-eval-adau1373.c | 2 +-
 sound/soc/blackfin/bfin-eval-adav80x.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index 72ac789..64b88fd 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -119,7 +119,7 @@ static int bfin_eval_adau1373_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	return ret;
 }
-static struct snd_soc_ops bfin_eval_adau1373_ops = {
+static const struct snd_soc_ops bfin_eval_adau1373_ops = {
 	.hw_params = bfin_eval_adau1373_hw_params,
 };
 
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 1037477..99e5eca 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -64,7 +64,7 @@ static int bfin_eval_adav80x_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_ops bfin_eval_adav80x_ops = {
+static const struct snd_soc_ops bfin_eval_adav80x_ops = {
 	.hw_params = bfin_eval_adav80x_hw_params,
 };
 
-- 
2.7.4
