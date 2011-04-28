From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 1/1] ALSA: VIA HDA: Fix notify_aa_path_ctls()
	invalid issue.
Date: Thu, 28 Apr 2011 16:03:39 +0800
Message-ID: <4DB91F5B.50306@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E2A61038FE
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 10:03:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, haraldwelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Fix notify_aa_path_ctls() invalid issue.

In notify_aa_path_ctls(), adds 'rear mic' item and confirms the A-A path control 
existing before notifying card that the A-A path volume is muted if smart5.1 is 
enabled.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2011-04-28 14:26:11.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2011-04-28 14:44:14.000000000 +0800
@@ -844,14 +844,18 @@
 {
 	int i;
 	struct snd_ctl_elem_id id;
-	const char *labels[] = {"Mic", "Front Mic", "Line"};
+	const char *labels[] = {"Mic", "Front Mic", "Line", "Rear Mic"};
+	struct snd_kcontrol *ctl;
 
 	memset(&id, 0, sizeof(id));
 	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	for (i = 0; i < ARRAY_SIZE(labels); i++) {
 		sprintf(id.name, "%s Playback Volume", labels[i]);
-		snd_ctl_notify(codec->bus->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &id);
+		ctl = snd_hda_find_mixer_ctl(codec, id.name);
+		if (ctl)
+			snd_ctl_notify(codec->bus->card,
+					SNDRV_CTL_EVENT_MASK_VALUE,
+					&ctl->id);
 	}
 }
 
