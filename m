From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Two USB audio devices, kobject_add failed
Date: Thu, 28 Dec 2006 09:43:18 -0500
Message-ID: <9e4733910612280643n451430fah79c87a37f8473f55__36826.5883801088$1167317014$gmane$org@mail.gmail.com>
References: <9e4733910612200834g14804e44xafb5b0f434e87ba4@mail.gmail.com>
	<20061221092355.75207a9f.zaitcev@redhat.com>
	<s5h64c5rv3a.wl%tiwai@suse.de>
	<9e4733910612211021y710be6m8c012a6d50775ad8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9F8A1295
	for <alsa-devel@alsa-project.org>; Thu, 28 Dec 2006 15:43:19 +0100 (MET)
Received: by nz-out-0506.google.com with SMTP id l8so1407101nzf
	for <alsa-devel@alsa-project.org>; Thu, 28 Dec 2006 06:43:18 -0800 (PST)
In-Reply-To: <9e4733910612211021y710be6m8c012a6d50775ad8@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pete Zaitcev <zaitcev@redhat.com>, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 12/21/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 12/21/06, Takashi Iwai <tiwai@suse.de> wrote:
> > At Thu, 21 Dec 2006 09:23:55 -0800,
> > Pete Zaitcev wrote:
> > >
> > > On Wed, 20 Dec 2006 11:34:48 -0500, "Jon Smirl" <jonsmirl@gmail.com> wrote:
> > >
> > > Adding list to cc:
> > >
> > > > My new WebCam is a USB audio device and so is my sound system, PSC805.
> > > > When I boot sound doesn't initially work. If I unplug the PSC805 and
> > > > plug it back in again I get this. I don't get this using  only one
> > > > device at a time.
> > > >
> > > > [  176.243298] usb 2-2: configuration #1 chosen from 1 choice
> > > > [  176.298092] kobject_add failed for card1 with -EEXIST, don't try to register things with the same name in the same directory.
> > > > [  176.298125]  [<c01e690f>] kobject_add+0x10f/0x190
> > > > [  176.298156]  [<c023d1b7>] device_add+0xb7/0x530
> > > > [  176.298177]  [<c01e65df>] kobject_get+0xf/0x20
> > > > [  176.298184]  [<c01e69eb>] kobject_init+0x2b/0x40
> > > > [  176.298201]  [<c023d6c8>] device_create+0x88/0xc0
> > > > [  176.298220]  [<f8a21b87>] snd_card_register+0x2b7/0x320 [snd]
> > > > [  176.298253]  [<f8867c74>] usb_driver_claim_interface+0x84/0xb0 [usbcore]
> > >
> > > Jon, sorry for the finger-pointing, but you better take it up with ALSA
> > > people. It seems that snd_usb_audio_create calls snd_card_new incorrectly,
> > > but I have no idea what the constrains on the ID are, so I won't try to
> > > make a patch here.
> >
> > Is it 2.6.20 kernel?
>
> 2.6.20 patched with the ehci patches from mm. But it happens without
> the mm patches too.
>
> >
> > How is the status of /sys/class/sound before and after unplugging a
> > device?
>
> Plugged-in at boot:
>
> jonsmirl@jonsmirl:/sys/class/sound$ ls
> audio   card0  controlC0  dsp   mixer   pcmC0D0c  pcmC1D0p
> audio1  card1  controlC1  dsp1  mixer1  pcmC1D0c  timer
> jonsmirl@jonsmirl:/sys/class/sound$ cat /proc/asound/cards
>  0 [Camera         ]: USB-Audio - USB Camera
>                       OmniVision Technologies, Inc. USB Camera at
> usb-0000:00:1d.1-1, full speed
>  1 [U0x4710x155    ]: USB-Audio - USB Device 0x471:0x155
>                       USB Device 0x471:0x155 at usb-0000:00:1d.7-4.4, full speed
> jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound
> Camera  card0  card1  cards  devices  hwdep  modules  oss  pcm  seq
> timers  U0x4710x155  version
> jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound/card1
> id  oss_mixer  pcm0c  pcm0p  stream0  usbbus  usbid
> jonsmirl@jonsmirl:/sys/class/sound$
>
>
> [U0x4710x155    ] is not normal, for some reason it didn't get the
> device name on this boot. Could be because I did a long fsck at boot.
>
> Unplug it:
> jonsmirl@jonsmirl:/sys/class/sound$ ls
> audio  card0  card1  controlC0  dsp  mixer  pcmC0D0c  timer
> jonsmirl@jonsmirl:/sys/class/sound$ cat /proc/asound/cards
>  0 [Camera         ]: USB-Audio - USB Camera
>                       OmniVision Technologies, Inc. USB Camera at
> usb-0000:00:1d.1-1, full speed
> jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound
> Camera  card0  cards  devices  hwdep  modules  oss  pcm  seq  timers  version
> jonsmirl@jonsmirl:/sys/class/sound$
>
> No error in dmesg yet
> Plug it back in
> error is in dmesg
>
> jonsmirl@jonsmirl:/sys/class/sound$ ls
> audio   card0  controlC0  dsp   mixer   pcmC0D0c  pcmC1D0p
> audio1  card1  controlC1  dsp1  mixer1  pcmC1D0c  timer
> jonsmirl@jonsmirl:/sys/class/sound$ cat /proc/asound/cards
>  0 [Camera         ]: USB-Audio - USB Camera
>                       OmniVision Technologies, Inc. USB Camera at
> usb-0000:00:1d.1-1, full speed
>  1 [PSC805         ]: USB-Audio - Philips PSC805
>                       Philips Electronics Philips PSC805 at
> usb-0000:00:1d.7-4.4, full speed
> jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound/card1
> id  oss_mixer  pcm0c  pcm0p  stream0  usbbus  usbid
> jonsmirl@jonsmirl:/sys/class/sound$
>

