From: Andrei Boros <andrei@srr.ro>
Subject: Re: snd-opti92x-ad1848
Date: Thu, 16 Oct 2003 09:48:02 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8E3F22.1C9A8096@srr.ro>
References: <3F8D1C5A.4A1FDD11@srr.ro>
		<s5had82kdpn.wl@alsa2.suse.de>
		<3F8D29F7.77623812@srr.ro> <s5h4qyakb24.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 
> unload all ALSA (and isapnp, pnp) modules before the following.
> 
> it must be the old isapnp module which wasn't unloaded.
> 
I checked that no sound related modules are loaded. 
I removed snd*.o from the /lib/modules...
I did make install, depmod -a

My /etc/modules.conf reads : 
alias char-major-116            snd
options snd                     cards_limit=2
alias snd-card-0                snd-cs46xx
alias snd-card-1                snd-opti92x-ad1848
options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
irq=5 dma1=0 fm_port=0x388 mpu_port=0x300 mpu_irq=7

(i also have a hercules fortissimo 2, the cs46xx which works fine)

So now I am sure no sound related modules are loaded.
modprobe snd-opti92x-ad1848 says 
/lib/modules/2.2.24/misc/snd-opti92x-ad1848.o: unresolved symbol
isapnp_resource_change_R09b965af
snd: Device or resource busy

I see that snd-isapnp is not loaded

Again, I unload _all_ modules.
I do modprobe snd-isapnp by hand
dmesg

isapnp: Card 'OPTi Audio 16'
isapnp: 1 Plug & Play card detected total

below is the contents of /proc/isapnp

gate:~# modprobe snd-opti92x-ad1848
/lib/modules/2.2.24/misc/snd-opti92x-ad1848.o: init_module: Device or
resource busy
snd: Device or resource busy

I take a look at the /proc/isapnp and I see that the device did not get
enabled

At this point I am out of ideas...






Card 1 'OPT0924:OPTi Audio 16' PnP version 1.0
  Logical device 0 'OPT0000:Pro Audio 16'
    Device is not active
    Active port 0x220
    Resources 0
      Priority preferred
      Port 0x220-0x240, align 0x1f, size 0x10, 10-bit address decoding
      Port 0x130-0x3f0, align 0x3, size 0x8, 10-bit address decoding
    Resources 1
      Priority acceptable
      Port 0x380-0x380, align 0xf, size 0xc, 10-bit address decoding
      IRQ 5,7,10 High-Edge
      DMA 0,1,3 8-bit compatible
      Alternate resources 1:1
        Priority acceptable
        Port 0x380-0x3f0, align 0xf, size 0xc, 10-bit address decoding
        IRQ 5,7,2/9,10,11 High-Edge
        DMA 0,1,3 8-bit compatible
        DMA 0,1,3 8-bit compatible
  Logical device 1 'OPT0001:Game Port'
    Compatible device PNPb02f
    Device is not active
    Resources 0
      Priority acceptable
      Port 0x201-0x201, align 0x0, size 0x1, 10-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x100-0x3f0, align 0xf, size 0x2, 10-bit address decoding
  Logical device 2 'OPT0002:MPU401'
    Device is not active
    Active port 0x300
    Active IRQ 9 [0x2]
    Resources 0
      Priority preferred
      Port 0x300-0x330, align 0xf, size 0x2, 10-bit address decoding
      IRQ 5,7,2/9,10 High-Edge
  Logical device 3 'OPT0003:CD'
    Compatible device PNP0600
    Device is active
    Active port 0x376,0x170
    Active IRQ 15 [0x2]
    Resources 0
      Priority preferred
      IRQ 15 High-Edge
    Resources 1
      Priority acceptable
      Port 0x376-0x376, align 0xf, size 0x2, 10-bit address decoding
      Port 0x170-0x170, align 0xf, size 0x8, 10-bit address decoding
      Alternate resources 1:1
        Priority acceptable
        Port 0x376-0x3f6, align 0xf, size 0x2, 10-bit address decoding
        Port 0x170-0x3f0, align 0xf, size 0x8, 10-bit address decoding
  Logical device 4 'OPT0004:Modem'
    Compatible device PNP0500
    Device is not active
    Resources 0
      Priority preferred
      IRQ 3,4,5,7,2/9,10,11 High-Edge
    Resources 1
      Priority acceptable
      Port 0x2e8-0x2f8, align 0xf, size 0x8, 10-bit address decoding
      Alternate resources 1:1
        Priority acceptable
        Port 0x3e8-0x3f8, align 0xf, size 0x8, 10-bit address decoding
      Alternate resources 1:2
        Priority acceptable
        Port 0x100-0x3f0, align 0xf, size 0x8, 10-bit address decoding
  Logical device 5 'OPT0005:OPT924'
    Device is not active
    Active port 0x30d
    Resources 0
      Priority preferred
      Port 0x30d-0x3ed, align 0x1f, size 0x9, 10-bit address decoding
    Resources 1
      Priority acceptable
      IRQ 5,10,11 High-Edge




-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
