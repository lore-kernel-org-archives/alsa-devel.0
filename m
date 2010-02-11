From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: unpadded USB MIDI commands
Date: Thu, 11 Feb 2010 08:43:20 +0100
Message-ID: <4B73B518.1000706@ladisch.de>
References: <20100210171714.GA5280@usecode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 6E324103837
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:43:26 +0100 (CET)
In-Reply-To: <20100210171714.GA5280@usecode.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Willem Jan Palenstijn <wjp@usecode.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Willem Jan Palenstijn wrote:
> I recently investigated some trouble with sending MIDI via a USB MIDI cable
> (15ca:1806) to a Roland MT-32. In some cases, commands were being dropped.
> 
> (This is what is reported on
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3752 . I'm the colleague
> mentioned by druon in note 0021737 there.)

Apparently, the bug tracker drops some email notifications.

> After we experimented a bit, it turned out that packets of 2 MIDI commands (8
> bytes total) were being sent to the USB MIDI cable, and that if the first of
> these was a 2-byte MIDI command (such as a 0xC0 or 0xD0 command), the second
> command in the packet would get dropped.
> 
> A workaround is to limit the packet size to 4 bytes, as is already happening on
> at least one other device (the ESI M4U referred to in usbmidi.c).
> 
> I played with it some more this week, and it turns out that if the zero-padding
> from the USB MIDI commands is removed (violating the specs, as far as I
> understand),

Indeed.

> the second command does actually not get dropped.

I'd guess a certain other OS never sends more than 4 bytes in one packet.

> What do you think would be the right way to handle this problem? Don't zero-pad
> the outgoing packets for this specific device (and maybe a few others mentioned
> on bug #3752, if they end up suffering from the same bug)?

This would be possible, but there is no existing driver that actually
uses such a protocol, so I wouldn't want to rely on some implementation
detail that is likely to be changed in some other firmware revision.

> Limit the outgoing packets to 4 bytes like with the ESI M4U for these
> devices?

This is what the device expects.  The driver can have multiple active
packets, so this shouldn't reduce MIDI bandwidth.

> Add an option to the snd-usb-audio module to toggle this behaviour?

This might be useful if other such devices are found.  Or we could use
a whitelist of vendors whose devices work correctly.


Regards,
Clemens
