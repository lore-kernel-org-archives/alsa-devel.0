From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Which API for MIDI?
Date: Wed, 10 Dec 2003 11:35:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312101057320.12636-100000@studcom.urz.uni-halle.de>
References: <20031210092944.0F1A05543@slik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20031210092944.0F1A05543@slik.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Denis de Leeuw Duarte <denis@cyozlab.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Denis de Leeuw Duarte wrote:
> I'm starting work on a new midi sequencing app, but I'm a bit confused by
> the different API options ALSA offers. I've been reading whatever snippets
> I can find on the web, mostly mailing list archives, and if I understand
> correctly my options are basically the rawmidi API and the alsa sequencer
> API. With the former I must handle all timing myself in user space and
> with the latter this is all done by ALSA, is that a correct description?

Yes. And the sequencer can connect/route between ports, and supports
ports handled by userspace apps.  The user of your sequencer won't be
happy if it's restricted to rawmidi ports.

> My question is: if my first priority is to have stable, reliable timing
> and performance, which API should I choose, taking the current state of
> the alsa sequencer code into consideration?

The current state of the sequencer _code_ is just fine.  It's the
documentation you'll have problems with (but the rawmidi docs aren't
better).


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
