From: aeleneski@comcast.net
Subject: Re: No sound for HP Pavilion DV4z
Date: Mon, 9 Feb 2009 17:18:59 +0000 (UTC)
Message-ID: <917076326.3840021234199939792.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
References: <188698462.3091871233960154280.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA03.westchester.pa.mail.comcast.net
	(qmta03.westchester.pa.mail.comcast.net [76.96.62.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E9111037F9
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 18:19:00 +0100 (CET)
In-Reply-To: <188698462.3091871233960154280.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
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



Thanks for your time and all these suggestions. Still no luck though. 


Seems like you might not be able to have two files ending in alsa-base in 
the /etc/modprobe.d/ folder. That was the reason for the orange speaker indicator. I had 
alsa-base and backup-alsa-base, for some reason it was grabbing the settings 
from the backup. 

Anyway, with probe only, orange sound indicator, when doing aplay -l I get 

**** List of PLAYBACK Hardware Devices **** 
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI] 
Subdevices: 1/1 
Subdevice #0: subdevice #0 

Attached are the requested logs. 
I tried using the hda-verb command you supplied, the only difference is 
that upon restarting after setting the command, I noticed the speakers crack, but still no sound. 
Not really sure what I should be looking for here. 



----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de> 
To: aeleneski@comcast.net 
Cc: alsa-devel@alsa-project.org 
Sent: Friday, February 6, 2009 3:11:01 AM GMT -05:00 US/Canada Eastern 
Subject: Re: [alsa-devel] No sound for HP Pavilion DV4z 

At Thu, 5 Feb 2009 23:45:25 +0000 (UTC), 
aeleneski@comcast.net wrote: 
> 
> Ok, seems like I have no luck. Here were some general tests that I did and the 
> dmesg results: 
> 
> alias snd-card-0 snd-hda-intel 
> alias sound-slot-0 snd-hda-intel 
> options snd-hda-intel model=hp-dv5 
> 
> [ 94.194443] hda-intel: Invalid position buffer, using LPIB read method 
> [ 265.860938] HDA Intel 0000:01:05.1: PCI INT B disabled 
> [ 265.968343] HDA Intel 0000:00:14.2: PCI INT A disabled 
> [ 266.908393] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 
> 16 
> [ 266.944615] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/ 
> input/input14 
> [ 267.037347] input: HDA ATI SB at 0xd2500000 irq 16 Mic at Ext Front Jack as 
> /devices/pci0000:00/0000:00:14.2/input/input15 
> [ 267.064233] input: HDA ATI SB at 0xd2500000 irq 16 HP Out at Ext Front Jack 
> as /devices/pci0000:00/0000:00:14.2/input/input16 
> [ 267.080415] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 
> 19 
> [ 267.080445] HDA Intel 0000:01:05.1: setting latency timer to 64 
> [ 315.093428] hda-intel: Invalid position buffer, using LPIB read method 
> instead. 

This isn't too bad, but... 

> options snd-hda-intel model=hp-dv5 enable_msi=1 
> 
> [ 514.468839] APIC error on CPU1: 00(08) 
> [ 514.468851] APIC error on CPU0: 00(08) 
> [ 515.472557] ALSA /usr/src/Alsa-1.0.19/alsa-driver-1.0.19/pci/hda/ 
> hda_intel.c:621: hda_intel: No response from codec, disabling MSI: last cmd= 
> 0x000f0000 
> [ 516.476554] ALSA /usr/src/Alsa-1.0.19/alsa-driver-1.0.19/pci/hda/ 
> hda_intel.c:634: hda_intel: azx_get_response timeout, switching to polling 
> mode: last cmd=0x000f0000 

This seems more serious. 

> options snd-hda-intel model=hp-dv5 probe_mask=1 
> 
> [ 512.740875] HDA Intel 0000:01:05.1: PCI INT B disabled 
> [ 512.853833] HDA Intel 0000:00:14.2: PCI INT A disabled 
> [ 514.077692] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 
> 16 
> [ 514.150312] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/ 
> input/input17 
> [ 514.412696] input: HDA ATI SB at 0xd2500000 irq 16 Mic at Ext Front Jack as 
> /devices/pci0000:00/0000:00:14.2/input/input18 
> [ 514.433025] input: HDA ATI SB at 0xd2500000 irq 16 HP Out at Ext Front Jack 
> as /devices/pci0000:00/0000:00:14.2/input/input19 
> [ 514.454995] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 
> 19 
> [ 514.455153] HDA Intel 0000:01:05.1: setting latency timer to 64 

And this is better. 
So, obviously the problem looks like the communication with the 
secondary codec. 

> Now something weird is that when I initially changed to just model=hp-dv5, the 
> mute light on my laptop 
> went from orange to white. But no sound played. Then after the above tests 
> failed, I started to try different models again (such as auto, laptop) and 
> now that light is orange. So I changed back to just model=hp-dv5, and the 
> light is still orange. 
> 
> Any other suggestions? 

OK, first try to load the module with probe_only=1 option. 
Reboot once after setting this model to restore the original BIOS 
setup. Then run alsa-info.sh --no-upload, and attach the generated 
file. If you get errors, try to get /proc/asound/card0/codec#* files, 
at least. 

Then set model=hp-dv5, reboot and get alsa-info output, too. 

Also, make sure to use the very latest alsa-driver snapshot, 
ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz 
Check the changelogs in alsa-driver*/HEAD and alsa-driver*/alsa-kernel/HEAD 
files. 

The problem could be the invalid BIOS pin setup. 
In that case, you can try to change the pin control manually via 
hda-verb program, such as, 

hda-verb /dev/snd/hwC0D0 0x0d SET_PIN_WID 0x40 

See Documentation/sound/alsa/HD-Audio.txt in the recent kernel 
(found in alsa-driver snapshot, too). 


thanks, 

Takashi 
