From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Fri, 20 Mar 2015 07:46:20 +0900
Message-ID: <550B51BC.80506@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id E750226067F
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 23:46:24 +0100 (CET)
In-Reply-To: <550AD65F.10803@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Damien Zammit <damien.zammit@gmail.com>
List-Id: alsa-devel@alsa-project.org

Robin and Damien,

On Mar 19 2015 22:59, Robin Gareus wrote:
> On 03/18/2015 02:06 AM, Takashi Sakamoto wrote:
>> Please explain the importance, especially the reason to include the
>> selector into kernel code instead of userspace application.
> 
> Can one access the device from userspace while the kernel is using it to
> stream audio or midi ("Device or resource busy") ?

I can't understand what character devices you mention about. If you
mention about ALSA PCM character devices (usually
/dev/snd/pcmC%uD%d[p|c]), it's yes. In fact, one ALSA application can
use ALSA PCM character device for one direction (playback/capture). So
the access by any other applications causes -EBUSY. (here, I ignore
alsa-lib's PCM direct mixing layer.)

But, when you utilize kernel control functionality, the character device
is not PCM one, it's Control one (/dev/snd/controlC%u).

By the way, we can program any userspace application via FireWire
character device (/dev/fw*). Actually, I utilize firewire-request in
Linux FireWire utilities (former known as jujuutils), and write my own
I/O library, libhinawa.

Linux FireWire utilities
https://github.com/cladisch/linux-firewire-utils

libhinawa
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/086969.html

For example, to control the clock selector of Digi 002/003 family, we
just execute this command with firewire-request.

$ ./firewire-request /dev/fw1 write 0xffffe0000118 0x0000000[0|1|2|3]

We can perform to control them from userspace.

> This is one of the reasons, why USB soundcards expose all settings
> though the alsa mixer interface. It also offers a standardized interface
> for userspace apps to build on top and a method to directly link mixer
> to soundcard for systems with multiple soundcards.
> 
> How do you envisage to handle this?

These USB-connected sound devices basically tells their control
capabilities by USB descriptor information. This mechanism is
standardized and included in USB specification. Thus single parser has a
meaning.

On the other hand, IEEE 1394 bus-connected sound devices implements its
own way to tell their control capabilities and model-specific way to
perform control. Thus we should prepare for model-specific parsers. The
idea to include these parsers into kernel-space increases maintaining
efforts.

(Actually, USB-connected sound devices includes vendor-specific
interface. Such interfaces require own codes and snd-usb-audio includes
these code. You can see such codes in sound/usb/mixer_quirks.c and the
other USB Audio device class driver codes.)

In an aspect of user experience, I cannot find any differences between
using alsamixer (or amixer) and using specific-application. ALSA PCM
character devices, ALSA Control character devices and Linux FireWire
character devices are completely different and users don't mind the
differences. What the users' want is to control their physical devices,
to consider about to which character devices they access.


Regards

Takashi Sakamoto
