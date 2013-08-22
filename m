From: Tommi Uimonen <tee.uimonen@gmail.com>
Subject: Re: ice1712 suspend/resume for M-Audio Audiophile 2496
Date: Thu, 22 Aug 2013 13:11:22 +0300
Message-ID: <CA+Z4o-oX04YwhSA_AwVvH+oR+6G1X8X9AwarUUYDAOD_Ak78fA@mail.gmail.com>
References: <CA+Z4o-rKcFYAcq_ug8gpt80bMiJn71bbHkzXz1cjbj2tsHtbOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 81C0A2654BD
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 12:11:23 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id bv4so209062qab.1
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 03:11:22 -0700 (PDT)
In-Reply-To: <CA+Z4o-rKcFYAcq_ug8gpt80bMiJn71bbHkzXz1cjbj2tsHtbOQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello. I tried implementing suspend for ice1712, and at least it now
calls snd_ice1712_suspend during suspend, but I have no idea what data
I should send to the card to make it suspend properly.

static int snd_ice1712_suspend(struct pci_dev *pci, pm_message_t state)
{
        struct snd_card *card = pci_get_drvdata(pci);
        struct snd_ice1712 *ice = card->private_data;
        //      printk(KERN_INFO "snd_ice1712_suspend starts\n");

        if (!ice->pm_suspend_enabled)
          {
            printk(KERN_INFO "snd_ice1712_suspend disabled\n");
                return 0;
          }

        snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
        snd_pcm_suspend_all(ice->pcm);
        snd_pcm_suspend_all(ice->pcm_pro);
        snd_pcm_suspend_all(ice->pcm_ds);
        snd_ac97_suspend(ice->ac97);

        spin_lock_irq(&ice->reg_lock);
        //      ice->pm_saved_is_spdif_master = ice->is_spdif_master(ice);
        //      ice->pm_saved_spdif_ctrl = inw(ICEMT(ice, SPDIF_CTRL));
        //      ice->pm_saved_spdif_cfg = inb(ICEREG(ice, SPDIF_CFG));
        ice->pm_saved_route = inl(ICEMT(ice, MONITOR_ROUTECTRL));
        spin_unlock_irq(&ice->reg_lock);

        if (ice->pm_suspend)
                ice->pm_suspend(ice);

        pci_disable_device(pci);
        pci_save_state(pci);
        pci_set_power_state(pci, pci_choose_state(pci, state));
        return 0;
}


ice->pm_suspend(ice) seems to hang the whole system. Commenting it out
makes system usable, but no sound after resume (rmmod & modprobe cycle
needed)

Does the card even support suspending properly? Am I wasting my time
here and should I just add 'fuser -k /dev/snd && rmmod' to the suspend
script and modprobe to the resume (ugly workaround that does not fix
the real problem)

Tommi


2013/7/13 Tommi Uimonen <tee.uimonen@gmail.com>:
> Hello, the lack of suspend/resume support for ice1712 driver has been
> bugging me a lot, and I was wondering if it's possible to implement it
> by following how it's done in 1724.c?
>
> I don't really know much about the driver, but after some comparison
> between 1712.c and 1724.c it seems doable.
>
> At least the suspend part seems straightforward, just changing
> ICEMT1724 with ICEMT and ICEREG1724 with ICEREG. To resume, I should
> add some new functions like snd_ice1712_chip_reset (I guess it follows
> the same logic as in 1724.c, just use ICE1712_RESET instead) and maybe
> some spdif stuff but I think the 1724 has different spdif options. I
> don't have any 1724 cards so can't be sure, but 1712 does not have
> spdif rate. Maybe it will work without those, at least for me since I
> don't use spdif.
>
> And then add this to the pci_driver ice1712_driver struct:
>
> .driver = {
> .pm = SND_ICE1712_PM_OPS,
> }
>
> and define the SIMPLE_DEV_PM_OPS accordingly.
>
> Or is this already under work by someone?
>
> Tommi
