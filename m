From: Igor Chernyshev <igor.ch75+alsa@gmail.com>
Subject: Re: Patch for suspend/resume in ICE1724 for Audiotrak
	Prodigy HD2
Date: Thu, 25 Jun 2009 00:23:24 -0700
Message-ID: <75570e410906250023q3493667cw308df5ac88d43f7a@mail.gmail.com>
References: <75570e410906192337p1e9aea9cn9edbea987f6ffbb4@mail.gmail.com>
	<s5h3a9scja2.wl%tiwai@suse.de>
	<75570e410906221246l3125dega728835cb407ba4@mail.gmail.com>
	<s5hprcvb4nz.wl%tiwai@suse.de>
	<75570e410906231550g47bffd92gfaa24d988bbcdca2@mail.gmail.com>
	<s5hljni9byq.wl%tiwai@suse.de>
	<75570e410906242315m4432d7cfk450e23d039d0b9a4@mail.gmail.com>
	<s5heit8n67o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6476e766d3333046d2719c4
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f189.google.com (mail-yx0-f189.google.com
	[209.85.210.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C68E24B06
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 09:23:26 +0200 (CEST)
Received: by yxe27 with SMTP id 27so345870yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 00:23:25 -0700 (PDT)
In-Reply-To: <s5heit8n67o.wl%tiwai@suse.de>
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

--0016e6476e766d3333046d2719c4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2009 at 12:05 AM, Takashi Iwai<tiwai@suse.de> wrote:
> At Wed, 24 Jun 2009 23:15:50 -0700,
> Igor Chernyshev wrote:
>>
>> Takashi,
>>
>> below is the same patch based on the latest snapshot.
>
> Your MUA (gmail?) broke the embedded patch by line-breaking, so it
> can't be applied.
>
> Either fix your MUA setup not to do that or use an attachment if it's
> difficult.

Strange... I was using Gmail Web interface in plain text mode for all
the emails in this thread and it used to work. Anyway, I'm attaching
the patch now. And just in case Gmail messes up again, I also uploaded
patch here: http://www.rinacherry.com/patchfile2

Sorry for the problems.

>
>
> thanks,
>
> Takashi
>
>>
>> Thanks,
>> Igor
>>
>> On Wed, Jun 24, 2009 at 3:13 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> > At Tue, 23 Jun 2009 15:50:44 -0700,
>> > Igor Chernyshev wrote:
>> >>
>> >> >> + =A0 =A0 unsigned long pm_saved_route;
>> >> >
>> >> > This shouldn't be long but int. =A0Long can be 64bit unnecessarily.
>> >>
>> >> Done. However, note that existing code uses results of
>> >> "inl(ICEMT1724(ice, ROUTE_PLAYBACK))" as both int and long.
>> >>
>> >> >> + =A0 =A0 case SNDRV_PCM_TRIGGER_SUSPEND:
>> >> >> + =A0 =A0 case SNDRV_PCM_TRIGGER_RESUME:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >
>> >> > At least, TRIGGER_SUSPEND neees to stop the PCM stream.
>> >>
>> >> Consolidated with SNDRV_PCM_TRIGGER_STOP processing.
>> >>
>> >> >> + =A0 =A0 outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK)=
);
>> >> >> +
>> >> >
>> >> > This is fine, but you need to remove __devinit from this function.
>> >>
>> >> Done.
>> >>
>> >> >> + =A0 =A0 if (ice->ac97)
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 snd_ac97_suspend(ice->ac97);
>> >> >
>> >> > No need for NULL check here. =A0All these check NULL by themselves.
>> >>
>> >> Removed all 4 checks (pcm's and ac97).
>> >>
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&ice->reg_lock);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 snd_vt1724_set_pro_rate(ice, ice->pro_ra=
te_default, 1);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&ice->reg_lock);
>> >> >> + =A0 =A0 }
>> >> >
>> >> > These are basically no need to protect with spinlock, at least,
>> >> > in this function...
>> >>
>> >> Removed locking in "resume" only.
>> >>
>> >> > Last but not least, try to run $LINUX/scripts/checkpatch.pl to your
>> >> > patch once and fix the issues suggested there.
>> >>
>> >> Thanks for the pointer. Fixed 3 code style problems. It also complain=
s
>> >> about missing "signed off" line, but I hope that line here will
>> >> suffice:
>> >>
>> >> Signed-off-by: Igor Chernyshev <igor.ch75+alsa at gmail.com>
>> >
>> > Thanks, this looks better. =A0But, I got some rejects when applying
>> > to the latest tree, and I guess your patch is based on 1.0.20 release.
>> >
>> > Please try to rebase to the latest alsa-driver snapshot and repost
>> > the patch, either against sound git tree or alsa-driver-snapshot
>> > tarball below:
>> > =A0git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>> > =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-dr=
iver-snapshot.tar.gz
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>>
>> diff -uN alsa-driver.orig/alsa-kernel/pci/ice1712/ice1712.h
>> alsa-driver/alsa-kernel/pci/ice1712/ice1712.h
>> --- alsa-driver.orig/alsa-kernel/pci/ice1712/ice1712.h =A0 =A0 =A0 =A020=
09-06-24
>> 15:05:06.000000000 -0700
>> +++ alsa-driver/alsa-kernel/pci/ice1712/ice1712.h =A0 =A0 2009-06-24
>> 21:51:53.000000000 -0700
>> @@ -379,6 +379,15 @@
>> =A0 =A0 =A0 unsigned char (*set_mclk)(struct snd_ice1712 *ice, unsigned =
int rate);
>> =A0 =A0 =A0 void (*set_spdif_clock)(struct snd_ice1712 *ice);
>>
>> +#ifdef CONFIG_PM
>> + =A0 =A0 int (*pm_suspend)(struct snd_ice1712 *);
>> + =A0 =A0 int (*pm_resume)(struct snd_ice1712 *);
>> + =A0 =A0 int pm_suspend_enabled:1;
>> + =A0 =A0 int pm_saved_is_spdif_master:1;
>> + =A0 =A0 unsigned int pm_saved_spdif_ctrl;
>> + =A0 =A0 unsigned char pm_saved_spdif_cfg;
>> + =A0 =A0 unsigned int pm_saved_route;
>> +#endif
>> =A0};
>>
>>
>> diff -uN alsa-driver.orig/alsa-kernel/pci/ice1712/ice1724.c
>> alsa-driver/alsa-kernel/pci/ice1712/ice1724.c
>> --- alsa-driver.orig/alsa-kernel/pci/ice1712/ice1724.c =A0 =A0 =A0 =A020=
09-06-24
>> 15:05:06.000000000 -0700
>> +++ alsa-driver/alsa-kernel/pci/ice1712/ice1724.c =A0 =A0 2009-06-24
>> 22:13:25.000000000 -0700
>> @@ -560,6 +560,7 @@
>>
>> =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_START:
>> =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_STOP:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_SUSPEND:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&ice->reg_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 old =3D inb(ICEMT1724(ice, DMA_CONTROL));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmd =3D=3D SNDRV_PCM_TRIGGER_START)
>> @@ -570,6 +571,10 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&ice->reg_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_RESUME:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* apps will have to restart stream */
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 }
>> @@ -2272,7 +2277,7 @@
>> =A0 =A0 =A0 msleep(10);
>> =A0}
>>
>> -static int __devinit snd_vt1724_chip_init(struct snd_ice1712 *ice)
>> +static int snd_vt1724_chip_init(struct snd_ice1712 *ice)
>> =A0{
>> =A0 =A0 =A0 outb(ice->eeprom.data[ICE_EEP2_SYSCONF], ICEREG1724(ice, SYS=
_CFG));
>> =A0 =A0 =A0 outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97=
_CFG));
>> @@ -2287,6 +2292,14 @@
>>
>> =A0 =A0 =A0 outb(0, ICEREG1724(ice, POWERDOWN));
>>
>> + =A0 =A0 /* MPU_RX and TX irq masks are cleared later dynamically */
>> + =A0 =A0 outb(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX , ICEREG1724(ice, I=
RQMASK));
>> +
>> + =A0 =A0 /* don't handle FIFO overrun/underruns (just yet),
>> + =A0 =A0 =A0* since they cause machine lockups
>> + =A0 =A0 =A0*/
>> + =A0 =A0 outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK));
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -2431,6 +2444,8 @@
>> =A0 =A0 =A0 snd_vt1724_proc_init(ice);
>> =A0 =A0 =A0 synchronize_irq(pci->irq);
>>
>> + =A0 =A0 card->private_data =3D ice;
>> +
>> =A0 =A0 =A0 err =3D pci_request_regions(pci, "ICE1724");
>> =A0 =A0 =A0 if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(ice);
>> @@ -2459,14 +2474,6 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /* MPU_RX and TX irq masks are cleared later dynamically */
>> - =A0 =A0 outb(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX , ICEREG1724(ice, I=
RQMASK));
>> -
>> - =A0 =A0 /* don't handle FIFO overrun/underruns (just yet),
>> - =A0 =A0 =A0* since they cause machine lockups
>> - =A0 =A0 =A0*/
>> - =A0 =A0 outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK));
>> -
>> =A0 =A0 =A0 err =3D snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
>> =A0 =A0 =A0 if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_vt1724_free(ice);
>> @@ -2650,11 +2657,96 @@
>> =A0 =A0 =A0 pci_set_drvdata(pci, NULL);
>> =A0}
>>
>> +#ifdef CONFIG_PM
>> +static int snd_vt1724_suspend(struct pci_dev *pci, pm_message_t state)
>> +{
>> + =A0 =A0 struct snd_card *card =3D pci_get_drvdata(pci);
>> + =A0 =A0 struct snd_ice1712 *ice =3D card->private_data;
>> +
>> + =A0 =A0 if (!ice->pm_suspend_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
>> +
>> + =A0 =A0 snd_pcm_suspend_all(ice->pcm);
>> + =A0 =A0 snd_pcm_suspend_all(ice->pcm_pro);
>> + =A0 =A0 snd_pcm_suspend_all(ice->pcm_ds);
>> + =A0 =A0 snd_ac97_suspend(ice->ac97);
>> +
>> + =A0 =A0 spin_lock_irq(&ice->reg_lock);
>> + =A0 =A0 ice->pm_saved_is_spdif_master =3D ice->is_spdif_master(ice);
>> + =A0 =A0 ice->pm_saved_spdif_ctrl =3D inw(ICEMT1724(ice, SPDIF_CTRL));
>> + =A0 =A0 ice->pm_saved_spdif_cfg =3D inb(ICEREG1724(ice, SPDIF_CFG));
>> + =A0 =A0 ice->pm_saved_route =3D inl(ICEMT1724(ice, ROUTE_PLAYBACK));
>> + =A0 =A0 spin_unlock_irq(&ice->reg_lock);
>> +
>> + =A0 =A0 if (ice->pm_suspend)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ice->pm_suspend(ice);
>> +
>> + =A0 =A0 pci_disable_device(pci);
>> + =A0 =A0 pci_save_state(pci);
>> + =A0 =A0 pci_set_power_state(pci, pci_choose_state(pci, state));
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int snd_vt1724_resume(struct pci_dev *pci)
>> +{
>> + =A0 =A0 struct snd_card *card =3D pci_get_drvdata(pci);
>> + =A0 =A0 struct snd_ice1712 *ice =3D card->private_data;
>> +
>> + =A0 =A0 if (!ice->pm_suspend_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 pci_set_power_state(pci, PCI_D0);
>> + =A0 =A0 pci_restore_state(pci);
>> +
>> + =A0 =A0 if (pci_enable_device(pci) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_card_disconnect(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pci_set_master(pci);
>> +
>> + =A0 =A0 snd_vt1724_chip_reset(ice);
>> +
>> + =A0 =A0 if (snd_vt1724_chip_init(ice) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_card_disconnect(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (ice->pm_resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ice->pm_resume(ice);
>> +
>> + =A0 =A0 if (ice->pm_saved_is_spdif_master) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* switching to external clock via SPDIF */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ice->set_spdif_clock(ice);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* internal on-card clock */
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_vt1724_set_pro_rate(ice, ice->pro_rate_def=
ault, 1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 update_spdif_bits(ice, ice->pm_saved_spdif_ctrl);
>> +
>> + =A0 =A0 outb(ice->pm_saved_spdif_cfg, ICEREG1724(ice, SPDIF_CFG));
>> + =A0 =A0 outl(ice->pm_saved_route, ICEMT1724(ice, ROUTE_PLAYBACK));
>> +
>> + =A0 =A0 if (ice->ac97)
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_ac97_resume(ice->ac97);
>> +
>> + =A0 =A0 snd_power_change_state(card, SNDRV_CTL_POWER_D0);
>> + =A0 =A0 return 0;
>> +}
>> +#endif
>> +
>> =A0static struct pci_driver driver =3D {
>> =A0 =A0 =A0 .name =3D "ICE1724",
>> =A0 =A0 =A0 .id_table =3D snd_vt1724_ids,
>> =A0 =A0 =A0 .probe =3D snd_vt1724_probe,
>> =A0 =A0 =A0 .remove =3D __devexit_p(snd_vt1724_remove),
>> +#ifdef CONFIG_PM
>> + =A0 =A0 .suspend =3D snd_vt1724_suspend,
>> + =A0 =A0 .resume =3D snd_vt1724_resume,
>> +#endif
>> =A0};
>>
>> =A0static int __init alsa_card_ice1724_init(void)
>> diff -uN alsa-driver.orig/alsa-kernel/pci/ice1712/prodigy_hifi.c
>> alsa-driver/alsa-kernel/pci/ice1712/prodigy_hifi.c
>> --- alsa-driver.orig/alsa-kernel/pci/ice1712/prodigy_hifi.c =A0 2009-06-=
24
>> 15:05:06.000000000 -0700
>> +++ alsa-driver/alsa-kernel/pci/ice1712/prodigy_hifi.c =A0 =A0 =A0 =A020=
09-06-24
>> 22:00:04.000000000 -0700
>> @@ -1077,7 +1077,7 @@
>> =A0/*
>> =A0 * initialize the chip
>> =A0 */
>> -static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
>> +static void ak4396_init(struct snd_ice1712 *ice)
>> =A0{
>> =A0 =A0 =A0 static unsigned short ak4396_inits[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 AK4396_CTRL1, =A0 =A0 =A00x87, =A0 /* I2S No=
rmal Mode, 24 bit */
>> @@ -1087,9 +1087,37 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 AK4396_RCH_ATT, =A00x00,
>> =A0 =A0 =A0 };
>>
>> - =A0 =A0 struct prodigy_hifi_spec *spec;
>> =A0 =A0 =A0 unsigned int i;
>>
>> + =A0 =A0 /* initialize ak4396 codec */
>> + =A0 =A0 /* reset codec */
>> + =A0 =A0 ak4396_write(ice, AK4396_CTRL1, 0x86);
>> + =A0 =A0 msleep(100);
>> + =A0 =A0 ak4396_write(ice, AK4396_CTRL1, 0x87);
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ak4396_inits); i +=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ak4396_write(ice, ak4396_inits[i], ak4396_init=
s[i+1]);
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int __devinit prodigy_hd2_resume(struct snd_ice1712 *ice)
>> +{
>> + =A0 =A0 /* initialize ak4396 codec and restore previous mixer volumes =
*/
>> + =A0 =A0 struct prodigy_hifi_spec *spec =3D ice->spec;
>> + =A0 =A0 int i;
>> + =A0 =A0 mutex_lock(&ice->gpio_mutex);
>> + =A0 =A0 ak4396_init(ice);
>> + =A0 =A0 for (i =3D 0; i < 2; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ak4396_write(ice, AK4396_LCH_ATT + i, spec->vo=
l[i] & 0xff);
>> + =A0 =A0 mutex_unlock(&ice->gpio_mutex);
>> + =A0 =A0 return 0;
>> +}
>> +#endif
>> +
>> +static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
>> +{
>> + =A0 =A0 struct prodigy_hifi_spec *spec;
>> +
>> =A0 =A0 =A0 ice->vt1720 =3D 0;
>> =A0 =A0 =A0 ice->vt1724 =3D 1;
>>
>> @@ -1112,14 +1140,12 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 ice->spec =3D spec;
>>
>> - =A0 =A0 /* initialize ak4396 codec */
>> - =A0 =A0 /* reset codec */
>> - =A0 =A0 ak4396_write(ice, AK4396_CTRL1, 0x86);
>> - =A0 =A0 msleep(100);
>> - =A0 =A0 ak4396_write(ice, AK4396_CTRL1, 0x87);
>> -
>> - =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ak4396_inits); i +=3D 2)
>> - =A0 =A0 =A0 =A0 =A0 =A0 ak4396_write(ice, ak4396_inits[i], ak4396_init=
s[i+1]);
>> +#ifdef CONFIG_PM
>> + =A0 =A0 ice->pm_resume =3D &prodigy_hd2_resume;
>> + =A0 =A0 ice->pm_suspend_enabled =3D 1;
>> +#endif
>> +
>> + =A0 =A0 ak4396_init(ice);
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>

--0016e6476e766d3333046d2719c4
Content-Type: application/octet-stream; name=patchfile2
Content-Disposition: attachment; filename=patchfile2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwd53dqj0

ZGlmZiAtdU4gYWxzYS1kcml2ZXIub3JpZy9hbHNhLWtlcm5lbC9wY2kvaWNlMTcxMi9pY2UxNzEy
LmggYWxzYS1kcml2ZXIvYWxzYS1rZXJuZWwvcGNpL2ljZTE3MTIvaWNlMTcxMi5oCi0tLSBhbHNh
LWRyaXZlci5vcmlnL2Fsc2Eta2VybmVsL3BjaS9pY2UxNzEyL2ljZTE3MTIuaAkyMDA5LTA2LTI0
IDE1OjA1OjA2LjAwMDAwMDAwMCAtMDcwMAorKysgYWxzYS1kcml2ZXIvYWxzYS1rZXJuZWwvcGNp
L2ljZTE3MTIvaWNlMTcxMi5oCTIwMDktMDYtMjQgMjE6NTE6NTMuMDAwMDAwMDAwIC0wNzAwCkBA
IC0zNzksNiArMzc5LDE1IEBACiAJdW5zaWduZWQgY2hhciAoKnNldF9tY2xrKShzdHJ1Y3Qgc25k
X2ljZTE3MTIgKmljZSwgdW5zaWduZWQgaW50IHJhdGUpOwogCXZvaWQgKCpzZXRfc3BkaWZfY2xv
Y2spKHN0cnVjdCBzbmRfaWNlMTcxMiAqaWNlKTsKIAorI2lmZGVmIENPTkZJR19QTQorCWludCAo
KnBtX3N1c3BlbmQpKHN0cnVjdCBzbmRfaWNlMTcxMiAqKTsKKwlpbnQgKCpwbV9yZXN1bWUpKHN0
cnVjdCBzbmRfaWNlMTcxMiAqKTsKKwlpbnQgcG1fc3VzcGVuZF9lbmFibGVkOjE7CisJaW50IHBt
X3NhdmVkX2lzX3NwZGlmX21hc3RlcjoxOworCXVuc2lnbmVkIGludCBwbV9zYXZlZF9zcGRpZl9j
dHJsOworCXVuc2lnbmVkIGNoYXIgcG1fc2F2ZWRfc3BkaWZfY2ZnOworCXVuc2lnbmVkIGludCBw
bV9zYXZlZF9yb3V0ZTsKKyNlbmRpZgogfTsKIAogCmRpZmYgLXVOIGFsc2EtZHJpdmVyLm9yaWcv
YWxzYS1rZXJuZWwvcGNpL2ljZTE3MTIvaWNlMTcyNC5jIGFsc2EtZHJpdmVyL2Fsc2Eta2VybmVs
L3BjaS9pY2UxNzEyL2ljZTE3MjQuYwotLS0gYWxzYS1kcml2ZXIub3JpZy9hbHNhLWtlcm5lbC9w
Y2kvaWNlMTcxMi9pY2UxNzI0LmMJMjAwOS0wNi0yNCAxNTowNTowNi4wMDAwMDAwMDAgLTA3MDAK
KysrIGFsc2EtZHJpdmVyL2Fsc2Eta2VybmVsL3BjaS9pY2UxNzEyL2ljZTE3MjQuYwkyMDA5LTA2
LTI0IDIyOjEzOjI1LjAwMDAwMDAwMCAtMDcwMApAQCAtNTYwLDYgKzU2MCw3IEBACiAKIAljYXNl
IFNORFJWX1BDTV9UUklHR0VSX1NUQVJUOgogCWNhc2UgU05EUlZfUENNX1RSSUdHRVJfU1RPUDoK
KwljYXNlIFNORFJWX1BDTV9UUklHR0VSX1NVU1BFTkQ6CiAJCXNwaW5fbG9jaygmaWNlLT5yZWdf
bG9jayk7CiAJCW9sZCA9IGluYihJQ0VNVDE3MjQoaWNlLCBETUFfQ09OVFJPTCkpOwogCQlpZiAo
Y21kID09IFNORFJWX1BDTV9UUklHR0VSX1NUQVJUKQpAQCAtNTcwLDYgKzU3MSwxMCBAQAogCQlz
cGluX3VubG9jaygmaWNlLT5yZWdfbG9jayk7CiAJCWJyZWFrOwogCisJY2FzZSBTTkRSVl9QQ01f
VFJJR0dFUl9SRVNVTUU6CisJCS8qIGFwcHMgd2lsbCBoYXZlIHRvIHJlc3RhcnQgc3RyZWFtICov
CisJCWJyZWFrOworCiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQpAQCAtMjI3Miw3
ICsyMjc3LDcgQEAKIAltc2xlZXAoMTApOwogfQogCi1zdGF0aWMgaW50IF9fZGV2aW5pdCBzbmRf
dnQxNzI0X2NoaXBfaW5pdChzdHJ1Y3Qgc25kX2ljZTE3MTIgKmljZSkKK3N0YXRpYyBpbnQgc25k
X3Z0MTcyNF9jaGlwX2luaXQoc3RydWN0IHNuZF9pY2UxNzEyICppY2UpCiB7CiAJb3V0YihpY2Ut
PmVlcHJvbS5kYXRhW0lDRV9FRVAyX1NZU0NPTkZdLCBJQ0VSRUcxNzI0KGljZSwgU1lTX0NGRykp
OwogCW91dGIoaWNlLT5lZXByb20uZGF0YVtJQ0VfRUVQMl9BQ0xJTktdLCBJQ0VSRUcxNzI0KGlj
ZSwgQUM5N19DRkcpKTsKQEAgLTIyODcsNiArMjI5MiwxNCBAQAogCiAJb3V0YigwLCBJQ0VSRUcx
NzI0KGljZSwgUE9XRVJET1dOKSk7CiAKKwkvKiBNUFVfUlggYW5kIFRYIGlycSBtYXNrcyBhcmUg
Y2xlYXJlZCBsYXRlciBkeW5hbWljYWxseSAqLworCW91dGIoVlQxNzI0X0lSUV9NUFVfUlggfCBW
VDE3MjRfSVJRX01QVV9UWCAsIElDRVJFRzE3MjQoaWNlLCBJUlFNQVNLKSk7CisKKwkvKiBkb24n
dCBoYW5kbGUgRklGTyBvdmVycnVuL3VuZGVycnVucyAoanVzdCB5ZXQpLAorCSAqIHNpbmNlIHRo
ZXkgY2F1c2UgbWFjaGluZSBsb2NrdXBzCisJICovCisJb3V0YihWVDE3MjRfTVVMVElfRklGT19F
UlIsIElDRU1UMTcyNChpY2UsIERNQV9JTlRfTUFTSykpOworCiAJcmV0dXJuIDA7CiB9CiAKQEAg
LTI0MzEsNiArMjQ0NCw4IEBACiAJc25kX3Z0MTcyNF9wcm9jX2luaXQoaWNlKTsKIAlzeW5jaHJv
bml6ZV9pcnEocGNpLT5pcnEpOwogCisJY2FyZC0+cHJpdmF0ZV9kYXRhID0gaWNlOworCiAJZXJy
ID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwY2ksICJJQ0UxNzI0Iik7CiAJaWYgKGVyciA8IDApIHsK
IAkJa2ZyZWUoaWNlKTsKQEAgLTI0NTksMTQgKzI0NzQsNiBAQAogCQlyZXR1cm4gLUVJTzsKIAl9
CiAKLQkvKiBNUFVfUlggYW5kIFRYIGlycSBtYXNrcyBhcmUgY2xlYXJlZCBsYXRlciBkeW5hbWlj
YWxseSAqLwotCW91dGIoVlQxNzI0X0lSUV9NUFVfUlggfCBWVDE3MjRfSVJRX01QVV9UWCAsIElD
RVJFRzE3MjQoaWNlLCBJUlFNQVNLKSk7Ci0KLQkvKiBkb24ndCBoYW5kbGUgRklGTyBvdmVycnVu
L3VuZGVycnVucyAoanVzdCB5ZXQpLAotCSAqIHNpbmNlIHRoZXkgY2F1c2UgbWFjaGluZSBsb2Nr
dXBzCi0JICovCi0Jb3V0YihWVDE3MjRfTVVMVElfRklGT19FUlIsIElDRU1UMTcyNChpY2UsIERN
QV9JTlRfTUFTSykpOwotCiAJZXJyID0gc25kX2RldmljZV9uZXcoY2FyZCwgU05EUlZfREVWX0xP
V0xFVkVMLCBpY2UsICZvcHMpOwogCWlmIChlcnIgPCAwKSB7CiAJCXNuZF92dDE3MjRfZnJlZShp
Y2UpOwpAQCAtMjY1MCwxMSArMjY1Nyw5NiBAQAogCXBjaV9zZXRfZHJ2ZGF0YShwY2ksIE5VTEwp
OwogfQogCisjaWZkZWYgQ09ORklHX1BNCitzdGF0aWMgaW50IHNuZF92dDE3MjRfc3VzcGVuZChz
dHJ1Y3QgcGNpX2RldiAqcGNpLCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0IHNuZF9j
YXJkICpjYXJkID0gcGNpX2dldF9kcnZkYXRhKHBjaSk7CisJc3RydWN0IHNuZF9pY2UxNzEyICpp
Y2UgPSBjYXJkLT5wcml2YXRlX2RhdGE7CisKKwlpZiAoIWljZS0+cG1fc3VzcGVuZF9lbmFibGVk
KQorCQlyZXR1cm4gMDsKKworCXNuZF9wb3dlcl9jaGFuZ2Vfc3RhdGUoY2FyZCwgU05EUlZfQ1RM
X1BPV0VSX0QzaG90KTsKKworCXNuZF9wY21fc3VzcGVuZF9hbGwoaWNlLT5wY20pOworCXNuZF9w
Y21fc3VzcGVuZF9hbGwoaWNlLT5wY21fcHJvKTsKKwlzbmRfcGNtX3N1c3BlbmRfYWxsKGljZS0+
cGNtX2RzKTsKKwlzbmRfYWM5N19zdXNwZW5kKGljZS0+YWM5Nyk7CisKKwlzcGluX2xvY2tfaXJx
KCZpY2UtPnJlZ19sb2NrKTsKKwlpY2UtPnBtX3NhdmVkX2lzX3NwZGlmX21hc3RlciA9IGljZS0+
aXNfc3BkaWZfbWFzdGVyKGljZSk7CisJaWNlLT5wbV9zYXZlZF9zcGRpZl9jdHJsID0gaW53KElD
RU1UMTcyNChpY2UsIFNQRElGX0NUUkwpKTsKKwlpY2UtPnBtX3NhdmVkX3NwZGlmX2NmZyA9IGlu
YihJQ0VSRUcxNzI0KGljZSwgU1BESUZfQ0ZHKSk7CisJaWNlLT5wbV9zYXZlZF9yb3V0ZSA9IGlu
bChJQ0VNVDE3MjQoaWNlLCBST1VURV9QTEFZQkFDSykpOworCXNwaW5fdW5sb2NrX2lycSgmaWNl
LT5yZWdfbG9jayk7CisKKwlpZiAoaWNlLT5wbV9zdXNwZW5kKQorCQlpY2UtPnBtX3N1c3BlbmQo
aWNlKTsKKworCXBjaV9kaXNhYmxlX2RldmljZShwY2kpOworCXBjaV9zYXZlX3N0YXRlKHBjaSk7
CisJcGNpX3NldF9wb3dlcl9zdGF0ZShwY2ksIHBjaV9jaG9vc2Vfc3RhdGUocGNpLCBzdGF0ZSkp
OworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHNuZF92dDE3MjRfcmVzdW1lKHN0cnVjdCBw
Y2lfZGV2ICpwY2kpCit7CisJc3RydWN0IHNuZF9jYXJkICpjYXJkID0gcGNpX2dldF9kcnZkYXRh
KHBjaSk7CisJc3RydWN0IHNuZF9pY2UxNzEyICppY2UgPSBjYXJkLT5wcml2YXRlX2RhdGE7CisK
KwlpZiAoIWljZS0+cG1fc3VzcGVuZF9lbmFibGVkKQorCQlyZXR1cm4gMDsKKworCXBjaV9zZXRf
cG93ZXJfc3RhdGUocGNpLCBQQ0lfRDApOworCXBjaV9yZXN0b3JlX3N0YXRlKHBjaSk7CisKKwlp
ZiAocGNpX2VuYWJsZV9kZXZpY2UocGNpKSA8IDApIHsKKwkJc25kX2NhcmRfZGlzY29ubmVjdChj
YXJkKTsKKwkJcmV0dXJuIC1FSU87CisJfQorCisJcGNpX3NldF9tYXN0ZXIocGNpKTsKKworCXNu
ZF92dDE3MjRfY2hpcF9yZXNldChpY2UpOworCisJaWYgKHNuZF92dDE3MjRfY2hpcF9pbml0KGlj
ZSkgPCAwKSB7CisJCXNuZF9jYXJkX2Rpc2Nvbm5lY3QoY2FyZCk7CisJCXJldHVybiAtRUlPOwor
CX0KKworCWlmIChpY2UtPnBtX3Jlc3VtZSkKKwkJaWNlLT5wbV9yZXN1bWUoaWNlKTsKKworCWlm
IChpY2UtPnBtX3NhdmVkX2lzX3NwZGlmX21hc3RlcikgeworCQkvKiBzd2l0Y2hpbmcgdG8gZXh0
ZXJuYWwgY2xvY2sgdmlhIFNQRElGICovCisJCWljZS0+c2V0X3NwZGlmX2Nsb2NrKGljZSk7CisJ
fSBlbHNlIHsKKwkJLyogaW50ZXJuYWwgb24tY2FyZCBjbG9jayAqLworCQlzbmRfdnQxNzI0X3Nl
dF9wcm9fcmF0ZShpY2UsIGljZS0+cHJvX3JhdGVfZGVmYXVsdCwgMSk7CisJfQorCisJdXBkYXRl
X3NwZGlmX2JpdHMoaWNlLCBpY2UtPnBtX3NhdmVkX3NwZGlmX2N0cmwpOworCisJb3V0YihpY2Ut
PnBtX3NhdmVkX3NwZGlmX2NmZywgSUNFUkVHMTcyNChpY2UsIFNQRElGX0NGRykpOworCW91dGwo
aWNlLT5wbV9zYXZlZF9yb3V0ZSwgSUNFTVQxNzI0KGljZSwgUk9VVEVfUExBWUJBQ0spKTsKKwor
CWlmIChpY2UtPmFjOTcpCisJCXNuZF9hYzk3X3Jlc3VtZShpY2UtPmFjOTcpOworCisJc25kX3Bv
d2VyX2NoYW5nZV9zdGF0ZShjYXJkLCBTTkRSVl9DVExfUE9XRVJfRDApOworCXJldHVybiAwOwor
fQorI2VuZGlmCisKIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBkcml2ZXIgPSB7CiAJLm5hbWUg
PSAiSUNFMTcyNCIsCiAJLmlkX3RhYmxlID0gc25kX3Z0MTcyNF9pZHMsCiAJLnByb2JlID0gc25k
X3Z0MTcyNF9wcm9iZSwKIAkucmVtb3ZlID0gX19kZXZleGl0X3Aoc25kX3Z0MTcyNF9yZW1vdmUp
LAorI2lmZGVmIENPTkZJR19QTQorCS5zdXNwZW5kID0gc25kX3Z0MTcyNF9zdXNwZW5kLAorCS5y
ZXN1bWUgPSBzbmRfdnQxNzI0X3Jlc3VtZSwKKyNlbmRpZgogfTsKIAogc3RhdGljIGludCBfX2lu
aXQgYWxzYV9jYXJkX2ljZTE3MjRfaW5pdCh2b2lkKQpkaWZmIC11TiBhbHNhLWRyaXZlci5vcmln
L2Fsc2Eta2VybmVsL3BjaS9pY2UxNzEyL3Byb2RpZ3lfaGlmaS5jIGFsc2EtZHJpdmVyL2Fsc2Et
a2VybmVsL3BjaS9pY2UxNzEyL3Byb2RpZ3lfaGlmaS5jCi0tLSBhbHNhLWRyaXZlci5vcmlnL2Fs
c2Eta2VybmVsL3BjaS9pY2UxNzEyL3Byb2RpZ3lfaGlmaS5jCTIwMDktMDYtMjQgMTU6MDU6MDYu
MDAwMDAwMDAwIC0wNzAwCisrKyBhbHNhLWRyaXZlci9hbHNhLWtlcm5lbC9wY2kvaWNlMTcxMi9w
cm9kaWd5X2hpZmkuYwkyMDA5LTA2LTI0IDIyOjAwOjA0LjAwMDAwMDAwMCAtMDcwMApAQCAtMTA3
Nyw3ICsxMDc3LDcgQEAKIC8qCiAgKiBpbml0aWFsaXplIHRoZSBjaGlwCiAgKi8KLXN0YXRpYyBp
bnQgX19kZXZpbml0IHByb2RpZ3lfaGQyX2luaXQoc3RydWN0IHNuZF9pY2UxNzEyICppY2UpCitz
dGF0aWMgdm9pZCBhazQzOTZfaW5pdChzdHJ1Y3Qgc25kX2ljZTE3MTIgKmljZSkKIHsKIAlzdGF0
aWMgdW5zaWduZWQgc2hvcnQgYWs0Mzk2X2luaXRzW10gPSB7CiAJCUFLNDM5Nl9DVFJMMSwJICAg
MHg4NywgICAvKiBJMlMgTm9ybWFsIE1vZGUsIDI0IGJpdCAqLwpAQCAtMTA4Nyw5ICsxMDg3LDM3
IEBACiAJCUFLNDM5Nl9SQ0hfQVRULAkgMHgwMCwKIAl9OwogCi0Jc3RydWN0IHByb2RpZ3lfaGlm
aV9zcGVjICpzcGVjOwogCXVuc2lnbmVkIGludCBpOwogCisJLyogaW5pdGlhbGl6ZSBhazQzOTYg
Y29kZWMgKi8KKwkvKiByZXNldCBjb2RlYyAqLworCWFrNDM5Nl93cml0ZShpY2UsIEFLNDM5Nl9D
VFJMMSwgMHg4Nik7CisJbXNsZWVwKDEwMCk7CisJYWs0Mzk2X3dyaXRlKGljZSwgQUs0Mzk2X0NU
UkwxLCAweDg3KTsKKworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGFrNDM5Nl9pbml0cyk7
IGkgKz0gMikKKwkJYWs0Mzk2X3dyaXRlKGljZSwgYWs0Mzk2X2luaXRzW2ldLCBhazQzOTZfaW5p
dHNbaSsxXSk7Cit9CisKKyNpZmRlZiBDT05GSUdfUE0KK3N0YXRpYyBpbnQgX19kZXZpbml0IHBy
b2RpZ3lfaGQyX3Jlc3VtZShzdHJ1Y3Qgc25kX2ljZTE3MTIgKmljZSkKK3sKKwkvKiBpbml0aWFs
aXplIGFrNDM5NiBjb2RlYyBhbmQgcmVzdG9yZSBwcmV2aW91cyBtaXhlciB2b2x1bWVzICovCisJ
c3RydWN0IHByb2RpZ3lfaGlmaV9zcGVjICpzcGVjID0gaWNlLT5zcGVjOworCWludCBpOworCW11
dGV4X2xvY2soJmljZS0+Z3Bpb19tdXRleCk7CisJYWs0Mzk2X2luaXQoaWNlKTsKKwlmb3IgKGkg
PSAwOyBpIDwgMjsgaSsrKQorCQlhazQzOTZfd3JpdGUoaWNlLCBBSzQzOTZfTENIX0FUVCArIGks
IHNwZWMtPnZvbFtpXSAmIDB4ZmYpOworCW11dGV4X3VubG9jaygmaWNlLT5ncGlvX211dGV4KTsK
KwlyZXR1cm4gMDsKK30KKyNlbmRpZgorCitzdGF0aWMgaW50IF9fZGV2aW5pdCBwcm9kaWd5X2hk
Ml9pbml0KHN0cnVjdCBzbmRfaWNlMTcxMiAqaWNlKQoreworCXN0cnVjdCBwcm9kaWd5X2hpZmlf
c3BlYyAqc3BlYzsKKwogCWljZS0+dnQxNzIwID0gMDsKIAlpY2UtPnZ0MTcyNCA9IDE7CiAKQEAg
LTExMTIsMTQgKzExNDAsMTIgQEAKIAkJcmV0dXJuIC1FTk9NRU07CiAJaWNlLT5zcGVjID0gc3Bl
YzsKIAotCS8qIGluaXRpYWxpemUgYWs0Mzk2IGNvZGVjICovCi0JLyogcmVzZXQgY29kZWMgKi8K
LQlhazQzOTZfd3JpdGUoaWNlLCBBSzQzOTZfQ1RSTDEsIDB4ODYpOwotCW1zbGVlcCgxMDApOwot
CWFrNDM5Nl93cml0ZShpY2UsIEFLNDM5Nl9DVFJMMSwgMHg4Nyk7Ci0JCQkKLQlmb3IgKGkgPSAw
OyBpIDwgQVJSQVlfU0laRShhazQzOTZfaW5pdHMpOyBpICs9IDIpCi0JCWFrNDM5Nl93cml0ZShp
Y2UsIGFrNDM5Nl9pbml0c1tpXSwgYWs0Mzk2X2luaXRzW2krMV0pOworI2lmZGVmIENPTkZJR19Q
TQorCWljZS0+cG1fcmVzdW1lID0gJnByb2RpZ3lfaGQyX3Jlc3VtZTsKKwlpY2UtPnBtX3N1c3Bl
bmRfZW5hYmxlZCA9IDE7CisjZW5kaWYKKworCWFrNDM5Nl9pbml0KGljZSk7CiAKIAlyZXR1cm4g
MDsKIH0K
--0016e6476e766d3333046d2719c4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e6476e766d3333046d2719c4--
