From: Michael Huijsmans <mgh@telering.at>
Subject: [PATCH] ens1373/ct5880 - Switch Line In to Rear Out
Date: Sun, 11 Jan 2004 18:55:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040111185547.34073761.mike@marune.alastor>
Reply-To: mgh@telering.at
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

The Gigabyte GA-7DXR motherboard has a 4-channel SB128 
(ct5880 + STAC9708/11) onboard. The line in and second line out (rear out)
are wired to the same connector. 
After some trial-and-error with the ct5880 GPIO registers I found one which
switches line in to rear out.

The patch below adds a new mixer element when the ens1371 finds itself
on a GA-7DXR (by checking subsystem vendor & device IDs).
Other motherboards with the ct5880 may have different IDs and/or
may require a different GPIO line.

Cheers,
Mike

 
--- alsa-driver-1.0.1-orig/alsa-kernel/pci/ens1370.c	2003-10-28 12:28:01.000000000 +0100
+++ alsa-driver-1.0.1/alsa-kernel/pci/ens1370.c	2004-01-10 16:45:12.000000000 +0100
@@ -1512,6 +1512,54 @@
 	.put =		snd_es1373_rear_put,
 };
 
+static int snd_es1373_line_info(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t *uinfo)
+{
+        uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+        uinfo->count = 1;
+        uinfo->value.integer.min = 0;
+        uinfo->value.integer.max = 1;
+        return 0;
+}
+
+static int snd_es1373_line_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
+{
+	ensoniq_t *ensoniq = snd_kcontrol_chip(kcontrol);
+	int val = 0;
+	
+	spin_lock_irq(&ensoniq->reg_lock);
+	if ((ensoniq->ctrl & ES_1371_GPIO_OUTM) >= 4)
+	    	val = 1;
+	ucontrol->value.integer.value[0] = val;
+	spin_unlock_irq(&ensoniq->reg_lock);
+	return 0;
+}
+
+static int snd_es1373_line_put(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
+{
+	ensoniq_t *ensoniq = snd_kcontrol_chip(kcontrol);
+	unsigned int nval1 = 0;
+	
+	nval1 = ucontrol->value.integer.value[0];
+	spin_lock_irq(&ensoniq->reg_lock);
+	if(nval1) {
+	  ensoniq->ctrl |= ES_1371_GPIO_OUT(4);	/* switch line-in -> rear out */
+	} else {
+	  ensoniq->ctrl &= ~(ES_1371_GPIO_OUT(4));
+	}
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	spin_unlock_irq(&ensoniq->reg_lock);
+	return nval1;
+}
+
+static snd_kcontrol_new_t snd_ens1373_line __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Line In->Rear Out Switch",
+	.info =		snd_es1373_line_info,
+	.get =		snd_es1373_line_get,
+	.put =		snd_es1373_line_put,
+};
+
 static void snd_ensoniq_mixer_free_ac97(ac97_t *ac97)
 {
 	ensoniq_t *ensoniq = snd_magic_cast(ensoniq_t,
ac97->private_data, return);
@@ -1586,6 +1634,11 @@
 		ensoniq->cssr |= ES_1373_REAR_BIT26;
 		snd_ctl_add(card, snd_ctl_new1(&snd_ens1373_rear, ensoniq));
 	}
+	if ((ensoniq->subsystem_vendor_id == 0x1274) &&
+	    (ensoniq->subsystem_device_id == 0x2000)) { /* GA-7DXR */
+		 snd_ctl_add(card, snd_ctl_new1(&snd_ens1373_line, ensoniq));
+	}
+
 	return 0;
 }




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
