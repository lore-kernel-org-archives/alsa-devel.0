From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 06/12] ASoC: twl6040: Prepare for core
	put_volsw/volsw_2r merger
Date: Tue,  4 Oct 2011 14:39:43 +0300
Message-ID: <1317728389-22062-7-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C59210390B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:12 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so747793bkb.18
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:10 -0700 (PDT)
In-Reply-To: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
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
index cc889e9..ff27eb4 100644
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
