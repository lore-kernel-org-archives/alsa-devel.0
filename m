From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Mon, 17 Sep 2018 23:36:56 +0900
Message-ID: <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 58E13267819
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 16:37:01 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id i26-v6so7643273pfo.12
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 07:37:01 -0700 (PDT)
In-Reply-To: <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
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

Hi,

On Sep 12 2018 16:18, Scott Bahling wrote:
>> As long as I know, the image consists of below information:
>>    - pos  0-15: control messages from physical control surface
>>    - pos 16-23: analog input level
>>    - pos 24-31: digital ADAT input level
>>    - pos 32-33: digital S/PDIF input level
>>    - pos 34-35: (not cleared yet)
>>    - pos 36-43: analog output level
>>    - pos 44-64: (not cleared yet)
>>
>> When parsing the image, a parser should generate several types of
>> events. I prefer to implementing this complicated work in user space
>> instead of kernel space. Expecially for pos 16-23/24-31/32-33/36-43, the
>> parser should always generate events to notify each of the levels.
>>
>> What we should do is to parsing the image and generate events with
>> enough consideration of task scheduling and eventing dencity. The parser
>> could be implemented as an application of ALSA sequencer.
> 
> Thanks for the details. I can work on deciphering the raw control messages.
> My current idea is to set up a netlink socket and stream the control data to
> user space just for analysis. I will look into ALSA sequencer to see if I
> can understand how that could be used.

I prepare branches in two remote repositories:
  - 
https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace 
(a384019c0f78)
  - https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace 
(a5994ec2165f)

Installing the patched driver, you can read the status and control
message in userspace by mmap(2).

Patched libhinawa produces HinawaSndTscm GObject class. This class is
also available with gobject introspection. For example with PyGobject:

```
#/usr/bin/env python3
from time import sleep
import gi
gi.require_version('Hinawa', '2.0')
from gi.repository import Hinawa
unit = Hinawa.SndTscm()
# I assume card number 1 is assigned. Take care of file permission.
unit.open('/dev/snd/hwC1D0')
unit.listen()
while (True):
   for i, frame in enumerate(unit.get_status()):
     print('{0:02d}: {1:08x}'.format(i, frame))
   sleep(0.1)
```

This code print the message to stdout, but not start packet streaming.
You need to start it by ALSA PCM/rawMIDI interfaces, like:
$ aplay -Dplughw:1,0 /dev/urandom

I notice that the branches include patches I introduced[1], with some
minor optimizations to Linux kernel v4.17 or later. The patches are
written just to satisfy investigation work and really ad-hoc ones.

> I noticed that we are able to control the LEDs from the host via the
> asynchronous link. Do you you think the faders are also controlled that way
> or would that also go via isochronous packets to the FW-1884?

The rx isochronous packets from system to the unit include no data to
control the unit[2]. If the faders are movable from system software,
it should be achieved by asynchronous transactions, like blighting
LEDs.

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094817.html
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/tascam/amdtp-tascam.c?h=for-next#n29


Thanks

Takashi Sakamoto
