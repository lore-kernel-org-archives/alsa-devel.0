From: aeleneski@comcast.net
Subject: Re: No sound for HP Pavilion DV4z
Date: Thu, 5 Feb 2009 23:45:25 +0000 (UTC)
Message-ID: <1454820534.2679141233877525082.JavaMail.root@sz0025a.westchester.pa.mail.comcast.net>
References: <s5hwsc573sz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA02.westchester.pa.mail.comcast.net
	(qmta02.westchester.pa.mail.comcast.net [76.96.62.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C64772434A
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 00:45:27 +0100 (CET)
In-Reply-To: <s5hwsc573sz.wl%tiwai@suse.de>
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

Ok, seems like I have no luck. Here were some general tests that I did and the dmesg results: 

alias snd-card-0 snd-hda-intel 
alias sound-slot-0 snd-hda-intel 
options snd-hda-intel model=hp-dv5 

[ 94.194443] hda-intel: Invalid position buffer, using LPIB read method instead. 
[ 265.860938] HDA Intel 0000:01:05.1: PCI INT B disabled 
[ 265.968343] HDA Intel 0000:00:14.2: PCI INT A disabled 
[ 266.908393] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16 
[ 266.944615] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/input/input14 
[ 267.037347] input: HDA ATI SB at 0xd2500000 irq 16 Mic at Ext Front Jack as /devices/pci0000:00/0000:00:14.2/input/input15 
[ 267.064233] input: HDA ATI SB at 0xd2500000 irq 16 HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:14.2/input/input16 
[ 267.080415] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19 
[ 267.080445] HDA Intel 0000:01:05.1: setting latency timer to 64 
[ 315.093428] hda-intel: Invalid position buffer, using LPIB read method instead. 

options snd-hda-intel model=hp-dv5 enable_msi=1 

[ 514.468839] APIC error on CPU1: 00(08) 
[ 514.468851] APIC error on CPU0: 00(08) 
[ 515.472557] ALSA /usr/src/Alsa-1.0.19/alsa-driver-1.0.19/pci/hda/hda_intel.c:621: hda_intel: No response from codec, disabling MSI: last cmd=0x000f0000 
[ 516.476554] ALSA /usr/src/Alsa-1.0.19/alsa-driver-1.0.19/pci/hda/hda_intel.c:634: hda_intel: azx_get_response timeout, switching to polling mode: last cmd=0x000f0000 

options snd-hda-intel model=hp-dv5 probe_mask=1 

[ 512.740875] HDA Intel 0000:01:05.1: PCI INT B disabled 
[ 512.853833] HDA Intel 0000:00:14.2: PCI INT A disabled 
[ 514.077692] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16 
[ 514.150312] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/input/input17 
[ 514.412696] input: HDA ATI SB at 0xd2500000 irq 16 Mic at Ext Front Jack as /devices/pci0000:00/0000:00:14.2/input/input18 
[ 514.433025] input: HDA ATI SB at 0xd2500000 irq 16 HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:14.2/input/input19 
[ 514.454995] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19 
[ 514.455153] HDA Intel 0000:01:05.1: setting latency timer to 64 





Now something weird is that when I initially changed to just model=hp-dv5, the mute light on my laptop 
went from orange to white. But no sound played. Then after the above tests failed, I started to try different models again (such as auto, laptop) and 
now that light is orange. So I changed back to just model=hp-dv5, and the light is still orange. 

Any other suggestions? 



----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de> 
To: "Andrew Eleneski" <aeleneski@comcast.net> 
Cc: alsa-devel@alsa-project.org 
Sent: Thursday, February 5, 2009 2:15:08 AM GMT -05:00 US/Canada Eastern 
Subject: Re: [alsa-devel] No sound for HP Pavilion DV4z 

At Wed, 4 Feb 2009 17:42:32 -0500, 
Andrew Eleneski wrote: 
> 
> Hi, 
> 
> I am running Kubuntu 8.10 64-bit and have no sound. Using the distribution 
> supplied Alsa version, I was at one point able to have sound through just 
> the headphone jacks, but after using this script ( 
> http://ubuntuforums.org/showthread.php?t=1046137&highlight=alsa+upgrade) and 
> trying to upgrade to the latest version 1.0.19, I have no sound at all. 
> Attached is my alsa-info.txt file to help in debugging what is wrong. 
> 
> 1. Name your Ubuntu revision: Kubuntu 8.10 64-bit 
> 2. Kernel revision: 2.6.27-11-generic 
> 3. Alsa revision: 1.0.19 
> 4. A bit of background what you've done resp. done before: 
> I have tried multitudes of values in /etc/modprobe.d/alsa-base, nothing 
> seems to work. Saw in changelog for Alsa 1.0.19 there were many changes 
> geared toward HP dvX series laptops, seems to have no effect with mine. 

Try model=hp-dv5 with the very latest alsa-driver snapshot below 
ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz 

If you have a luck, it may work. Some HP dv4 model seems to have a 
broken BIOS while some has a correct one. 


Takashi 
