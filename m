From: Igor Chernyshev <igor.ch75+alsa@gmail.com>
Subject: Re: Patch for suspend/resume in ICE1724 for Audiotrak
	Prodigy HD2
Date: Mon, 22 Jun 2009 12:46:48 -0700
Message-ID: <75570e410906221246l3125dega728835cb407ba4@mail.gmail.com>
References: <75570e410906192337p1e9aea9cn9edbea987f6ffbb4@mail.gmail.com>
	<s5h3a9scja2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id A6E9224620
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 21:46:49 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1484302ywq.2
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 12:46:48 -0700 (PDT)
In-Reply-To: <s5h3a9scja2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

here is the patch for:

  Supported suspend/resume in Audiotrak Prodigy HD2

Please, let me know if you want some special testing, patch
formatting, etc on my part. So far I did suspend-resume with MythTV
playing AVI and DVD through RCA. In original ALSA 1.0.20, MythTV
playback upon resume would start ~20% faster than before suspend,
volume would go to max (or above? given how awfully loud the noises
were) and there would be ton of noises. After the change, resume gives
clean playback in MythTV. I suspect that I may not have covered
different scenarios (e.g. driver implies there may be 3 pcm's, ac97,
and mic) in my testing.

Thanks,
Igor

Here is the part I know about :    : )))

Signed-off-by: Igor Chernyshev <igor.ch75+alsa at gmail.com>

-----

diff -uN alsa-driver-1.0.20.orig/alsa-kernel/pci/ice1712/ice1712.h
alsa-driver-1.0.20/alsa-kernel/pci/ice1712/ice1712.h
--- alsa-driver-1.0.20.orig/alsa-kernel/pci/ice1712/ice1712.h	2009-05-06
00:06:04.000000000 -0700
+++ alsa-driver-1.0.20/alsa-kernel/pci/ice1712/ice1712.h	2009-06-19
22:27:12.000000000 -0700
@@ -378,6 +378,15 @@
 	unsigned char (*set_mclk)(struct snd_ice1712 *ice, unsigned int rate);
 	void (*set_spdif_clock)(struct snd_ice1712 *ice);

+#ifdef CONFIG_PM
+	int (*pm_suspend)(struct snd_ice1712 *);
+	int (*pm_resume)(struct snd_ice1712 *);
+	int pm_suspend_enabled:1;
+	int pm_saved_is_spdif_master:1;
+	unsigned int pm_saved_spdif_ctrl;
+	unsigned char pm_saved_spdif_cfg;
+	unsigned long pm_saved_route;
+#endif
 };


diff -uN alsa-driver-1.0.20.orig/alsa-kernel/pci/ice1712/ice1724.c
alsa-driver-1.0.20/alsa-kernel/pci/ice1712/ice1724.c
--- alsa-driver-1.0.20.orig/alsa-kernel/pci/ice1712/ice1724.c	2009-05-06
00:06:04.000000000 -0700
+++ alsa-driver-1.0.20/alsa-kernel/pci/ice1712/ice1724.c	2009-06-22
12:13:26.000000000 -0700
@@ -568,6 +568,10 @@
 		spin_unlock(&ice->reg_lock);
 		break;

+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -2266,6 +2270,14 @@

 	outb(0, ICEREG1724(ice, POWERDOWN));

+	/* MPU_RX and TX irq masks are cleared later dynamically */
+	outb(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX , ICEREG1724(ice, IRQMASK));
+
+	/* don't handle FIFO overrun/underruns (just yet),
+	 * since they cause machine lockups
+	 */
+	outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK));
+
 	return 0;
 }

@@ -2407,6 +2419,8 @@
 	snd_vt1724_proc_init(ice);
 	synchronize_irq(pci->irq);

+	card->private_data =3D ice;
+
 	err =3D pci_request_regions(pci, "ICE1724");
 	if (err < 0) {
 		kfree(ice);
@@ -2435,14 +2449,6 @@
 		return -EIO;
 	}

-	/* MPU_RX and TX irq masks are cleared later dynamically */
-	outb(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX , ICEREG1724(ice, IRQMASK));
-
-	/* don't handle FIFO overrun/underruns (just yet),
-	 * since they cause machine lockups
-	 */
-	outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK));
-
 	err =3D snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
 	if (err < 0) {
 		snd_vt1724_free(ice);
@@ -2626,11 +2632,104 @@
 	pci_set_drvdata(pci, NULL);
 }

