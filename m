From: "Avuton Olrich" <avuton@gmail.com>
Subject: USB sound card fails to resume from hibernation due to
	duplicate filename card1/WARNING: sysfs_add_ons, emits symbols
Date: Wed, 19 Mar 2008 23:39:28 -0700
Message-ID: <3aa654a40803192339i4a663729k205a462740464f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by alsa0.perex.cz (Postfix) with ESMTP id DDABE24708
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 07:39:30 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so1080382wxc.23
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 23:39:29 -0700 (PDT)
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
To: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

After suspending, the usbdisk sound card alsa driver breaks and does
not play any further. I believe this is might be due to the trace
below from the dmesg.

This definitely begins to occur between v2.6.23 and v2.6.23-rc2. I
couldn't bisect it down to a single commit.

This fails with with all kernels up to at least today's git.

Full links at the bottom.

Linux tulip 2.6.25-rc6 #6 PREEMPT Wed Mar 19 22:16:23 PDT 2008 i686
AMD Athlon(tm) XP 2700+ AuthenticAMD GNU/Linux

Gnu C                  4.2.3
Gnu make               3.81
binutils               2.18
util-linux             2.13.1
mount                  2.13.1
module-init-tools      3.4
e2fsprogs              1.40.8
xfsprogs               2.9.7
PPP                    2.4.4
Linux C Library        2.7
Dynamic linker (ldd)   2.7
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.13
Sh-utils               6.9
udev                   119
Modules Loaded         netconsole configfs snd_pcm_oss snd_mixer_oss

