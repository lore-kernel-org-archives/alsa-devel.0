From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Emu10k1x driver
Date: Wed, 12 May 2004 03:16:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A188EE.4050606@superbug.demon.co.uk>
References: <20040511.173158.16937.167326@webmail27.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040511.173158.16937.167326@webmail27.nyc.untd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

fmoraes74@netzero.net wrote:
> Here's the first pass at the driver. I've tested it mainly with XMMS with the ALSA output plugin.
> 
> alsaplayer didn't work, not sure why. I've also tested with the pcm test in alsa-lib which seems to be jumping, so that's another problem.
> 
> I've removed the joystick support for now, but the only reason I added it was because the intel8x0.c driver has joystick support in it.
> 
> Enjoy,
> 
> Francisco
> 
> 

I would like to add some information that might help people modifying 
this for the Audigy LS.

The outputs for the card work in 2 modes.
1) Probably analogue on the output jacks.
snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x70f);
snd_emu10k1x_ptr_write(chip, 0x45, 0, 0);
2) Probably digital spdif on the output jacks.
snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x1000f);
snd_emu10k1x_ptr_write(chip, 0x45, 0, 0x700);

To enable this driver loading for the Audigy LS, have the following PCI IDs.
static struct pci_device_id snd_emu10k1x_ids[] = {
   { 0x1102, 0x0006, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },  /* Dell OEM 
version (EMU10K1X) */
   { 0x1102, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },  /* Audigy LS */
   { 0, }
};


Other information: -
value = snd_emu10k1x_ptr_read(chip, 0x74, 0);
printk("Some special chip ID = %04x\n",value);


Further additions to the snd_emu10k1x_create() function, after the lines
snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x70f); // ???
snd_emu10k1x_ptr_write(chip, 0x45, 0, 0);

snd_emu10k1x_ptr_write(chip, 0x65, 0, 0x1000);
snd_emu10k1x_ptr_write(chip, 0x72, 0, 0xf0f003f);

snd_emu10k1x_ptr_write(chip, 0x71, 0, 0xf0000000);
snd_emu10k1x_ptr_write(chip, 0x61, 0, 0x0);
snd_emu10k1x_ptr_write(chip, 0x62, 0, 0x0);

The AudigyLS also seems to use the emu10k1x_ptr 0x75 a lot in interrupt 
routines, but the Dell OEM one does not.

Cheers
James




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
