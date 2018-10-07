From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Sun, 7 Oct 2018 23:11:11 +0900
Message-ID: <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 54D3026783D
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2018 16:11:16 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id f18-v6so6694529pgv.3
 for <alsa-devel@alsa-project.org>; Sun, 07 Oct 2018 07:11:15 -0700 (PDT)
In-Reply-To: <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sbahling@suse.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On Oct 2 2018 12:16, Takashi Sakamoto wrote:
> I have an idea to invervene them:
> 
> 1. For control events, in kernel land, driver module detects
> changes of set of bitflags for physical controls, then queue
> events to tell the change to userspace applications
> (e.g. poll(2)). The queued events include information about
> changed bitflags (e.g. a shape of u32 data). Userspace
> applications execute read(2) then get the bitflags, then parse
> it and emit userspace event by ports in ALSA sequencer
> subsystem.
> The driver and userspace application should pay enough
> attention to share the queue. The driver can drop the oldest
> queued events if the queue is full.
> 
> 2. For level meter, in kernel land, driver module caches the
> recent value. Userspace applications execute ioctl(2) with
> unique command (You can see this kind of commands in
> 'include/uapi/sound/firwire.h').

I prepare two remote branch as 'topic/tascam-userspace-take2' for kernel
driver[1] and libhinawa[2].

The patches for kernel driver adds two features below to firewire-tascam 
module:
  - SNDRV_FIREWIRE_IOCTL_TASCAM_STATUS ioctl command
  - 'struct snd_firewire_event_tascam_ctl' event notification

The patches for libhinawa adds two features below for g-i modules:
  - hinawa_snd_tscm_get_status() method
  - 'control' GObject signal

For example[3]:

```
$ cat test.py
#!/usr/bin/env python3

from sys import exit
from time import sleep

import gi
gi.require_version('Hinawa', '2.0')
from gi.repository import Hinawa

unit = Hinawa.SndTscm()
unit.open('/dev/snd/hwC2D0')
unit.listen()

req = Hinawa.FwReq()

def handle_control(self, index, flags):
     print('{0:02d}: {1:08x}'.format(index, flags))
     # data = bytearray(4)
     # You can check the flags and bright LED with proper values
     # in the data array.
     # print(req.write(self, 0xffff00000404, data))

unit.connect('control', handle_control)

while (True):
   msgs = unit.get_status()
   for i in range(len(msgs) // 2):
       left = i
       right = i + len(msgs) // 2
       print('{0:02d}: {1:08x}, {2:02d}: {3:08x}'.format(left, 
msgs[left], right, msgs[right]))
   sleep(0.1)
```

When running any scripts with your local build of libhinawa,
it's useful to set LD_LIBRARY_PATH/GI_TYPELIB_PATH properly.

```
$ export 
LD_LIBRARY_PATH="/home/username/git/libhinawa/build/src:${LD_LIBRARY_PATH}"
$ export 
GI_TYPELIB_PATH="/home/username/git/libhinawa/build/src:${GI_TYPELIB_PATH}"
$ ./sample.py
...
```

When starting packet streaming and operating control surface, you can
see dump with index and bitflags additionally to status dump.

```
...
06: fffeffff
06: ffffffff
06: feffffff
...
```

As I told, kernel driver emits events corresponding to quadlet 05-15.
If there's insufficiency, please inform it to me. If all things look
well, I'll submit patches for next merge window but .

[1] 
https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace-take2
[2] https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace-take2
[3] https://gist.github.com/takaswie/669fd4254c7b9fd631762fc61ac931f5


Thanks

Takashi Sakamoto
