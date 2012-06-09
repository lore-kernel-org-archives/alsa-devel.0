From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Sat, 09 Jun 2012 13:07:34 +0200
Message-ID: <4FD32E76.3090304@ladisch.de>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>	<38538c62-f01e-4743-be92-aea79d61085e@email.android.com>	<4FC5AC47.4060606@mixxx.org>
	<4FC5C9C8.1000604@ladisch.de> <4FC7CDC1.8020606@ladisch.de>
	<4FD2F324.7070402@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B518610404C
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 13:08:06 +0200 (CEST)
In-Reply-To: <4FD2F324.7070402@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sean M. Pappalardo - D.J. Pegasus wrote:
> On 05/31/2012 10:00 PM, Clemens Ladisch wrote:
>> I wrote:
>>> 00 F9 xx yy zz ->  F0 00 01 60 48 53 53 00 00 0F 09 0x 0x 0y 0y 0z 0z F7
>
> This appears to work fine. But where did you get the leading 00 from?

This is how the FireWire packets are constructed.  The first byte is
a tag; 00 means that the rest of the packet contains MIDI data, ...

>>> 13 xx yy zz<- F0 00 01 60 48 53 53 01 03 0x 0x 0y 0y 0z 0z F7
>>> 14 xx yy zz<- F0 00 01 60 48 53 53 01 04 0x 0x 0y 0y 0z 0z F7
>>> (0x13 = 0x10 + 3 = kUserTagBase + uUserTag)

... while tags in the range 10..EF are "user tags".

When you use this function:

> // uUserTag is valid in the range 0x00 - 0xDF.
> virtual uint SendUserControl(uint8 uUserTag, const uint8 *pUserData,
>                              uint uDataBytes) = 0;

libhss1394 will add 0x10 to the tag.

> I just modified Mixxx's SCS.1d script to work with your custom sysex
> messages and tested with your latest patch. The .1d doesn't actually
> work 100% with this since Mixxx never receives some of the standard
> MIDI messages amid all of the sysex ones, and it's much worse when the
> platter is spinning and sending the tons of messages it does. This
> could be due to PortMIDI's lack of a callback mechanism, forcing Mixxx
> to poll it every 1ms because it's much more difficult to reproduce the
> problem using amidi -d.

That's possible.  However, at 4 KB, ALSA's buffer should be big enough
for those messages.

> I also see an F9 message slip through once in awhile according to amidi -d:
> F9
>    55
> 91
> C4

The driver currently assumes that there is exactly one MIDI message per
packet.  It appears that this is not true, and if F9 and real MIDI
commands are mixed in one packet, the result is not correct.

> As soon as I start the JACK server to handle the audio interface on
> the SCS.1m, the ALSA driver stops sending MIDI for that device unless
> I stop JACK and power-cycle the device. Its last words are:
> F0 00 01 60 48 53 53 0F 03 00 03 00 00 0B 01 F7

This is a ping response (tag F3).  Apparently, Jack's FFADO driver
reinitializes the device and registers its own address for received
packets.  Since it does _not_ handle MIDI messages, it really should
not do this.


Regards,
Clemens
