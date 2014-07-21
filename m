From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] bebob: Add dev_err() for debugging
Date: Mon, 21 Jul 2014 11:10:02 +0900
Message-ID: <1405908605-8105-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B62612650DB
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 04:10:16 +0200 (CEST)
In-Reply-To: <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds some dev_err() to help debug when
avc_maudio_set_special_clk() failed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 83f8d5b..008ff2c 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -393,6 +393,10 @@ static int special_clk_ctl_set(struct snd_kcontrol *kctl,
 
 	mutex_unlock(&bebob->mutex);
 
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"fail to change clock source: %d\n", err);
+
 	return err >= 0;
 }
 static struct snd_kcontrol_new special_clk_ctl = {
@@ -506,7 +510,14 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 					 dig_in_fmt,
 					 params->dig_out_fmt,
 					 params->clk_lock);
-	if ((err < 0) || (params->dig_in_fmt > 0)) /* ADAT */
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"fail to change clock source: %d\n", err);
+		goto end;
+	}
+
+	/* For ADAT, optical interface is only available. */
+	if (params->dig_in_fmt > 0)
 		goto end;
 
 	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
@@ -567,10 +578,13 @@ static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
 					 params->clk_src,
 					 params->dig_in_fmt,
 					 id, params->clk_lock);
-	if (err >= 0)
-		special_stream_formation_set(bebob);
 
 	mutex_unlock(&bebob->mutex);
+
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"fail to change digital output interface: %d\n", err);
+
 	return err;
 }
 static struct snd_kcontrol_new special_dig_out_iface_ctl = {
-- 
1.9.1
