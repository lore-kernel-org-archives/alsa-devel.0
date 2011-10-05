From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/10] ASoC: twl6040: Prepare for core
	put_volsw/volsw_2r merger
Date: Wed,  5 Oct 2011 10:29:21 +0300
Message-ID: <1317799768-15683-4-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 690DC1039FF
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:47 +0200 (CEST)
Received: by bkbzt4 with SMTP id zt4so2337233bkb.33
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:45 -0700 (PDT)
In-Reply-To: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Avoid using the mc->rreg to identify the 2r type of gain control.
Introduce a variable to track this.
This change is needed to avoid breakage with the upcoming volsw volsw_2r
merger.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4ad04e3..c9a601d 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -746,7 +746,7 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	struct twl6040_output *out = NULL;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int ret;
+	int ret, type_2r;
 
 	/* For HS and HF we shadow the values and only actually write
 	 * them out when active in order to ensure the amplifier comes on
@@ -754,9 +754,11 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	switch (mc->reg) {
 	case TWL6040_REG_HSGAIN:
 		out = &twl6040_priv->headset;
+		type_2r = 0;
 		break;
 	case TWL6040_REG_HFLGAIN:
 		out = &twl6040_priv->handsfree;
+		type_2r = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -768,7 +770,7 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 		return 1;
 
 	/* call the appropriate handler depending on the rreg */
-	if (mc->rreg)
+	if (type_2r)
 		ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
 	else
 		ret = snd_soc_put_volsw(kcontrol, ucontrol);
-- 
1.7.7
