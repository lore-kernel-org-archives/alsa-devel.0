From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Interested in having a go at coding an ALSA driver
Date: Wed, 12 Feb 2003 09:31:54 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302120907490.19742-100000@studcom.urz.uni-halle.de>
References: <5.1.1.6.0.20030212142640.00aafb40@mail.labyrinth.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.1.6.0.20030212142640.00aafb40@mail.labyrinth.net.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Share <cpsmusic@labyrinth.net.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chris Share wrote:
> I've never done any kernal programming and feel a bit daunted by the task
> in front of me. Any suggestions on where to start would be much
> appreciated. I have downloaded quite a few articles on ALSA, etc. so that
> should keep me going for a while.

There's a document about writing ALSA drivers in
alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl.

> Yamaha SW1000
> Hoontech DSP24 Value
>
> I'd be interested in having a go a coding a driver for one of these.

Yamaha doesn't publish useful informatin about the SW1000XG, so you'd have
to reverse engineer the Windows driver first.

alsa-kernel/pci/ice1712/hoontech.h says that the SoundTrack DSP 24 Value
is supported, but the DSP 24 is marked "untested" in the sound card list.
Anyway, if it doesn't work with your card, it should be easy to make it
work.


HTH
Clemens




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
