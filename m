From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Emu10k1x driver
Date: Fri, 14 May 2004 18:14:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A4FE87.2030001@superbug.demon.co.uk>
References: <20040511.173158.16937.167326@webmail27.nyc.untd.com>	<40A188EE.4050606@superbug.demon.co.uk> <s5hwu3fkkww.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwu3fkkww.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 12 May 2004 03:16:14 +0100,
> James Courtier-Dutton wrote:
> 
>>fmoraes74@netzero.net wrote:
>>
>>>Here's the first pass at the driver. I've tested it mainly with XMMS with the ALSA output plugin.
>>>
>>>alsaplayer didn't work, not sure why. I've also tested with the pcm test in alsa-lib which seems to be jumping, so that's another problem.
>>>
>>>I've removed the joystick support for now, but the only reason I added it was because the intel8x0.c driver has joystick support in it.
>>>
>>>Enjoy,
>>>
>>>Francisco
>>>
>>>
>>
>>I would like to add some information that might help people modifying 
>>this for the Audigy LS.
>>
>>The outputs for the card work in 2 modes.
>>1) Probably analogue on the output jacks.
>>snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x70f);
>>snd_emu10k1x_ptr_write(chip, 0x45, 0, 0);
> 
> 
> it's already in emu10k1x.c.
> 
> 
>>2) Probably digital spdif on the output jacks.
>>snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x1000f);
>>snd_emu10k1x_ptr_write(chip, 0x45, 0, 0x700);
> 
> 
> it's not.

Those (1) and (2) should work on bother the LS and the Dell OEM.
> 
> 
>>To enable this driver loading for the Audigy LS, have the following PCI IDs.
>>static struct pci_device_id snd_emu10k1x_ids[] = {
>>   { 0x1102, 0x0006, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },  /* Dell OEM 
>>version (EMU10K1X) */
>>   { 0x1102, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },  /* Audigy LS */
>>   { 0, }
>>};
> 
> 
> so, just adding the pci id for audigy LS would suffice at least for
> analog output?

I don't think so, because of all the extra code that will be needed in 
the interrupt routines.

> 
> 
>>Other information: -
>>value = snd_emu10k1x_ptr_read(chip, 0x74, 0);
>>printk("Some special chip ID = %04x\n",value);
> 
> 
> what value on Dell OEM?

I don't know. Might be worth trying it on the Audigy 2 as well.

> 
> 
>>Further additions to the snd_emu10k1x_create() function, after the lines
>>snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x70f); // ???
>>snd_emu10k1x_ptr_write(chip, 0x45, 0, 0);
> 
> 
> hmm...
> 
> 
>>snd_emu10k1x_ptr_write(chip, 0x65, 0, 0x1000);
>>snd_emu10k1x_ptr_write(chip, 0x72, 0, 0xf0f003f);
> 
> 
> routing?
> 
> 
>>snd_emu10k1x_ptr_write(chip, 0x71, 0, 0xf0000000);
>>snd_emu10k1x_ptr_write(chip, 0x61, 0, 0x0);
>>snd_emu10k1x_ptr_write(chip, 0x62, 0, 0x0);
>>
>>The AudigyLS also seems to use the emu10k1x_ptr 0x75 a lot in interrupt 
>>routines, but the Dell OEM one does not.
> 
> 
> what value is supposed to be on 0x75?

I have no idea. But some trial and error with some actual hardware 
should help.

> 
> 
> Takashi
> 
> 

Takashi,

I am waiting for someone to donate an Audigy LS to me. I will then be 
able to build a driver for it.
It seems that the Audigy LS is quite a lot different from the Dell OEM, 
so I will probably create a new .c file for it.
Maybe at a later stage, when everything works well, we might decide to 
join the two drivers.

Also, if we get the Audigy LS working, it might shed some light on the 
P16 or P17 chip details in the Audigy 2.
For features like high sample rates etc.

I have had one offer so far for an Audigy LS, so, if it arrives, I will 
start work on it.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
