From: linux@audioscience.com
Subject: [PATCH 04/21] Volumes and meters may have 1 or 2
	channels.
Date: Thu, 22 Dec 2011 13:38:34 +1300
Message-ID: <1324514331-22570-5-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 315E1103BFB
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:03 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:23 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

The channel count can be queried to determine which.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index a97a252..cf5baa2 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1410,6 +1410,7 @@ static int snd_asihpi_volume_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
 	u32 h_control = kcontrol->private_value;
+	u32 count;
 	u16 err;
 	/* native gains are in millibels */
 	short min_gain_mB;
@@ -1424,8 +1425,12 @@ static int snd_asihpi_volume_info(struct snd_kcontrol *kcontrol,
 		step_gain_mB = VOL_STEP_mB;
 	}
 
+	err = hpi_meter_query_channels(h_control, &count);
+	if (err)
+		count = HPI_MAX_CHANNELS;
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 2;
+	uinfo->count = count;
 	uinfo->value.integer.min = min_gain_mB / VOL_STEP_mB;
 	uinfo->value.integer.max = max_gain_mB / VOL_STEP_mB;
 	uinfo->value.integer.step = step_gain_mB / VOL_STEP_mB;
@@ -2033,8 +2038,15 @@ static int __devinit snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
 static int snd_asihpi_meter_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
+	u32 h_control = kcontrol->private_value;
+	u32 count;
+	u16 err;
+	err = hpi_meter_query_channels(h_control, &count);
+	if (err)
+		count = HPI_MAX_CHANNELS;
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = HPI_MAX_CHANNELS;
+	uinfo->count = count;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = 0x7FFFFFFF;
 	return 0;
-- 
1.7.0.4
