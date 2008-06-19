From: randall <lists_rlr@roadrunner.com>
Subject: note on Suse 10.3 build
Date: Thu, 19 Jun 2008 15:02:35 -0700
Message-ID: <200806191502.36138.lists_rlr@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta13.adelphia.net (mta13.mail.adelphia.net [68.168.78.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A9DB2449C
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 00:02:39 +0200 (CEST)
Received: from [192.168.1.100] (really [76.176.117.148]) by mta13.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
	id <20080619220102.FHTS7723.mta13.adelphia.net@[192.168.1.100]>
	for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2008 18:01:02 -0400
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

To all:

Had to rebuild the Suse 10.3 kernel again to get back the NVidia MCP61 
(RealTek ALC662) on board sound.  Turned on two SND parameters in the kernel 
config file:

CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y

and enabled a module:

CONFIG_SND_SOC=m

The kernal is 2.6.22.18-0.2 x86_64 architecture.

The sound file under /etc/modprobe.d is

------------------- snip ----------------------
options snd-hda-intel enable=1 index=0 model=3stack-6ch-dig position_fix=1

# CvwD.9hpqWdunz16:MCP61 High Definition Audio
alias snd-card-0 snd-hda-intel
------------- end snippet -------------------

and the 3stack 6 channel SPIF digital setting for the model type works for the 
NVidia MCP61 setup.

There were NO changes to the modprobe.conf file.

Not sure why the kernel has to be rebuilt to restore the onboard sound, any 
ideas?  The 3 changes are the only ones I've made, when running menuconfig.

Motherboard is Elite Computer Systems (ECS) GF6100-M754 with NVidia 
GeForce6100/nForce 405 running the AMD Athlon 64 3200+ processor.

and hwinfo --sound

18: PCI 05.0: 0403 Audio device
  [Created at pci.301]
  UDI: /org/freedesktop/Hal/devices/pci_10de_3f0
  Unique ID: CvwD.9hpqWdunz16
  SysFS ID: /devices/pci0000:00/0000:00:05.0
  SysFS BusID: 0000:00:05.0
  Hardware Class: sound
  Model: "Elitegroup MCP61 High Definition Audio"
  Vendor: pci 0x10de "nVidia Corporation"
  Device: pci 0x03f0 "MCP61 High Definition Audio"
  SubVendor: pci 0x1019 "Elitegroup Computer Systems"
  SubDevice: pci 0x2151
  Revision: 0xa2
  Driver: "HDA Intel"
  Driver Modules: "snd_hda_intel"
  Memory Range: 0xfe028000-0xfe02bfff (rw,non-prefetchable)
  IRQ: 22 (7841 events)
  Module Alias: "pci:v000010DEd000003F0sv00001019sd00002151bc04sc03i00"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Config Status: cfg=no, avail=yes, need=no, active=unknown

Again, any ideas as to why the kernel has to be regenerated to enable on-board 
sound?

- Randall
