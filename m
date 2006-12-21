From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Two USB audio devices, kobject_add failed
Date: Thu, 21 Dec 2006 13:21:48 -0500
Message-ID: <9e4733910612211021y710be6m8c012a6d50775ad8__36329.3817652904$1166725349$gmane$org@mail.gmail.com>
References: <9e4733910612200834g14804e44xafb5b0f434e87ba4@mail.gmail.com>
	<20061221092355.75207a9f.zaitcev@redhat.com>
	<s5h64c5rv3a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7D8CE264
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2006 19:21:49 +0100 (MET)
Received: by py-out-1112.google.com with SMTP id a25so1566857pyi
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2006 10:21:48 -0800 (PST)
In-Reply-To: <s5h64c5rv3a.wl%tiwai@suse.de>
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

On 12/21/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 21 Dec 2006 09:23:55 -0800,
> Pete Zaitcev wrote:
> >
> > On Wed, 20 Dec 2006 11:34:48 -0500, "Jon Smirl" <jonsmirl@gmail.com> wrote:
> >
> > Adding list to cc:
> >
> > > My new WebCam is a USB audio device and so is my sound system, PSC805.
> > > When I boot sound doesn't initially work. If I unplug the PSC805 and
> > > plug it back in again I get this. I don't get this using  only one
> > > device at a time.
> > >
> > > [  176.243298] usb 2-2: configuration #1 chosen from 1 choice
> > > [  176.298092] kobject_add failed for card1 with -EEXIST, don't try to register things with the same name in the same directory.
> > > [  176.298125]  [<c01e690f>] kobject_add+0x10f/0x190
> > > [  176.298156]  [<c023d1b7>] device_add+0xb7/0x530
> > > [  176.298177]  [<c01e65df>] kobject_get+0xf/0x20
> > > [  176.298184]  [<c01e69eb>] kobject_init+0x2b/0x40
> > > [  176.298201]  [<c023d6c8>] device_create+0x88/0xc0
> > > [  176.298220]  [<f8a21b87>] snd_card_register+0x2b7/0x320 [snd]
> > > [  176.298253]  [<f8867c74>] usb_driver_claim_interface+0x84/0xb0 [usbcore]
> >
> > Jon, sorry for the finger-pointing, but you better take it up with ALSA
> > people. It seems that snd_usb_audio_create calls snd_card_new incorrectly,
> > but I have no idea what the constrains on the ID are, so I won't try to
> > make a patch here.
>
> Is it 2.6.20 kernel?

2.6.20 patched with the ehci patches from mm. But it happens without
the mm patches too.

>
> How is the status of /sys/class/sound before and after unplugging a
> device?

Plugged-in at boot:

jonsmirl@jonsmirl:/sys/class/sound$ ls
audio   card0  controlC0  dsp   mixer   pcmC0D0c  pcmC1D0p
audio1  card1  controlC1  dsp1  mixer1  pcmC1D0c  timer
jonsmirl@jonsmirl:/sys/class/sound$ cat /proc/asound/cards
 0 [Camera         ]: USB-Audio - USB Camera
                      OmniVision Technologies, Inc. USB Camera at
usb-0000:00:1d.1-1, full speed
 1 [U0x4710x155    ]: USB-Audio - USB Device 0x471:0x155
                      USB Device 0x471:0x155 at usb-0000:00:1d.7-4.4, full speed
jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound
Camera  card0  card1  cards  devices  hwdep  modules  oss  pcm  seq
timers  U0x4710x155  version
jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound/card1
id  oss_mixer  pcm0c  pcm0p  stream0  usbbus  usbid
jonsmirl@jonsmirl:/sys/class/sound$


[U0x4710x155    ] is not normal, for some reason it didn't get the
device name on this boot. Could be because I did a long fsck at boot.

Unplug it:
jonsmirl@jonsmirl:/sys/class/sound$ ls
audio  card0  card1  controlC0  dsp  mixer  pcmC0D0c  timer
jonsmirl@jonsmirl:/sys/class/sound$ cat /proc/asound/cards
 0 [Camera         ]: USB-Audio - USB Camera
                      OmniVision Technologies, Inc. USB Camera at
usb-0000:00:1d.1-1, full speed
jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound
Camera  card0  cards  devices  hwdep  modules  oss  pcm  seq  timers  version
jonsmirl@jonsmirl:/sys/class/sound$

No error in dmesg yet
Plug it back in
error is in dmesg

jonsmirl@jonsmirl:/sys/class/sound$ ls
audio   card0  controlC0  dsp   mixer   pcmC0D0c  pcmC1D0p
audio1  card1  controlC1  dsp1  mixer1  pcmC1D0c  timer
jonsmirl@jonsmirl:/sys/class/sound$ cat /proc/asound/cards
 0 [Camera         ]: USB-Audio - USB Camera
                      OmniVision Technologies, Inc. USB Camera at
usb-0000:00:1d.1-1, full speed
 1 [PSC805         ]: USB-Audio - Philips PSC805
                      Philips Electronics Philips PSC805 at
usb-0000:00:1d.7-4.4, full speed
jonsmirl@jonsmirl:/sys/class/sound$ ls /proc/asound/card1
id  oss_mixer  pcm0c  pcm0p  stream0  usbbus  usbid
jonsmirl@jonsmirl:/sys/class/sound$


>
>
> Takashi
>


-- 
Jon Smirl
jonsmirl@gmail.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
