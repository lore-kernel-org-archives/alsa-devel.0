From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/8] [RFC] new driver for Echo Audio's
 Fireworks based devices
Date: Mon, 03 Jun 2013 13:18:04 +0200
Message-ID: <51AC7B6C.7000108@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 93BAD2619EF
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 13:18:08 +0200 (CEST)
In-Reply-To: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

o-takashi@sakamocchi.jp wrote:
> Currently this driver module support just PCM/MIDI kernel streaming via ALSA interfaces.
> So there are some issues about this driver.
> 1.whether adding each PCM devices for analog and digital interface

ALSA drivers should reflect the actual hardware design as much as
possible; conversions should be done in user space by alsa-lib.

If analog and digital channels are part of the same AMDTP stream, then
that is how the PCM device should look like.  (This is also how other
drivers like ice1712 work.)

There are other functions to describe and label channels.
(And when I say "there are", I actually mean "there will be,
eventually".  ;-)

> 2.where the codes for device control like volume, routing and etc are

The idea was to let the kernel driver handle only the actual streaming
(and everything else necessary for that, such as device enumeration,
sample rate, and clock source management), and let user space handle
everything else.

Volume and routing do not affect the streaming part in any way, so the
kernel driver should not bother to implement them.


4. clock source handling

AMDTP itself was designed for consumer devices, where streaming is in
only one direction, and where the receiving device always synchronizes
to the playback device; this is the equivalent of the "SYT Match" clock
source.

This is how the existing drivers (isight, firewire-speakers) work.

However, for full duplex and other clock sources, streaming becomes
more complicated.  When in "SYT match" mode, the playback stream should
be running even when only a capture PCM device is open.  In all other
modes, the PC must synchronize to the device, so the capture stream must
be running when _any_ PCM/MIDI stream is open (and, of course, the
capture packets must be used to determine when to send packets).


Regards,
Clemens
