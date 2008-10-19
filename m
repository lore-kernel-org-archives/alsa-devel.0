From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: [PATCH] snd-sbxfi: implement Master volume control
Date: Sun, 19 Oct 2008 18:08:15 -0500
Message-ID: <20081019225808.8054977DF81@carpathia.dereferenced.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129]) by alsa0.perex.cz (Postfix) with ESMTP id AAE1924474
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 01:10:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Unfortunately, the X-Fi does not have a hardware master volume control, so we have
to create a virtual master and bind all playback controls to it.

This patch depends on the patch that renames Master to PCM.

Signed-off-by: William Pitcock <nenolod@sacredspiral.co.uk>
---
 sound/pci/sbxfi/sbxfi.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
index 3e99a97..d8b32aa 100644
--- a/sound/pci/sbxfi/sbxfi.c
+++ b/sound/pci/sbxfi/sbxfi.c
@@ -1685,15 +1685,45 @@ static struct snd_kcontrol_new mixers[] __devinitdata = {
 	},
 };
 
+/* list of controls to attach to the master volume control. */
+static const char *slave_vols[] __devinitdata = {
+	"PCM Playback Volume",
+};
+
 static int __devinit sbxfi_create_mixer(struct sbxfi *chip)
 {
 	int i, err;
+	struct snd_kcontrol *vmaster;
 
 	for (i = 0; i < ARRAY_SIZE(mixers); i++) {
 		err = snd_ctl_add(chip->card, snd_ctl_new1(&mixers[i], chip));
 		if (err < 0)
 			return err;
 	}
+
+	/*
+	 * Unfortunately, it seems that there is no master control, unlike
+	 * on the emu10k1 series, so we create a virtual master, and bind
+	 * our playback controls to it.
+	 */
+	vmaster = snd_ctl_make_virtual_master("Master Playback Volume", NULL);
+	if (vmaster == NULL)
+		return -ENOMEM;
+
+	/* attach the master to the card, and attach all slaves to it. */
+	snd_ctl_add(chip->card, vmaster);
+	for (i = 0; i < ARRAY_SIZE(slave_vols); i++) {
+		struct snd_kcontrol *slave;
+		struct snd_ctl_elem_id sid;
+
+		memset(&sid, 0, sizeof(sid));
+		strlcpy(sid.name, slave_vols[i], 44);	/* XXX this should be a constant defined somewhere */
+		sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+
+		if ((slave = snd_ctl_find_id(chip->card, &sid)) != NULL)
+			snd_ctl_add_slave(vmaster, slave);
+	}
+
 	return 0;
 }
 
-- 
1.5.5.4
