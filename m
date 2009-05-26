From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Fixes in intel8x0.c
Date: Tue, 26 May 2009 10:09:57 +0200
Message-ID: <4A1BA3D5.2020009@insite.cz>
References: <4A1B276A.4080107@insite.cz> <s5htz385ro5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (unknown [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 421BF24672
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 10:10:00 +0200 (CEST)
In-Reply-To: <s5htz385ro5.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Tue, 26 May 2009 01:19:06 +0200,
> Pavel Hofman wrote:
>> Hi,
>>
>> while trying to dive into complexities of intel8x0.c I found the following:
>>
>> static struct snd_pci_quirk intel8x0_clock_list[] __devinitdata = {
>> 	SND_PCI_QUIRK(0x0e11, 0x008a, "AD1885", 41000),
>> 	SND_PCI_QUIRK(0x1028, 0x00be, "AD1885", 44100),
>> .....
>>
>> Is it really supposed to be 41000, instead of 44100?
> 
> Looks like so, judging from the patch Jaroslav wrote.
> 
>> In static int snd_intel8x0_pcm_open(struct snd_pcm_substream *substream,
>> struct ichdev *ichdev)
>> ...
>> 	runtime->hw.rates = ichdev->pcm->rates;
>>
>> The pcm field in ichdev is snd_ac97, while the rates field in snd_ac97
>> is defined
>>
>> unsigned int rates[6];	/* see AC97_RATES_* defines */
>>
>> I guess this way always rates[0] from the list is taken, unlike e.g. in
>> via82xx.c: runtime->hw.rates = chip->ac97->rates[AC97_RATES_SPDIF];
> 
> 41000 is the base clock.  The actual rate written is
> 
> 	rate * clock / 48000
> 
> Normally the base clock is 48000.  But some boards have a different
> base clock and the rate has to be adjusted to match with that.
> 

Takashi, thanks for your answer, 41000 is OK.

How about the second question regarding the assignment of rates field
being an array? I am remotely troubleshooting SPDIF output of Dell D600
which seems to be stuck at 48kHz (plughw always resamples to 48kHz, even
though the analog  PCM accepts 44.1kHz. The above mentioned code is
related to this (not exactly the cause though.

Thanks a lot,

Pavel.
