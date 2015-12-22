From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] sound: hda_intel: add card number to irq
	description
Date: Tue, 22 Dec 2015 19:00:14 +0100
Message-ID: <56798FAE.9070700@gmail.com>
References: <56786611.9010203@gmail.com> <s5hlh8mg82n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F05226592E
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 19:00:23 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id l126so22941117wml.1
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 10:00:23 -0800 (PST)
In-Reply-To: <s5hlh8mg82n.wl-tiwai@suse.de>
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

Am 22.12.2015 um 10:13 schrieb Takashi Iwai:
> On Mon, 21 Dec 2015 21:50:25 +0100,
> Heiner Kallweit wrote:
>>
>> Currently the info in /proc/interrupts doesn't allow to figure out which
>> interrupt belongs to which card (HDMI, PCH, ..).
>> Therefore add card details to the interrupt description.
>> With the patch the info in /proc/interrupts looks like this:
>>
>> PCI-MSI 442368-edge      snd_hda_intel:card1
>> PCI-MSI 49152-edge      snd_hda_intel:card0
>>
>> This could be partially reused for the hda_tegra driver as it also
>> uses struct azx.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Thanks for the patch.  The change here itself isn't wrong, per se.
> It's an improvement indeed.
> 
> However, I wonder whether this needs to be implemented in that way --
> namely, driver-specific way.  This problem is common in most sound
> drivers that support multiple instances.  Can we have a solution that
> can be shared more?
> 
Indeed, we could implement the extension one layer below in struct snd_card.
Then it would be more generic. I'll send a v2.

Heiner
> 
> Takashi
> 
>> ---
>>  sound/pci/hda/hda_controller.h | 2 ++
>>  sound/pci/hda/hda_intel.c      | 4 +++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
>> index ec63bbf..9c6344f 100644
>> --- a/sound/pci/hda/hda_controller.h
>> +++ b/sound/pci/hda/hda_controller.h
>> @@ -125,6 +125,8 @@ struct azx {
>>  	int num_streams;
>>  	const int *jackpoll_ms; /* per-card jack poll interval */
>>  
>> +	char irq_descr[32]; /* Interrupt description */
>> +
>>  	/* Register interaction. */
>>  	const struct hda_controller_ops *ops;
>>  
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 83800ac..ef4e06b 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -725,7 +725,7 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
>>  
>>  	if (request_irq(chip->pci->irq, azx_interrupt,
>>  			chip->msi ? 0 : IRQF_SHARED,
>> -			KBUILD_MODNAME, chip)) {
>> +			chip->irq_descr, chip)) {
>>  		dev_err(chip->card->dev,
>>  			"unable to grab IRQ %d, disabling device\n",
>>  			chip->pci->irq);
>> @@ -1605,6 +1605,8 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
>>  	check_msi(chip);
>>  	chip->dev_index = dev;
>>  	chip->jackpoll_ms = jackpoll_ms;
>> +	snprintf(chip->irq_descr, sizeof(chip->irq_descr), "%s:%s",
>> +		 KBUILD_MODNAME, dev_name(&card->card_dev));
>>  	INIT_LIST_HEAD(&chip->pcm_list);
>>  	INIT_WORK(&hda->irq_pending_work, azx_irq_pending_work);
>>  	INIT_LIST_HEAD(&hda->list);
>> -- 
>> 2.6.4
>>
>>
> 
