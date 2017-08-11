From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: Intel: kbl: make
	snd_pcm_hw_constraint_list const
Date: Fri, 11 Aug 2017 21:26:49 +0530
Message-ID: <1502467009-27186-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 64A6926768D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 17:57:06 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id c65so3822167pfl.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 08:57:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only passed to the function
snd_pcm_hw_constraint_list having the corresponding argument as const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 12b34b9..8bdd613 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -286,7 +286,7 @@ static int kabylake_5663_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_rates = {
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list  = rates,
 	.mask = 0,
@@ -296,7 +296,7 @@ static int kabylake_5663_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
 	2,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_channels = {
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
@@ -425,7 +425,7 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 	16000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_16000 = {
+static const struct snd_pcm_hw_constraint_list constraints_16000 = {
 	.count = ARRAY_SIZE(rates_16000),
 	.list  = rates_16000,
 };
-- 
1.9.1
