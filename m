From: Eric Holstege <eric_holstege@yahoo.com>
Subject: Re: explicit commandline control of speakers vs
	headphone output
Date: Thu, 26 Aug 2010 11:40:49 -0700 (PDT)
Message-ID: <562109.6212.qm@web50708.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50708.mail.re2.yahoo.com (web50708.mail.re2.yahoo.com
	[206.190.38.106]) by alsa0.perex.cz (Postfix) with SMTP id B6C5224ABC
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 20:40:50 +0200 (CEST)
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

My specific sound HW is "nVidia Corporation MCP79 High Definition Audio 
(rev b1)"
*== lspci*:
00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio 
(rev b1)
        Subsystem: Micro-Star International Co., Ltd. Device 4570
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
        Memory at fae78000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel
*== lshal*:
udi = '/org/freedesktop/Hal/devices/pci_10de_ac0'
  info.linux.driver = '*HDA Intel*'  (string)
  info.parent = '/org/freedesktop/Hal/devices/computer'  (string)
  info.product = 'MCP79 High Definition Audio'  (string)
  info.subsystem = 'pci'  (string)
  info.udi = '/org/freedesktop/Hal/devices/pci_10de_ac0'  (string)
  info.vendor = 'nVidia Corporation'  (string)
  linux.hotplug_type = 2  (0x2)  (int)
  linux.subsystem = 'pci'  (string)
  linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:08.0'  (string)
  pci.device_class = 4  (0x4)  (int)
  pci.device_protocol = 0  (0x0)  (int)
  pci.device_subclass = 3  (0x3)  (int)
  pci.linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:08.0'  (string)
  pci.product = '*MCP79 High Definition Audio*'  (string)
  pci.product_id = 2752  (*0xac0*)  (int)
  pci.subsys_product_id = 17776  (0x4570)  (int)
  pci.subsys_vendor = 'Micro-Star International Co., Ltd.'  (string)
  pci.subsys_vendor_id = 5218  (0x1462)  (int)
  pci.vendor = 'nVidia Corporation'  (string)
  pci.vendor_id = 4318  (0x10de)  (int)

Does the hardware support this (explicit control (e.g. via a script or 
commandline) of whether the sound  is going to the speakers or to the 
headphone even when the headphone is plugged in.)

If the hardware supports it, how would I, in fact, switch via 
commandline between the two outputs?
Thanks in advance
-Eric

-----------------------

Eric Holstege wrote:
> It appears that when I have a headphone plugged in, the speakers are 
> automatically disabled and the output sound is sent to the headphone.
>
> However, I want to explicitly control (e.g. via a script or 
> commandline - not a GUI) whether the sound from an (arbitrary) 
> application is going to the speakers or to the headphone even when the 
> headphone is plugged in.
> (When I say "arbitrary application" that means I can't alter the code 
> of the application itself).
>
> Is this possible?
>
> (I have heard that ALSA mutes the speakers when it detects plugged-in 
> headphones. Is switching between them as simple as using e.g. 
> amixer(1) to unmute the speakers and mute the headphones and vice 
> versa, or is there more to it.)
>