Full contents of kernel log entry:

Something has stopped working between usb_audio and ALSA. When I boot
my USB audio won't work, but if I remove it and plug it in again it
works. I posted this on usb-dev and alsa-dev but everyone is gone.

The error occurs when the device is plugged in a again.

usb 2-1: new full speed USB device using uhci_hcd and address 3
usb 2-1: configuration #1 chosen from 1 choice
ALSA sound/usb/usbaudio.c:2739: 3:1:1: add audio endpoint 0x1
ALSA sound/usb/usbaudio.c:2739: 3:2:1: add audio endpoint 0x82
ALSA sound/usb/usbmixer.c:989: [2] FU [PCM Playback Switch] ch = 1, val = 0/1/1
ALSA sound/usb/usbmixer.c:989: [2] FU [PCM Playback Volume] ch = 6,
val = 0/32512/127
ALSA sound/usb/usbmixer.c:989: [5] FU [PCM Capture Switch] ch = 1, val = 0/1/1
ALSA sound/usb/usbmixer.c:989: [5] FU [PCM Capture Volume] ch = 2, val
= 0/6144/768
kobject_add failed for card0 with -EEXIST, don't try to register
things with the same name in the same directory.
 [<c01be26f>] kobject_add+0x10f/0x190
 [<c020b0c7>] device_add+0xb7/0x530
 [<c01bdf3f>] kobject_get+0xf/0x20
 [<c01be34b>] kobject_init+0x2b/0x40
 [<c020b5d8>] device_create+0x88/0xc0
 [<f8a6cc47>] snd_card_register+0x2e7/0x3c0 [snd]
 [<f8865c74>] usb_driver_claim_interface+0x84/0xb0 [usbcore]
 [<f8a875bc>] usb_audio_probe+0x5dc/0xa30 [snd_usb_audio]
 [<c01257e7>] try_to_del_timer_sync+0x47/0x50
 [<f8865b06>] usb_probe_interface+0x96/0xe0 [usbcore]
 [<c020d204>] really_probe+0x54/0x140
 [<c020d339>] driver_probe_device+0x49/0xc0
 [<c02af7e3>] klist_next+0x53/0xa0
 [<c020c614>] bus_for_each_drv+0x44/0x70
 [<c020d44a>] device_attach+0x7a/0x80
 [<c020d3b0>] __device_attach+0x0/0x10
 [<c020c556>] bus_attach_device+0x26/0x60
 [<c020b465>] device_add+0x455/0x530
 [<f8863e71>] usb_set_configuration+0x3f1/0x4d0 [usbcore]
 [<f886b867>] generic_probe+0x157/0x210 [usbcore]
 [<f8865753>] usb_probe_device+0x33/0x40 [usbcore]
 [<c020d204>] really_probe+0x54/0x140
 [<c020d339>] driver_probe_device+0x49/0xc0
 [<c02af7e3>] klist_next+0x53/0xa0
 [<c020c614>] bus_for_each_drv+0x44/0x70
 [<c020d44a>] device_attach+0x7a/0x80
 [<c020d3b0>] __device_attach+0x0/0x10
 [<c020c556>] bus_attach_device+0x26/0x60
 [<c020b465>] device_add+0x455/0x530
 [<f885f422>] __usb_new_device+0x92/0x120 [usbcore]
 [<f88607db>] hub_thread+0x74b/0xc10 [usbcore]
 [<c012f530>] autoremove_wake_function+0x0/0x50
 [<f8860090>] hub_thread+0x0/0xc10 [usbcore]
 [<c012f37a>] kthread+0xba/0xf0
 [<c012f2c0>] kthread+0x0/0xf0
 [<c0103cab>] kernel_thread_helper+0x7/0x1c
 =======================
input: Philips Electronics Philips PSC805 as /class/input/input6
input,hiddev96: USB HID v1.00 Device [Philips Electronics Philips
PSC805] on usb-0000:00:1d.1-1
ALSA sound/usb/usbaudio.c:1317: setting usb interface 1:1
ALSA sound/usb/usbaudio.c:1317: setting usb interface 1:1





>
> >
> >
> > Takashi
> >
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
