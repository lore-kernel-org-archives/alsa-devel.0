From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 10:09:09 +0200
Message-ID: <4E54B1A5.5080507@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>	<4E53A748.4070404@amlie.name>	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>	<4E53AAE4.2070303@amlie.name>
	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy9.bluehost.com (oproxy9.bluehost.com [69.89.24.6])
	by alsa0.perex.cz (Postfix) with SMTP id BB238248E4
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 10:09:36 +0200 (CEST)
In-Reply-To: <CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 08/23/11 15:44, Daniel Mack wrote:
> On Tue, Aug 23, 2011 at 3:28 PM, Kristian Amlie <kristian@amlie.name> wrote:
>> On 08/23/11 15:16, Daniel Mack wrote:
>>> On Tue, Aug 23, 2011 at 3:12 PM, Kristian Amlie <kristian@amlie.name> wrote:
>>>> Here is the output from one complete run of cu, including connecting,
>>>> pressing a key once on the instrument and killing cu afterwards:
>>> ...
>>> And now once again without killing cu, please. I'm interested in the
>>> last commands that occur before the device starts working.
>>
>> Here you go:
>>
>> [21535.096008] change_speed(): urb_value: 16696, urb_index: 0
>> [21535.097918] update_mctrl(): urb_value: 771, priv->interface: 0
>> [21535.099917] change_speed(): urb_value: 49230, urb_index: 0
>> [21535.103055] change_speed(): urb_value: 49230, urb_index: 0
>> [21535.106037] change_speed(): urb_value: 49230, urb_index: 0
> 
> Ok, then let's try the attached patch. In case it doesn't work, you
> might need to check whether there are any more ctrl requests sent by
> the fdti_sio driver that need to be added to the MIDI driver as well.

That resulted in the following oops:

-------
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<          (null)>]           (null)
PGD 0
Oops: 0010 [#1] SMP
CPU 0
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi freq_table
mperf ipv6 snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_pcm_oss snd_mixer_oss usbhid dm_mod snd_hda_codec_idt arc4 iwl4965
snd_hda_intel iwl_legacy snd_hda_codec ehci_hcd mac80211 snd_hwdep
snd_pcm firmware_class i2c_i801 cfg80211 video processor snd_timer
backlight i2c_core uhci_hcd thermal snd rfkill usbcore sky2 thermal_sys
dcdbas snd_page_alloc ac joydev button pcspkr battery sg rtc

Pid: 1042, comm: khubd Not tainted 3.0.0 #3 Dell Inc. XPS M1530
              /
RIP: 0010:[<0000000000000000>]  [<          (null)>]           (null)
RSP: 0018:ffff8801188df918  EFLAGS: 00010283
RAX: 000000000000000c RBX: ffff8801188df960 RCX: ffffffffa021edc0
RDX: ffffffffa0224a80 RSI: ffff88011982c600 RDI: ffff880118058900
RBP: ffff8801188df920 R08: 000000000000000c R09: ffff88011b3ff47f
R10: 000000000000000c R11: ffff8801188df870 R12: ffff880118058900
R13: 0000000000000000 R14: ffff880118a0f800 R15: ffffffffa021edc0
FS:  0000000000000000(0000) GS:ffff88011fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000001645000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process khubd (pid: 1042, threadinfo ffff8801188de000, task
ffff88011f7633a0)
Stack:
 ffffffffa021a823 ffff8801188df9b0 ffffffffa0216983 ffff88011f7055a0
 ffff880118058a80 ffff880118a0f888 ffff88011982c600 00000000ffffffff
 ffff880119b22d88 3a33303430425355 ffffff0038643862 ffff88011982c600
Call Trace:
 [<ffffffffa021a823>] ? snd_usb_create_quirk+0x20/0x22 [snd_usb_audio]
 [<ffffffffa0216983>] usb_audio_probe+0x56f/0x6e8 [snd_usb_audio]
 [<ffffffffa0079da0>] usb_probe_interface+0xcb/0x115 [usbcore]
 [<ffffffff8133e2ea>] driver_probe_device+0xa3/0x151
 [<ffffffff8133e413>] ? __driver_attach+0x7b/0x7b
 [<ffffffff8133e446>] __device_attach+0x33/0x3c
 [<ffffffff8133d866>] bus_for_each_drv+0x51/0x88
 [<ffffffff8133e4d7>] device_attach+0x64/0x7c
 [<ffffffff8133d6a4>] bus_probe_device+0x22/0x39
 [<ffffffff8133c661>] device_add+0x41c/0x58f
 [<ffffffff81343002>] ? device_pm_init+0x3c/0x6e
 [<ffffffffa0079239>] usb_set_configuration+0x4a5/0x4f7 [usbcore]
 [<ffffffffa007fcc2>] generic_probe+0x4a/0x78 [usbcore]
 [<ffffffffa0079459>] usb_probe_device+0x15/0x17 [usbcore]
 [<ffffffff8133e2ea>] driver_probe_device+0xa3/0x151
 [<ffffffff8133e413>] ? __driver_attach+0x7b/0x7b
 [<ffffffff8133e446>] __device_attach+0x33/0x3c
 [<ffffffff8133d866>] bus_for_each_drv+0x51/0x88
 [<ffffffff8133e4d7>] device_attach+0x64/0x7c
 [<ffffffff8133d6a4>] bus_probe_device+0x22/0x39
 [<ffffffff8133c661>] device_add+0x41c/0x58f
 [<ffffffffa0072bbf>] usb_new_device+0x74/0xb7 [usbcore]
 [<ffffffffa007437f>] hub_thread+0xcf8/0x11e5 [usbcore]
 [<ffffffff8147341d>] ? schedule+0x7c8/0x861
 [<ffffffff810491f2>] ? wake_up_bit+0x23/0x23
 [<ffffffffa0073687>] ? hub_probe+0x72e/0x72e [usbcore]
 [<ffffffff81048de7>] kthread+0x81/0x89
 [<ffffffff81476954>] kernel_thread_helper+0x4/0x10
 [<ffffffff81048d66>] ? kthread_worker_fn+0x145/0x145
 [<ffffffff81476950>] ? gs_change+0xb/0xb
Code:  Bad RIP value.
RIP  [<          (null)>]           (null)
 RSP <ffff8801188df918>
CR2: 0000000000000000
---[ end trace 69eca745138acea4 ]---
-------

-- 
Kristian
