From: fmoraes@nc.rr.com
Subject: [PATCH] remove AC97 existing control
Date: Tue, 22 Mar 2005 07:45:15 -0500
Message-ID: <cecf51cf0059.cf0059cecf51@southeast.rr.com>
Reply-To: fmoraes@nc.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_3h2IZOE2uch35ng4qpQRdA)"
Content-language: en
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Boundary_(ID_3h2IZOE2uch35ng4qpQRdA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

This patch should fix bug report 752 by removing the existing control from the AC97.


Sign off: Francisco Moraes


--Boundary_(ID_3h2IZOE2uch35ng4qpQRdA)
Content-type: text/x-patch; NAME=emu10k1x_mixer.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=emu10k1x_mixer.patch

Index: alsa-kernel/pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.7
diff -u -r1.7 emu10k1x.c
--- alsa-kernel/pci/emu10k1/emu10k1x.c	21 Mar 2005 08:13:32 -0000	1.7
+++ alsa-kernel/pci/emu10k1/emu10k1x.c	22 Mar 2005 12:35:48 -0000
@@ -1201,6 +1201,25 @@
 	.put =          snd_emu10k1x_spdif_put
 };
 
+static int remove_ctl(snd_card_t *card, const char *name)
+{
+	snd_ctl_elem_id_t id;
+	memset(&id, 0, sizeof(id));
+	strcpy(id.name, name);
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	return snd_ctl_remove_id(card, &id);
+}
+
+static snd_kcontrol_t *ctl_find(snd_card_t *card, const char *name)
+{
+	snd_ctl_elem_id_t sid;
+	memset(&sid, 0, sizeof(sid));
+	/* FIXME: strcpy is bad. */
+	strcpy(sid.name, name);
+	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	return snd_ctl_find_id(card, &sid);
+}
+
 static int __devinit snd_emu10k1x_mixer(emu10k1x_t *emu)
 {
 	int err;
@@ -1215,6 +1234,11 @@
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
+	if ((kctl = ctl_find(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT))) != NULL) {
+		/* already defined by ac97, remove it */
+		/* FIXME: or do we need both controls? */
+		remove_ctl(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT));
+	}
 	if ((kctl = snd_ctl_new1(&snd_emu10k1x_spdif_control, emu)) == NULL)
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))

--Boundary_(ID_3h2IZOE2uch35ng4qpQRdA)--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
