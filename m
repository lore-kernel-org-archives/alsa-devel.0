From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] emufx: reduce stack usage
Date: Tue, 01 Jul 2003 10:46:20 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307011042240.28783-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- Reduced stack usage.
- Added a call to copy_from_user() to SNDRV_EMU10K1_IOCTL_PCM_POKE.
  With this, the ioctl actually might be useful. :)


Index: alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.33
diff -u -r1.33 emufx.c
--- alsa-kernel/pci/emu10k1/emufx.c	9 Jun 2003 08:57:05 -0000	1.33
+++ alsa-kernel/pci/emu10k1/emufx.c	1 Jul 2003 08:12:40 -0000
@@ -945,12 +945,15 @@
 	snd_emu10k1_fx8010_ctl_t *ctl, nctl;
 	snd_kcontrol_new_t knew;
 	snd_kcontrol_t *kctl;
-	snd_ctl_elem_value_t val;
+	snd_ctl_elem_value_t *val;

+	val = (snd_ctl_elem_value_t *)kmalloc(sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return;
 	for (i = 0, _gctl = icode->gpr_add_controls;
 	     i < icode->gpr_add_control_count; i++, _gctl++) {
 		if (copy_from_user(&gctl, _gctl, sizeof(gctl)))
-			return;
+			break;
 		snd_runtime_check(gctl.id.iface == SNDRV_CTL_ELEM_IFACE_MIXER ||
 		                  gctl.id.iface == SNDRV_CTL_ELEM_IFACE_PCM, continue);
 		snd_runtime_check(gctl.id.name[0] != '\0', continue);
@@ -970,7 +973,7 @@
 		for (j = 0; j < 32; j++) {
 			nctl.gpr[j] = gctl.gpr[j];
 			nctl.value[j] = ~gctl.value[j];	/* inverted, we want to write new value in gpr_ctl_put() */
-			val.value.integer.value[j] = gctl.value[j];
+			val->value.integer.value[j] = gctl.value[j];
 		}
 		nctl.min = gctl.min;
 		nctl.max = gctl.max;
@@ -996,8 +999,9 @@
 			snd_ctl_notify(emu->card, SNDRV_CTL_EVENT_MASK_VALUE |
 			                          SNDRV_CTL_EVENT_MASK_INFO, &ctl->kcontrol->id);
 		}
-		snd_emu10k1_gpr_ctl_put(ctl->kcontrol, &val);
+		snd_emu10k1_gpr_ctl_put(ctl->kcontrol, val);
 	}
+	kfree(val);
 }

 static void snd_emu10k1_del_controls(emu10k1_t *emu, emu10k1_fx8010_code_t *icode)
@@ -2227,7 +2231,7 @@
 static int snd_emu10k1_fx8010_ioctl(snd_hwdep_t * hw, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	emu10k1_t *emu = snd_magic_cast(emu10k1_t, hw->private_data, return -ENXIO);
-	emu10k1_fx8010_info_t info;
+	emu10k1_fx8010_info_t *info;
 	emu10k1_fx8010_code_t *icode;
 	emu10k1_fx8010_pcm_t *ipcm;
 	unsigned int addr;
@@ -2235,10 +2239,18 @@

 	switch (cmd) {
 	case SNDRV_EMU10K1_IOCTL_INFO:
-		if ((res = snd_emu10k1_fx8010_info(emu, &info)) < 0)
+		info = (emu10k1_fx8010_info_t *)kmalloc(sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+		if ((res = snd_emu10k1_fx8010_info(emu, info)) < 0) {
+			kfree(info);
 			return res;
-		if (copy_to_user((void *)arg, &info, sizeof(info)))
+		}
+		if (copy_to_user((void *)arg, info, sizeof(*info))) {
+			kfree(info);
 			return -EFAULT;
+		}
+		kfree(info);
 		return 0;
 	case SNDRV_EMU10K1_IOCTL_CODE_POKE:
 		if (!capable(CAP_SYS_ADMIN))
@@ -2271,9 +2283,13 @@
 	case SNDRV_EMU10K1_IOCTL_PCM_POKE:
 		if (emu->audigy)
 			return -EINVAL;
-		ipcm = (emu10k1_fx8010_pcm_t *)snd_kcalloc(sizeof(*ipcm), GFP_KERNEL);
+		ipcm = (emu10k1_fx8010_pcm_t *)kmalloc(sizeof(*ipcm), GFP_KERNEL);
 		if (ipcm == NULL)
 			return -ENOMEM;
+		if (copy_from_user(ipcm, (void *)arg, sizeof(*ipcm))) {
+			kfree(ipcm);
+			return -EFAULT;
+		}
 		res = snd_emu10k1_ipcm_poke(emu, ipcm);
 		kfree(ipcm);
 		return res;




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
