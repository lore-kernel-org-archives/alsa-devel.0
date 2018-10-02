From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Tue, 2 Oct 2018 12:16:08 +0900
Message-ID: <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3792A2676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 05:16:20 +0200 (CEST)
In-Reply-To: <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
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

On Sep 29 2018 00:28, Scott Bahling wrote:
> On Fri, 2018-09-28 at 12:44 +0900, Takashi Sakamoto wrote:
> Are you still thinking to try to make mmap the solution to pass the
> control data to userspace, or do we need to find another method in the
> long run?

The latter is better.

The patchset to map page frame for status and control image is just for
our work to investigate. Practically, it includes several issues:

1. Due to scheduling granularity of user processes against interval to
update the image, applications in the processes can fail to pick up
events on the image.

2. Recently, bare embedded board with ARM cores becomes pupular. Some
of them have PCIe buses. It's better for users to use units on
IEEE 1394 bus, however ARM is known as cache incoherent architecture.
In the architecture, page frame mapping can bring unexpected results.
(See a conditional macro[1].)

For these reasons, we need to find another solution based on
synchronous procedure such like read(2)/ioctl(2). For this direction,
we need to care several items:

1. The status and control image includes several types of data;
bitflags for physical controls of device surface, level meters
and so on. Although it's acceptable to fail picking up values for
level meters, it's not for physical controls.

2. TASCAM FireWire series includes below models and the layout of
bitflags differs depending on them:
  - FW-1884
  - FW-1804
  - FW-1082
(FE-8 has not been investigated yet.)
It cost expensive to handle such differences by kernel land in
development/maintenance POV.

3. In current implementation of ALSA firewire-tascam driver,
demultiplexing of OHCI 1394 isochronous packet runs on
software IRQ context. Total time of software IRQ context is
shared in system wide, thus it's better to reduce load as
much as possible even if software IRQ run on schedulable tasks
(threadedirq).

I have an idea to invervene them:

1. For control events, in kernel land, driver module detects
changes of set of bitflags for physical controls, then queue
events to tell the change to userspace applications
(e.g. poll(2)). The queued events include information about
changed bitflags (e.g. a shape of u32 data). Userspace
applications execute read(2) then get the bitflags, then parse
it and emit userspace event by ports in ALSA sequencer
subsystem.
The driver and userspace application should pay enough
attention to share the queue. The driver can drop the oldest
queued events if the queue is full.

2. For level meter, in kernel land, driver module caches the
recent value. Userspace applications execute ioctl(2) with
unique command (You can see this kind of commands in
'include/uapi/sound/firwire.h').

However, as long as I note[2], the purpose of some quadlets in the
image are not still identified:

"Quadlet 00-15 show control messages. Quadlet 16-23 show analog input
level. Quadlet 24-31 shows digital ADAT input level. Quadlet 32-33
shows digital S/PDIF input level. Quadlet 34-35 is unknown. Quadlet
36-43 shows analog output level. The other quadlets are unknown."

We need further investigation to clear the unknown fields as much as
possible to add more codes in ALSA kernel land.

[1] 
https://github.com/takaswie/snd-firewire-improve/blob/topic/tascam-userspace/sound/firewire/tascam/tascam-hwdep.c#L192
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094817.html


Thanks

Takashi Sakamoto
