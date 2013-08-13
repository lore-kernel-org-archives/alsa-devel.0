From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH] Add PM support to the rme96 driver
Date: Tue, 13 Aug 2013 11:02:53 +0200
Message-ID: <5209F63D.5020903@t-online.de>
References: <52090D78.70601@t-online.de> <s5h4naucat1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 130BE26517A
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 11:03:07 +0200 (CEST)
In-Reply-To: <s5h4naucat1.wl%tiwai@suse.de>
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

On 13.08.2013 09:24, Takashi Iwai wrote:
> At Mon, 12 Aug 2013 18:29:44 +0200,
> Knut Petersen wrote:
>> >From 7305b056cbb4de562018483b91cf90c677df317f Mon Sep 17 00:00:00 2001
>> From: Knut Petersen <Knut_Petersen@t-online.de>
>> Date: Mon, 12 Aug 2013 18:00:30 +0200
>> Subject: [PATCH] alsa/rme96: Add PM support to the rme96 driver
> Isn't there any other information you'd like to add?
> Put it here.

Ok, I`ll try to be a bit more verbose. Without the hardware reinitialization added,
the first use of this card anytime after a suspend / resume cycle will start with
distortions.

>   			      SNDRV_PCM_INFO_SYNC_START |
> +#ifdef CONFIG_PM
> +			      SNDRV_PCM_INFO_RESUME |
> +#endif
> No need for ifdef.

ACK.


> +static int
> +snd_rme96_suspend(struct pci_dev *pci,
> +		  pm_message_t state)
> +{
> +	struct snd_card *card = pci_get_drvdata(pci);
> +	struct rme96 *rme96 = card->private_data;
> +
> +	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
[...]
> +
> +	pci_disable_device(pci);
> +	pci_save_state(pci);
> Doesn't it go to PCI D3 state?

lspci -vv

05:04.0 Multimedia audio controller: Xilinx Corporation RME Digi96/8 Pad (rev 04)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
         Kernel driver in use: snd_rme96

This is pretty old hardware, the Digi96 series was introduced to the market in October 1998.
There is no support for any power management, and the Digi96 cards do not act as bus master.
No, the hardware will definitely not enter PCI D3 state.

>> +#ifdef CONFIG_PM
>> +	rme96->playback_suspend_buffer = kmalloc(RME96_BUFFER_SIZE, GFP_KERNEL);
>> +	if (!rme96->playback_suspend_buffer) {
>> +	snd_printk(KERN_ERR "Failed to allocate playback suspend buffer!\n");
>> +		return -ENOMEM;
>> +	}
>> +	rme96->capture_suspend_buffer = kmalloc(RME96_BUFFER_SIZE, GFP_KERNEL);
>> +	if (!rme96->capture_suspend_buffer) {
>> +		snd_printk(KERN_ERR "Failed to allocate capture suspend buffer!\n");
>> +	return -ENOMEM;
> Better to use vmalloc() for 64k buffer.
ACK

> Other than the above, please fix the coding-style issues.

ok, cu,
  knut
