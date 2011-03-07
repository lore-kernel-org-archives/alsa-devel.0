From: r10kindsofpeople <r10kindsofpeople@gmail.com>
Subject: MIDI, snd-serial-u16550 and dropped notes
Date: Mon, 7 Mar 2011 08:45:37 -0500
Message-ID: <AANLkTikB02m4i48EeFrAqjrdy6MgU45ymGtxBCUBAA+O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A4A31103813
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 14:45:41 +0100 (CET)
Received: by qyk7 with SMTP id 7so3818296qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 05:45:38 -0800 (PST)
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

Sorry for cross-posting, I've been writing about this problem on
alsa-user, but it seems to me that this probably belongs over here now
(if it hasn't all along).

A brief recap:
Using the snd-serial-u16550 driver I have two MIDI streams coming in
that are near duplicates of each other.   Every now and then (after
5-45 minutes of playing) I get a dropped or corrupted message.  I've
captured this multiple times using both a logic analyzer on the serial
data and software logging of the ALSA ports.

Sometimes whole events get dropped, sometimes the tail end of one
message and the beginning of the next gets dropped to form a
completely different event.  Aside from the fact that both ports are
getting hit simultaneously, the ports are not being hit very
hard...normal playing.

This has occurred under:
Ubuntu 10.04 netbook
Ubuntu 10.10 netbook
Ubuntu 10.10 with Natty lowlatency kernel

It does not appear to occur under:
Ubuntu 10.10 server
Ubuntu 10.04 netbook with linux-rt kernel

I've not eliminated the possibility that it's being caused by my ALSA
application - quite the opposite - but what could I be doing that
corrupts the behavior of the driver?  I've tried several methods of
reading the data to no effect.

With great respect to the authors of the driver, I don't think it has
changed in many years and kernel has certainly changed underneath it.
Is there any sense that it could be improved to eliminate the problem
and the apparent requirement for the -rt kernel?  Or should I be
looking at my ALSA application more closely?

John
