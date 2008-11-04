From: "matthias.nyffenegger@bluewin.ch" <matthias.nyffenegger@bluewin.ch>
Subject: Re: [PATCH 1/3] saa7146: Emagic Audiowerk8 low-level
 ALSA driver
Date: Tue, 4 Nov 2008 16:34:58 +0000 (GMT)
Message-ID: <21445894.1382781225816498426.JavaMail.webmail@ps6zhh.bluewin.ch>
Reply-To: matthias.nyffenegger@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail12.bluewin.ch (mail12.bluewin.ch [195.186.19.61])
	by alsa0.perex.cz (Postfix) with ESMTP id 23E4D24344
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 17:35:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I fixed all of your findings except for the following where i have some questions:

>> +/**
>> + *
>> + * PCI specific stuff
>> + *
>> + */
>> +
>> +/**
>> + * Organisation of EEPROM of the SAA7146A:
>> + * The data of the subsystem ID and the subsystem vendor ID is organized in
>> + * the EEPROM in the following order:
>> + *
>> + * EE-Addr Value Configuration Space Addr.
>> + * ---------------------------------------------------------------------
>> + * 00 Subsys ID (high byte) 2C, bits: 31 - 24
>> + * 01 Subsys ID (low byte) 2C, bits: 23 - 16
>> + * 02 Subsys Vendor ID (high byte) 2C, bits: 15 -  8
>> + * 03 Subsys Vendor ID (low byte) 2C, bits:  7 -  0
>> + * 04 Max_Lat 3C, bits: 31 - 24
>> + * 05 Min_Gnt 3C, bits: 23 - 16
>> + *
>> + * For AW8 Subsys ID and Subsys Vendor ID are 0xFF on my card.
>> + * For AW2 Subsys ID and Subsys Vendor ID are 0x00 on my card.
>> + */
>> +
>> +static struct pci_device_id snd_aw_ids[] = {
>> + { PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA7146,
>> +   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
>
>We have a bad problem here.
>As mentioned, there are other drivers with the very same device
>and the very same PCI ID.
>Since your driver doesn't check the availability of the hardware
>in some way at probe, it loads even for a video device.
>The same problem is present in the existing snd-aw2 driver, and we
>need to find out the solution.

Obviously the Audiowerk Soundcards cannot reliably be recognized by simply looking
at the Subsystem-IDs because they're not unique values.

I can see a chance here to probe i2c-bus for onboard EEPROM (AW2 and AW8) and/or
onboard PLL (AW8) but I'm not sure whether or not this actually solves the problem for
good.

Another approach I see is that e.g. SuSE YaST supports loading a module for a specific
pci slot - I don't know whether or not this is common use in other distros as well.

How do you think about it?



>> +enum states {disabled, enabled};
>
>Ditto.  This should be really a bool.

I used to have more than these two states here and might add new states again in the future:
that is why I would rather go for the enum type here.

Regards,

Matthias
