From: Tim Goetze <tim@quitte.de>
Subject: Re: Which API for MIDI?
Date: Wed, 10 Dec 2003 12:06:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312101134390.527@autumn>
References: <Pine.HPX.4.33n.0312101057320.12636-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312101057320.12636-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Denis de Leeuw Duarte <denis@cyozlab.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>Denis de Leeuw Duarte wrote:
>> I'm starting work on a new midi sequencing app, but I'm a bit confused by
>> the different API options ALSA offers. I've been reading whatever snippets
>> I can find on the web, mostly mailing list archives, and if I understand
>> correctly my options are basically the rawmidi API and the alsa sequencer
>> API. With the former I must handle all timing myself in user space and
>> with the latter this is all done by ALSA, is that a correct description?
>
>Yes. And the sequencer can connect/route between ports, and supports
>ports handled by userspace apps.  The user of your sequencer won't be
>happy if it's restricted to rawmidi ports.

more things to consider:

* what kind(s) of sync-to-external will you need?
* do you want to receive/send MIDI sysex data?

last time i checked, the latter was impossible to do via the sequencer
API (please correct if things have changed). afaik, the former isn't
always easy to do with the sequencer either.

i've ended up supporting both raw and sequencer access to MIDI ports,
dropping the sequencer timing and queue mechanisms in order to gain
flexibility in sync and tempo matters. of course that requires
realtime threading for MIDI i/o to achieve stable timing.

>> My question is: if my first priority is to have stable, reliable timing
>> and performance, which API should I choose, taking the current state of
>> the alsa sequencer code into consideration?
>
>The current state of the sequencer _code_ is just fine.  It's the
>documentation you'll have problems with (but the rawmidi docs aren't
>better).

i found the sequencer API to be well-documented. it's somewhat lacking
in code examples, but there are quite a few applications out there
that use it (pmidi for a start maybe, and then we have rosegarden,
muse etc).

tim


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