Relevant looking parts of the dmesg (full dmesg link below):
[ 3895.879517] usb 1-4: New USB device found, idVendor=2001, idProduct=f103
[ 3895.879517] usb 1-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 3895.879517] usb 3-1: USB disconnect, address 2
[ 3896.252863] usb 3-1: new full speed USB device using ohci_hcd and address 3
[ 3896.452987] usb 3-1: configuration #1 chosen from 1 choice
[ 3896.458877] ALSA /usr/src/linux-2.6/sound/usb/usbaudio.c:2798:
3:1:1: add audio endpoint 0x1
[ 3896.470877] ALSA /usr/src/linux-2.6/sound/usb/usbaudio.c:2798:
3:2:1: add audio endpoint 0x82
[ 3896.482878] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [13]
FU [Mic Playback Switch] ch = 1, val = 0/1/1
[ 3896.521857] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:405:
cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xd00, type
= 4, data = 0x18/0x0
[ 3896.554854] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [13]
FU [Mic Playback Volume] ch = 1, val = 0/12240/384
[ 3896.554870] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [9]
FU [Speaker Playback Switch] ch = 1, val = 0/1/1
[ 3896.593850] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:405:
cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x900, type
= 4, data = 0x18/0x0
[ 3896.608842] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [9]
FU [Speaker Playback Volume] ch = 2, val = -7264/-16/48
[ 3896.608859] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [10]
FU [Mic Capture Switch] ch = 1, val = 0/1/1
[ 3896.647835] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:405:
cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xa00, type
= 4, data = 0x18/0x0
[ 3896.680836] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [10]
FU [Mic Capture Volume] ch = 1, val = 0/6096/384
[ 3896.680849] ALSA /usr/src/linux-2.6/sound/usb/usbmixer.c:988: [10]
FU [Auto Gain Control] ch = 1, val = 0/1/1
[ 3896.680880] sysfs: duplicate filename 'card1' can not be created
[ 3896.680891] ------------[ cut here ]------------
[ 3896.680893] WARNING: at /usr/src/linux-2.6/fs/sysfs/dir.c:424
sysfs_add_one+0x82/0xa0()
[ 3896.680896] Modules linked in: netconsole configfs snd_pcm_oss snd_mixer_oss
[ 3896.680903] Pid: 174, comm: khubd Not tainted 2.6.25-rc6 #6
[ 3896.680906]  [<c011b0ef>] warn_on_slowpath+0x5f/0x90
[ 3896.680914]  [<c0115fde>] __wake_up_common+0x3e/0x70
[ 3896.680918]  [<c011b85b>] wake_up_klogd+0x3b/0x40
[ 3896.680922]  [<c017d591>] find_inode+0x31/0x60
[ 3896.680927]  [<c01a8c40>] sysfs_ilookup_test+0x0/0x10
[ 3896.680930]  [<c011c0cb>] printk+0x1b/0x20
[ 3896.680933]  [<c01a9012>] sysfs_add_one+0x82/0xa0
[ 3896.680937]  [<c01a9dfc>] sysfs_create_link+0x8c/0x100
[ 3896.680940]  [<c02f2cb4>] device_add+0x254/0x460
[ 3896.680946]  [<c02f2f58>] device_create+0x88/0xc0
[ 3896.680949]  [<c038aa06>] snd_card_register+0x276/0x380
[ 3896.680954]  [<c03b2ae9>] usb_audio_probe+0x459/0xa00
[ 3896.680959]  [<c01a8c40>] sysfs_ilookup_test+0x0/0x10
[ 3896.680963]  [<c0342c66>] usb_probe_interface+0xb6/0x140
[ 3896.680969]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.680973]  [<c02f4ba1>] driver_probe_device+0x81/0x180
[ 3896.680976]  [<c043ecc9>] klist_next+0x69/0xd0
[ 3896.680981]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.680984]  [<c02f3e76>] bus_for_each_drv+0x46/0x70
[ 3896.680988]  [<c02f4d5b>] device_attach+0x7b/0x80
[ 3896.680991]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.680994]  [<c02f3e07>] bus_attach_device+0x47/0x70
[ 3896.680997]  [<c02f2dfb>] device_add+0x39b/0x460
[ 3896.681000]  [<c0340b4d>] usb_set_configuration+0x30d/0x5d0
[ 3896.681004]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.681007]  [<c0349186>] generic_probe+0x76/0xb0
[ 3896.681012]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.681015]  [<c0342a20>] usb_probe_device+0x30/0x40
[ 3896.681018]  [<c02f4ba1>] driver_probe_device+0x81/0x180
[ 3896.681021]  [<c043ecc9>] klist_next+0x69/0xd0
[ 3896.681024]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.681027]  [<c02f3e76>] bus_for_each_drv+0x46/0x70
[ 3896.681030]  [<c02f4d5b>] device_attach+0x7b/0x80
[ 3896.681033]  [<c02f4ca0>] __device_attach+0x0/0x10
[ 3896.681036]  [<c02f3e07>] bus_attach_device+0x47/0x70
[ 3896.681039]  [<c02f2dfb>] device_add+0x39b/0x460
[ 3896.681042]  [<c033b07b>] usb_configure_device+0x5b/0x100
[ 3896.681045]  [<c033b33b>] usb_new_device+0x5b/0x180
[ 3896.681048]  [<c033c957>] hub_thread+0x637/0xd10
[ 3896.681051]  [<c012ddb0>] autoremove_wake_function+0x0/0x40
[ 3896.681058]  [<c033c320>] hub_thread+0x0/0xd10
[ 3896.681060]  [<c012da82>] kthread+0x42/0x70
[ 3896.681063]  [<c012da40>] kthread+0x0/0x70
[ 3896.681066]  [<c0104b9f>] kernel_thread_helper+0x7/0x18
[ 3896.681071]  =======================
[ 3896.681073] ---[ end trace 87ceb0cbe974168a ]---
[ 3896.689903] input: C-Media USB Headphone Set   as
/devices/pci0000:00/0000:00:02.1/usb3/3-1/3-1:1.3/input/input9
[ 3896.763158] input: USB HID v1.00 Device [C-Media USB Headphone Set
] on usb-0000:00:02.1-1
[ 3896.763218] usb 3-1: New USB device found, idVendor=0d8c, idProduct=000c
[ 3896.763221] usb 3-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[ 3896.763224] usb 3-1: Product: C-Media USB Headphone Set

/proc/modules
netconsole 8064 0 - Live 0xf88eb000
configfs 21396 2 netconsole, Live 0xf88f3000
snd_pcm_oss 45280 0 - Live 0xf88fa000
snd_mixer_oss 14784 1 snd_pcm_oss, Live 0xf88e6000

http://avuton.googlepages.com/dmesg-2.6.25-rc6-032008
http://avuton.googlepages.com/iomem-032008
http://avuton.googlepages.com/ioports-032008
http://avuton.googlepages.com/lspci-vvv-032008
http://avuton.googlepages.com/tulip-config
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
