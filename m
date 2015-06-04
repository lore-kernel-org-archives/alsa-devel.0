From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] ASoC: Intel: mrfld: simplify
	sst_fill_widget_module_info
Date: Thu,  4 Jun 2015 10:13:53 +0200
Message-ID: <1433405633-18656-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id D1DE42605C0
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 10:14:12 +0200 (CEST)
Received: by lbcmx3 with SMTP id mx3so22349095lbc.1
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 01:14:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some tiny improvements, cutting 180 bytes off the generated code.

- use strchr() for single-character needle

- compute index using pointer subtraction instead of two strlen()
  calls

- factor out the common check for whether the initial part of
  kctl->id.name (before the space) is identical to w->name.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 sound/soc/intel/atom/sst-atom-controls.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 90aa5c0476f3..16670feeee6a 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1280,36 +1280,32 @@ static int sst_fill_widget_module_info(struct snd_soc_dapm_widget *w,
 	down_read(&card->controls_rwsem);
 
 	list_for_each_entry(kctl, &card->controls, list) {
-		idx = strstr(kctl->id.name, " ");
+		idx = strchr(kctl->id.name, ' ');
 		if (idx == NULL)
 			continue;
-		index  = strlen(kctl->id.name) - strlen(idx);
+		index = idx - (char*)kctl->id.name;
+		if (strncmp(kctl->id.name, w->name, index))
+			continue;
 
-		if (strstr(kctl->id.name, "Volume") &&
-		    !strncmp(kctl->id.name, w->name, index))
+		if (strstr(kctl->id.name, "Volume"))
 			ret = sst_fill_module_list(kctl, w, SST_MODULE_GAIN);
 
-		else if (strstr(kctl->id.name, "params") &&
-			 !strncmp(kctl->id.name, w->name, index))
+		else if (strstr(kctl->id.name, "params"))
 			ret = sst_fill_module_list(kctl, w, SST_MODULE_ALGO);
 
 		else if (strstr(kctl->id.name, "Switch") &&
-			 !strncmp(kctl->id.name, w->name, index) &&
 			 strstr(kctl->id.name, "Gain")) {
 			struct sst_gain_mixer_control *mc =
 						(void *)kctl->private_value;
 
 			mc->w = w;
 
-		} else if (strstr(kctl->id.name, "interleaver") &&
-			 !strncmp(kctl->id.name, w->name, index)) {
+		} else if (strstr(kctl->id.name, "interleaver")) {
 			struct sst_enum *e = (void *)kctl->private_value;
 
 			e->w = w;
 
-		} else if (strstr(kctl->id.name, "deinterleaver") &&
-			 !strncmp(kctl->id.name, w->name, index)) {
-
+		} else if (strstr(kctl->id.name, "deinterleaver")) {
 			struct sst_enum *e = (void *)kctl->private_value;
 
 			e->w = w;
-- 
2.1.3
