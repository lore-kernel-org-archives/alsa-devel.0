From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa sequencer: How to eliminate choking
Date: Tue, 7 Dec 2004 10:55:34 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412071023010.14899-100000@studcom.urz.uni-halle.de>
References: <20041207030836.76199.qmail@web51904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041207030836.76199.qmail@web51904.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michael Geis wrote:
> The streaming works for pieces that dont contain many parts, but
> when many notes are played simultaneously (e.g. Beethoven's 5
> Symphony, Movement 1), the order of notes gets mixed up

This shouldn't happens, the ordering of events in a queue is stable.

> and the output devices choke (same problem for a keyboard and with
> timidity). However, the midifile I made the score from plays
> nicely with pmidi.

How do you send the events?  Is the timing done with a queue, or do
you send the events directly?

> I am pretty convinced that the problem is not queue overflow,
> since I flush queues every two seconds.

What do you mean by "flush"?

> Is there a Macro that tells me whether an ALSA sequencer client is
> an internal or external device?

No.

Drivers for internal devices often know the number of voices etc., but
these information fields are optional.

> Thus, a user could choose what kind of device to play to (without
> having to specify client and port).

And what if there is more than one device of a specific type?

Just show a list and allow the user to select from it.

> Second, is ALSA used purely on linux or also on OS X or BSD?

The "L" stands for Linux. :)

In theory, it would be possible to write plugins for other driver
architectures (like the Jack pcm plugin).


Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
