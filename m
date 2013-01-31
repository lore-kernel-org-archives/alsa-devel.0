From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Subject: [PATCH v3 2/4] ASoC: davinci: update machine driver dapm routes
Date: Thu, 31 Jan 2013 16:53:11 +0530
Message-ID: <1359631394-9511-3-git-send-email-gururaja.hebbar@ti.com>
References: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, lgirdwood@gmail.com, perex@perex.cz, nsekhar@ti.com, gururaja.hebbar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, rob@landley.net, grant.likely@secretlab.ca
List-Id: alsa-devel@alsa-project.org

Now since micbias is converted to supply widget, updated machine driver
as well.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
---
Changes in v3
	 - New patch

:100644 100644 d55e647... 484b22c... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index d55e647..484b22c 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -116,9 +116,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Line Out", NULL, "RLOUT"},
 
 	/* Mic connected to (MIC3L | MIC3R) */
-	{"MIC3L", NULL, "Mic Bias 2V"},
-	{"MIC3R", NULL, "Mic Bias 2V"},
-	{"Mic Bias 2V", NULL, "Mic Jack"},
+	{"MIC3L", NULL, "Mic Bias"},
+	{"MIC3R", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Mic Jack"},
 
 	/* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
 	{"LINE1L", NULL, "Line In"},
-- 
1.7.9.5

