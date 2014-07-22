From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] bebob: Use different labels for digital
	input/output
Date: Tue, 22 Jul 2014 23:13:47 +0900
Message-ID: <1406038427-18653-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1406038263-18558-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1166126551B
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 16:13:55 +0200 (CEST)
In-Reply-To: <1406038263-18558-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, darrena092@gmail.com
List-Id: alsa-devel@alsa-project.org

This commit uses different labels for control elements of digital input/output
interfaces to correct my misunderstanding about M-Audio Firewire 1814 and
ProjectMix I/O.

According to user manuals for these two models, they have two modes for
digital input; one is S/PDIF in both of optical and coaxial interfaces,
another is ADAT in optical interface only.

But in current implementation, a control element for it reduced labels which
a control element for digital output uses because of my misunderstanding
that optical interface is not available for digital input with S/PDIF mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index fc470c6..42e6f22 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -434,8 +434,8 @@ static struct snd_kcontrol_new special_sync_ctl = {
 	.get	= special_sync_ctl_get,
 };
 
-/* Digital interface control for special firmware */
-static char *const special_dig_iface_labels[] = {
+/* Digital input interface control for special firmware */
+static char *const special_dig_in_iface_labels[] = {
 	"S/PDIF Optical", "S/PDIF Coaxial", "ADAT Optical"
 };
 static int special_dig_in_iface_ctl_info(struct snd_kcontrol *kctl,
@@ -443,13 +443,13 @@ static int special_dig_in_iface_ctl_info(struct snd_kcontrol *kctl,
 {
 	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	einf->count = 1;
-	einf->value.enumerated.items = ARRAY_SIZE(special_dig_iface_labels);
+	einf->value.enumerated.items = ARRAY_SIZE(special_dig_in_iface_labels);
 
 	if (einf->value.enumerated.item >= einf->value.enumerated.items)
 		einf->value.enumerated.item = einf->value.enumerated.items - 1;
 
 	strcpy(einf->value.enumerated.name,
-	       special_dig_iface_labels[einf->value.enumerated.item]);
+	       special_dig_in_iface_labels[einf->value.enumerated.item]);
 
 	return 0;
 }
@@ -504,9 +504,14 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 					 dig_in_fmt,
 					 params->dig_out_fmt,
 					 params->clk_lock);
-	if ((err < 0) || (params->dig_in_fmt > 0)) /* ADAT */
+	if (err < 0)
+		goto end;
+
+	/* For ADAT, optical interface is only available. */
+	if (params->dig_in_fmt > 0)
 		goto end;
 
+	/* For S/PDIF, optical/coaxial interfaces are selectable. */
 	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
 	if (err < 0)
 		dev_err(&bebob->unit->device,
@@ -525,18 +530,22 @@ static struct snd_kcontrol_new special_dig_in_iface_ctl = {
 	.put	= special_dig_in_iface_ctl_set
 };
 
+/* Digital output interface control for special firmware */
+static char *const special_dig_out_iface_labels[] = {
+	"S/PDIF Optical and Coaxial", "ADAT Optical"
+};
 static int special_dig_out_iface_ctl_info(struct snd_kcontrol *kctl,
 					  struct snd_ctl_elem_info *einf)
 {
 	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	einf->count = 1;
-	einf->value.enumerated.items = ARRAY_SIZE(special_dig_iface_labels) - 1;
+	einf->value.enumerated.items = ARRAY_SIZE(special_dig_out_iface_labels);
 
 	if (einf->value.enumerated.item >= einf->value.enumerated.items)
 		einf->value.enumerated.item = einf->value.enumerated.items - 1;
 
 	strcpy(einf->value.enumerated.name,
-	       special_dig_iface_labels[einf->value.enumerated.item + 1]);
+	       special_dig_out_iface_labels[einf->value.enumerated.item]);
 
 	return 0;
 }
-- 
1.9.1
