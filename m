From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Must MIDI SysEx data contain the start byte 0xf0
 and the end byte 0xf7?
Date: Fri, 18 Jan 2013 18:29:00 +0100
Message-ID: <50F9865C.4010200@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A41EFE3BA591@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4C76B265EA5
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 18:29:04 +0100 (CET)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41EFE3BA591@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
> I've read about SysEx continuations aka. divided SysEx
> http://www.allegro.cc/forums/thread/607445
> http://www.sonicspot.com/guide/midifiles.html
>
> What it means is that within a MIDI file, a long sysex could be split
> across several events with different delta times, giving the receiver
> some processing time in between (e.g. flash EEPROM etc.).  The delta
> times tell when to send the parts.
>
> Now, is that truth?  How to do that with ALSA?

Just put the partial chunks into separate events.
The first must begin with the F0 byte, the last end with F7.
(This is not actually checked; you can put arbitrary bytes into SysEx
event data.)

> The documentation on snd_seq_ev_set_sysex insists:
> "the sysex data must contain the start byte 0xf0 and the end byte 0xf7."

This is wrong.  For that matter, when the sequencer receives from the
hardware a SysEx that is too large for its internal buffer, it will
split it into pieces.


Regards,
Clemens