+#ifdef CONFIG_PM
+static int snd_vt1724_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	struct snd_card *card =3D pci_get_drvdata(pci);
+	struct snd_ice1712 *ice =3D card->private_data;
+
+	if (!ice->pm_suspend_enabled)
+		return 0;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+
+	if (ice->pcm)
+		snd_pcm_suspend_all(ice->pcm);
+	if (ice->pcm_pro)
+		snd_pcm_suspend_all(ice->pcm_pro);
+	if (ice->pcm_ds)
+		snd_pcm_suspend_all(ice->pcm_ds);
+	if (ice->ac97)
+		snd_ac97_suspend(ice->ac97);
+
+	spin_lock_irq(&ice->reg_lock);
+	ice->pm_saved_is_spdif_master =3D ice->is_spdif_master(ice);
+	ice->pm_saved_spdif_ctrl =3D inw(ICEMT1724(ice, SPDIF_CTRL));
+	ice->pm_saved_spdif_cfg =3D inb(ICEREG1724(ice, SPDIF_CFG));
+	ice->pm_saved_route =3D inl(ICEMT1724(ice, ROUTE_PLAYBACK));
+	spin_unlock_irq(&ice->reg_lock);
+
+	if (ice->pm_suspend)
+		ice->pm_suspend(ice);
+
+	pci_disable_device(pci);
+	pci_save_state(pci);
+	pci_set_power_state(pci, pci_choose_state(pci, state));
+	return 0;
+}
+
+static int snd_vt1724_resume(struct pci_dev *pci)
+{
+	struct snd_card *card =3D pci_get_drvdata(pci);
+	struct snd_ice1712 *ice =3D card->private_data;
+
+	if (!ice->pm_suspend_enabled)
+		return 0;
+
+	pci_set_power_state(pci, PCI_D0);
+	pci_restore_state(pci);
+
+	if (pci_enable_device(pci) < 0) {
+		snd_card_disconnect(card);
+		return -EIO;
+	}
+
+	pci_set_master(pci);
+
+	snd_vt1724_chip_reset(ice);
+
+	if (snd_vt1724_chip_init(ice) < 0) {
+		snd_card_disconnect(card);
+		return -EIO;
+	}
+
+	if (ice->pm_resume)
+		ice->pm_resume(ice);
+
+	spin_lock_irq(&ice->reg_lock);
+	if (ice->pm_saved_is_spdif_master) {
+		/* switching to external clock via SPDIF */
+		ice->set_spdif_clock(ice);
+	} else {
+		/* internal on-card clock */
+		spin_unlock_irq(&ice->reg_lock);
+		snd_vt1724_set_pro_rate(ice, ice->pro_rate_default, 1);
+		spin_lock_irq(&ice->reg_lock);
+	}
+
+	update_spdif_bits(ice, ice->pm_saved_spdif_ctrl);
+
+	outb(ice->pm_saved_spdif_cfg, ICEREG1724(ice, SPDIF_CFG));
+	outl(ice->pm_saved_route, ICEMT1724(ice, ROUTE_PLAYBACK));
+	spin_unlock_irq(&ice->reg_lock);
+
+	if (ice->ac97)
+		snd_ac97_resume(ice->ac97);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+#endif
+
 static struct pci_driver driver =3D {
 	.name =3D "ICE1724",
 	.id_table =3D snd_vt1724_ids,
 	.probe =3D snd_vt1724_probe,
 	.remove =3D __devexit_p(snd_vt1724_remove),
+#ifdef CONFIG_PM
+	.suspend =3D snd_vt1724_suspend,
+	.resume =3D snd_vt1724_resume,
+#endif
 };

 static int __init alsa_card_ice1724_init(void)
diff -uN alsa-driver-1.0.20.orig/alsa-kernel/pci/ice1712/prodigy_hifi.c
alsa-driver-1.0.20/alsa-kernel/pci/ice1712/prodigy_hifi.c
--- alsa-driver-1.0.20.orig/alsa-kernel/pci/ice1712/prodigy_hifi.c	2009-05-=
06
00:06:04.000000000 -0700
+++ alsa-driver-1.0.20/alsa-kernel/pci/ice1712/prodigy_hifi.c	2009-06-22
12:06:28.000000000 -0700
@@ -1077,8 +1077,7 @@
 /*
  * initialize the chip
  */
-static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
-{
+static void ak4396_init(struct snd_ice1712 *ice) {
 	static unsigned short ak4396_inits[] =3D {
 		AK4396_CTRL1,	   0x87,   /* I2S Normal Mode, 24 bit */
 		AK4396_CTRL2,	   0x02,
@@ -1087,9 +1086,38 @@
 		AK4396_RCH_ATT,	 0x00,
 	};

-	struct prodigy_hifi_spec *spec;
 	unsigned int i;

+	/* initialize ak4396 codec */
+	/* reset codec */
+	ak4396_write(ice, AK4396_CTRL1, 0x86);
+	msleep(100);
+	ak4396_write(ice, AK4396_CTRL1, 0x87);
+			=

+	for (i =3D 0; i < ARRAY_SIZE(ak4396_inits); i +=3D 2)
+		ak4396_write(ice, ak4396_inits[i], ak4396_inits[i+1]);
+}
+
+#ifdef CONFIG_PM
+static int __devinit prodigy_hd2_resume(struct snd_ice1712 *ice)
+{
+	/* initialize ak4396 codec and restore previous mixer volumes */
+	struct prodigy_hifi_spec *spec =3D ice->spec;
+	int i;
+	mutex_lock(&ice->gpio_mutex);
+	ak4396_init(ice);
+	for (i =3D 0; i < 2; i++) {
+		ak4396_write(ice, AK4396_LCH_ATT + i, spec->vol[i] & 0xff);
+	}
+	mutex_unlock(&ice->gpio_mutex);
+	return 0;
+}
+#endif
+
+static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
+{
+	struct prodigy_hifi_spec *spec;
+
 	ice->vt1720 =3D 0;
 	ice->vt1724 =3D 1;

@@ -1112,14 +1140,12 @@
 		return -ENOMEM;
 	ice->spec =3D spec;

-	/* initialize ak4396 codec */
-	/* reset codec */
-	ak4396_write(ice, AK4396_CTRL1, 0x86);
-	msleep(100);
-	ak4396_write(ice, AK4396_CTRL1, 0x87);
-			=

-	for (i =3D 0; i < ARRAY_SIZE(ak4396_inits); i +=3D 2)
-		ak4396_write(ice, ak4396_inits[i], ak4396_inits[i+1]);
+#ifdef CONFIG_PM
+	ice->pm_resume =3D &prodigy_hd2_resume;
+	ice->pm_suspend_enabled =3D 1;
+#endif
+
+	ak4396_init(ice);

 	return 0;
 }


On Mon, Jun 22, 2009 at 9:42 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Fri, 19 Jun 2009 23:37:16 -0700,
> Igor Chernyshev wrote:
> >
> > Hi Alsa Developers!
> >
> > I've built a small HTPC and had to add suspend/resume support in ice1724
> > driver. There seem to be 3 existing bugs related to that:
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4413
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3748
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2314
> >
> > Due to hardware (un)availability, I only enabled the fix for Audiotrak
> > Prodigy HD2 card, which is installed in my HTPC. However, most of my co=
de
> > should be reusable in the future on other ice1724-based cards as well (=
as
> > long as people add card-specific peices of code). The fix is currently =
based
> > on ALSA 1.0.20 and works on my MythBuntu 9.04 HTPC (using 2.6.28-11 ker=
nel).
> >
> > The following files have been modified:
> > =A0 alsa-kernel/pci/ice1712/ice1712.h
> > =A0 alsa-kernel/pci/ice1712/ice1724.c
> > =A0 alsa-kernel/pci/ice1712/prodigy_hifi.c
> >
> > Now, I'm a complete newbie in Linux development and not sure I can safe=
ly
> > rebuild latest Linux Kernel under MythBuntu, etc. Are there any resourc=
es
> > for people like me to read? I want to provide the patch without destroy=
ing
> > my computer a hunder times, but also make it more convenient and safer =
for
> > ALSA maintainers.
>
> Well, I'd like to see the patch before anything else :)
> Could you just post your patch for review?
>
>
> thanks,
>
> Takashi
