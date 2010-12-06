From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 1/2] ASoC: omap: Add hardware constraint for
	HDMI and ABE
Date: Mon, 6 Dec 2010 16:34:44 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8210E1037FF
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:34:49 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

The Audio Backend needs a step size of 24 * 4, while HDMI requires a
step size of 32 * 4 bits to align the audio buffer.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/omap/omap-pcm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 8caeb8d..6a21447 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -280,6 +280,15 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto out;
 
+	/*
+	 * ABE needs a step of 24 * 4 data bits, and HDMI 32 * 4
+	 * Ensure buffer size satisfies both constraints.
+	 */
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 384);
+	if (ret < 0)
+		goto out;
+
 	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
 	if (prtd == NULL) {
 		ret = -ENOMEM;
-- 
1.7.0.4
