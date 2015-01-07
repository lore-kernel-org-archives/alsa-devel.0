From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ALSA: fm801: PCI core handles power state
	for us
Date: Wed, 7 Jan 2015 12:35:10 +0200
Message-ID: <CAHp75VcQrnhCQCWVG6V7dVmR4Um8wOLVCV1R6M0b53UEHq1VRg@mail.gmail.com>
References: <1420576755-23570-1-git-send-email-andy.shevchenko@gmail.com>
 <s5hbnmbdqrs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com
 [209.85.160.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F85F26040D
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 11:35:11 +0100 (CET)
Received: by mail-yk0-f173.google.com with SMTP id 19so467956ykq.18
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 02:35:10 -0800 (PST)
In-Reply-To: <s5hbnmbdqrs.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 7, 2015 at 8:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue,  6 Jan 2015 22:39:15 +0200,
> Andy Shevchenko wrote:
>>
>> There is no need to duplicate the work that is already done in the PCI
>> driver core. The patch removes excerpts from suspend and resume
>> callbacks.
>>
>> While here amend a definition of the snd_fm801_pm. The PM core has the
>> stubs for non-PM_SLEEP cases, thus we can always define the variable.
>
> But this will result in a waste of bytes, no?  It's not a big deal,
> but still...

We can leave it under #ifdef, the main purpose of the patch to remove
duplicate PM work.

>
> above all, I couldn't find the code enabling/disabling pci device in
> the default pci pm handlers.  pci_pm_default_resume_early() powers up
> and restore the state.  These can be removed indeed.  But
> pci_pm_restore() calls pci_pm_reenable_device() only as a fallback.
> So it looks to me like the restore callback still needs to enable the
> device explicitly.
>
> Am I missing anything obvious...?

The suspend_noirq is called at the end of the suspend process. It gets
device to the lower power state. I think this was implemented by
46939f8b15e44f065d052e89ea4f2adc81fdc740.

There is a really nice documentation in dev_pm_ops description (linux/pm.h).

>
> In anyway, there are lots of similar codes in sound/pci/*, and I
> prefer patching all them at once.  Of course the patches can be split
> if it's better.

Better to do this driver-by-driver. But I don't care about other sound
drivers right now.

>
>
> thanks,
>
> Takashi
>
>> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>  sound/pci/fm801.c | 22 ++--------------------
>>  1 file changed, 2 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
>> index 9a2122f..dcda3c1 100644
>> --- a/sound/pci/fm801.c
>> +++ b/sound/pci/fm801.c
>> @@ -1384,7 +1384,6 @@ static unsigned char saved_regs[] = {
>>
>>  static int snd_fm801_suspend(struct device *dev)
>>  {
>> -     struct pci_dev *pci = to_pci_dev(dev);
>>       struct snd_card *card = dev_get_drvdata(dev);
>>       struct fm801 *chip = card->private_data;
>>       int i;
>> @@ -1396,29 +1395,15 @@ static int snd_fm801_suspend(struct device *dev)
>>       for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
>>               chip->saved_regs[i] = inw(chip->port + saved_regs[i]);
>>       /* FIXME: tea575x suspend */
>> -
>> -     pci_disable_device(pci);
>> -     pci_save_state(pci);
>> -     pci_set_power_state(pci, PCI_D3hot);
>>       return 0;
>>  }
>>
>>  static int snd_fm801_resume(struct device *dev)
>>  {
>> -     struct pci_dev *pci = to_pci_dev(dev);
>>       struct snd_card *card = dev_get_drvdata(dev);
>>       struct fm801 *chip = card->private_data;
>>       int i;
>>
>> -     pci_set_power_state(pci, PCI_D0);
>> -     pci_restore_state(pci);
>> -     if (pci_enable_device(pci) < 0) {
>> -             dev_err(dev, "pci_enable_device failed, disabling device\n");
>> -             snd_card_disconnect(card);
>> -             return -EIO;
>> -     }
>> -     pci_set_master(pci);
>> -
>>       snd_fm801_chip_init(chip, 1);
>>       snd_ac97_resume(chip->ac97);
>>       snd_ac97_resume(chip->ac97_sec);
>> @@ -1428,12 +1413,9 @@ static int snd_fm801_resume(struct device *dev)
>>       snd_power_change_state(card, SNDRV_CTL_POWER_D0);
>>       return 0;
>>  }
>> +#endif /* CONFIG_PM_SLEEP */
>>
>>  static SIMPLE_DEV_PM_OPS(snd_fm801_pm, snd_fm801_suspend, snd_fm801_resume);
>> -#define SND_FM801_PM_OPS     &snd_fm801_pm
>> -#else
>> -#define SND_FM801_PM_OPS     NULL
>> -#endif /* CONFIG_PM_SLEEP */
>>
>>  static struct pci_driver fm801_driver = {
>>       .name = KBUILD_MODNAME,
>> @@ -1441,7 +1423,7 @@ static struct pci_driver fm801_driver = {
>>       .probe = snd_card_fm801_probe,
>>       .remove = snd_card_fm801_remove,
>>       .driver = {
>> -             .pm = SND_FM801_PM_OPS,
>> +             .pm = &snd_fm801_pm,
>>       },
>>  };
>>
>> --
>> 1.8.3.101.g727a46b
>>



-- 
With Best Regards,
Andy Shevchenko
