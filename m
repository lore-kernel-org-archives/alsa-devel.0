From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Wed, 03 Oct 2018 22:37:11 +0200
Message-ID: <4e0b4dc88db65ddd3055f3266af509fd439472c5.camel@suse.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F2D012677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 22:37:13 +0200 (CEST)
In-Reply-To: <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
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

On Tue, 2018-10-02 at 12:16 +0900, Takashi Sakamoto wrote:
> Hi Scott,
> 

...

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
> 
> However, as long as I note[2], the purpose of some quadlets in the
> image are not still identified:
> 
> "Quadlet 00-15 show control messages. Quadlet 16-23 show analog input
> level. Quadlet 24-31 shows digital ADAT input level. Quadlet 32-33
> shows digital S/PDIF input level. Quadlet 34-35 is unknown.

On my FW-1884 34/35 is analog level of output 1/2. The "Monitor" level
pot (as well as the master fader if enabled) control the level so if
they are set at 0, then you will not see any signal on the 34/35.

> Quadlet
> 36-43 shows analog output level.

36-41 = analog outputs 3-8

> The other quadlets are unknown."

52: shows the current sample rate setting
    010101xx = 44.1k
    020102xx = 48k
    810181xx = 88.2k
    820182xx = 96k

52: Byte 1 shows the current clock source
    0x01 = Internal
    0x02 = Word Clock
    0x03 = Digital In
    0x04 = ADAT

54-55 appears to be the level of the internal "Monitor Mix".
57-58 appears to be the level of the stereo mix of the analog inputs

59: Byte 1 indicates what is routed to the Monitor Mix
    0x01 = PCM Stream from computer
    0x02 = Analog Inputs
    0x03 = Both

> We need further investigation to clear the unknown fields as much as
> possible to add more codes in ALSA kernel land.

Above is as far as I have gotten with the unknown fields.

On the asynchronous side, I have mapped out the LED codes to the LEDs
on the FW-1884 and discovered the registers for controlling the faders.

-Scott
