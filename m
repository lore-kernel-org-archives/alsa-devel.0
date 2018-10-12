From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Fri, 12 Oct 2018 10:12:47 +0200
Message-ID: <246b8baaa3c415a0accdb76d3b524dec5e0429f9.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
 <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
 <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C88267875
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 10:12:47 +0200 (CEST)
In-Reply-To: <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Sun, 2018-10-07 at 23:11 +0900, Takashi Sakamoto wrote:
> Hi Scott,
> 
> On Oct 2 2018 12:16, Takashi Sakamoto wrote:
> > I have an idea to invervene them:
> > 
> > 1. For control events, in kernel land, driver module detects
> > changes of set of bitflags for physical controls, then queue
> > events to tell the change to userspace applications
> > (e.g. poll(2)). The queued events include information about
> > changed bitflags (e.g. a shape of u32 data). Userspace
> > applications execute read(2) then get the bitflags, then parse
> > it and emit userspace event by ports in ALSA sequencer
> > subsystem.
> > The driver and userspace application should pay enough
> > attention to share the queue. The driver can drop the oldest
> > queued events if the queue is full.
> > 
> > 2. For level meter, in kernel land, driver module caches the
> > recent value. Userspace applications execute ioctl(2) with
> > unique command (You can see this kind of commands in
> > 'include/uapi/sound/firwire.h').
> 
> I prepare two remote branch as 'topic/tascam-userspace-take2' for
> kernel
> driver[1] and libhinawa[2].
> 
> The patches for kernel driver adds two features below to firewire-tascam 
> module:
>   - SNDRV_FIREWIRE_IOCTL_TASCAM_STATUS ioctl command
>   - 'struct snd_firewire_event_tascam_ctl' event notification
> 
> The patches for libhinawa adds two features below for g-i modules:
>   - hinawa_snd_tscm_get_status() method
>   - 'control' GObject signal
> 
> For example[3]:
> 
> ```
> $ cat test.py
> #!/usr/bin/env python3
> 
> from sys import exit
> from time import sleep
> 
> import gi
> gi.require_version('Hinawa', '2.0')
> from gi.repository import Hinawa
> 
> unit = Hinawa.SndTscm()
> unit.open('/dev/snd/hwC2D0')
> unit.listen()
> 
> req = Hinawa.FwReq()
> 
> def handle_control(self, index, flags):
>      print('{0:02d}: {1:08x}'.format(index, flags))
>      # data = bytearray(4)
>      # You can check the flags and bright LED with proper values
>      # in the data array.
>      # print(req.write(self, 0xffff00000404, data))
> 
> unit.connect('control', handle_control)
> 
> while (True):
>    msgs = unit.get_status()
>    for i in range(len(msgs) // 2):
>        left = i
>        right = i + len(msgs) // 2
>        print('{0:02d}: {1:08x}, {2:02d}: {3:08x}'.format(left, 
> msgs[left], right, msgs[right]))
>    sleep(0.1)
> ```
> 
> When running any scripts with your local build of libhinawa,
> it's useful to set LD_LIBRARY_PATH/GI_TYPELIB_PATH properly.
> 
> ```
> $ export 
> LD_LIBRARY_PATH="/home/username/git/libhinawa/build/src:${LD_LIBRARY_PATH}"
> $ export 
> GI_TYPELIB_PATH="/home/username/git/libhinawa/build/src:${GI_TYPELIB_PATH}"
> $ ./sample.py
> ...
> ```
> 
> When starting packet streaming and operating control surface, you can
> see dump with index and bitflags additionally to status dump.
> 
> ```
> ...
> 06: fffeffff
> 06: ffffffff
> 06: feffffff
> ...
> ```
> 
> As I told, kernel driver emits events corresponding to quadlet 05-15.
> If there's insufficiency, please inform it to me. If all things look
> well, I'll submit patches for next merge window but .


I have tested the branches and it works well. I was able to create
daemon in python to interface the FW-1884 with Ardour via the OSC
protocol. That's working reliably.

I had to enable quadlets 00-04 since they contain the fader control
values. I masked out the solo control values in the same way as the
monitor control values since they continuously fluctuate in the same
way.

diff -Nrup a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
--- a/sound/firewire/tascam/amdtp-tascam.c	2018-10-09 09:49:54.693197299 +0200
+++ b/sound/firewire/tascam/amdtp-tascam.c	2018-10-11 10:55:14.865475143 +0200
@@ -130,8 +130,10 @@ static void read_status_messages(struct
 		index = be32_to_cpu(buffer[0]) % SNDRV_FIREWIRE_TASCAM_STATUS_COUNT;
 		quad = buffer[s->data_block_quadlets - 1];
 
-		if (index >= 5 && index <= 15) {
-			if (index == 5)
+		if (index <= 15) {
+			if (index == 4)
+				mask = 0xffff0000;
+			else if (index == 5)
 				mask = 0x0000ffff;
 			else
 				mask = 0xffffffff;


While testing, noticed that the encoder bits on quadlet 06 do not get
updated reliably if the encoder knob is moved quickly. The transitions
on those bits happen quickly and some of the bit state changes get
lost. I switched to using the absolute encoder values on quadlets 10-15 
which works reliably.

Thanks!

Scott
