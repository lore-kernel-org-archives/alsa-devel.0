From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 25/33] ALSA: oxygen: Simplify PM callbacks
Date: Fri, 09 Jan 2015 17:24:28 +0100
Message-ID: <54B000BC.3010802@ladisch.de>
References: <1420818796-30852-1-git-send-email-tiwai@suse.de>
 <1420818796-30852-26-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7E4AF26061A
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 17:24:31 +0100 (CET)
In-Reply-To: <1420818796-30852-26-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> This is a similar cleanup like the commit [3db084fd0af5: ALSA: fm801:
> PCI core handles power state for us].
>
> Since pci_set_power_state(), pci_save_state() and pci_restore_state()
> are already done in the PCI core side, so we don't need to it doubly.
>
> Also, pci_enable_device(), pci_disable_device() and pci_set_master()
> calls in PM callbacks are superfluous nowadays, too, so get rid of
> them as well.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/pci/oxygen/oxygen_lib.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
> index b67e30602473..366723cf6d7a 100644
> --- a/sound/pci/oxygen/oxygen_lib.c
> +++ b/sound/pci/oxygen/oxygen_lib.c
> @@ -728,7 +728,6 @@ EXPORT_SYMBOL(oxygen_pci_remove);
>  #ifdef CONFIG_PM_SLEEP
>  static int oxygen_pci_suspend(struct device *dev)
>  {
> -	struct pci_dev *pci = to_pci_dev(dev);
>  	struct snd_card *card = dev_get_drvdata(dev);
>  	struct oxygen *chip = card->private_data;
>  	unsigned int i, saved_interrupt_mask;
> @@ -753,10 +752,6 @@ static int oxygen_pci_suspend(struct device *dev)
>  	flush_work(&chip->spdif_input_bits_work);
>  	flush_work(&chip->gpio_work);
>  	chip->interrupt_mask = saved_interrupt_mask;
> -
> -	pci_disable_device(pci);
> -	pci_save_state(pci);
> -	pci_set_power_state(pci, PCI_D3hot);
>  	return 0;
>  }
>
> @@ -788,20 +783,10 @@ static void oxygen_restore_ac97(struct oxygen *chip, unsigned int codec)
>
>  static int oxygen_pci_resume(struct device *dev)
>  {
> -	struct pci_dev *pci = to_pci_dev(dev);
>  	struct snd_card *card = dev_get_drvdata(dev);
>  	struct oxygen *chip = card->private_data;
>  	unsigned int i;
>
> -	pci_set_power_state(pci, PCI_D0);
> -	pci_restore_state(pci);
> -	if (pci_enable_device(pci) < 0) {
> -		dev_err(dev, "cannot reenable device");
> -		snd_card_disconnect(card);
> -		return -EIO;
> -	}
> -	pci_set_master(pci);
> -
>  	oxygen_write16(chip, OXYGEN_DMA_STATUS, 0);
>  	oxygen_write16(chip, OXYGEN_INTERRUPT_MASK, 0);
>  	for (i = 0; i < OXYGEN_IO_SIZE; ++i)
