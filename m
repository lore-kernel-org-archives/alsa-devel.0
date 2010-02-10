From: Willem Jan Palenstijn <wjp@usecode.org>
Subject: unpadded USB MIDI commands
Date: Wed, 10 Feb 2010 17:17:14 +0000
Message-ID: <20100210171714.GA5280@usecode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from belar.usecode.org (belar.usecode.org [85.13.250.20])
	by alsa0.perex.cz (Postfix) with ESMTP id F348A103818
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 18:17:15 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I recently investigated some trouble with sending MIDI via a USB MIDI cable
(15ca:1806) to a Roland MT-32. In some cases, commands were being dropped.

(This is what is reported on
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3752 . I'm the colleague
mentioned by druon in note 0021737 there.)

After we experimented a bit, it turned out that packets of 2 MIDI commands (8
bytes total) were being sent to the USB MIDI cable, and that if the first of
these was a 2-byte MIDI command (such as a 0xC0 or 0xD0 command), the second
command in the packet would get dropped.

A workaround is to limit the packet size to 4 bytes, as is already happening on
at least one other device (the ESI M4U referred to in usbmidi.c).


I played with it some more this week, and it turns out that if the zero-padding
from the USB MIDI commands is removed (violating the specs, as far as I
understand), the second command does actually not get dropped.


Example:

When sending the two commands 0xD1 0x10 and 0x91 0x40 0x40 normally,
it would produce:
sending packet: [ 0d d1 10 00 09 91 40 40 ]
When routing the MIDI output through the MIDI THRU port on the MT-32 to a
MIDI port on an ES1371, the captured stream is:
d1 10
and no note is played on the MT-32. (The 0x91 command is a note-on.)


After hacking out the zero padding, it looks like this:
sending packet: [ 0d d1 10 09 91 40 40 ]
The re-captured stream is:
d1 10 91 40 40,
and a note is properly played.


What do you think would be the right way to handle this problem? Don't zero-pad
the outgoing packets for this specific device (and maybe a few others mentioned
on bug #3752, if they end up suffering from the same bug)? Limit the outgoing
packets to 4 bytes like with the ESI M4U for these devices? Add an option to
the snd-usb-audio module to toggle this behaviour? Something else?


Best regards,
Willem Jan
