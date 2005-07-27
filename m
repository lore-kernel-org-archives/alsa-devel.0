From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: note on /off at same time
Date: Wed, 27 Jul 2005 09:58:39 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507270951430.16586-100000@studcom.urz.uni-halle.de>
References: <1122396703.2224.63.camel@tordera.genos.intranet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.Uni-Halle.DE [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A03551BB
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2005 09:58:41 +0200 (MEST)
In-Reply-To: <1122396703.2224.63.camel@tordera.genos.intranet>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Cesar Hernandez <chernandez@genos.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cesar Hernandez wrote:
> -If I first send a noteon and then a noteoff to the same channel, note,
> and timetick, what happens?

The ALSA sequencer doesn't reorder events, even those with the same
timestamp, so both events will be delivered in that order to the
synthesizer.

What happens then depends on the synthesizer, but on most devices, the
note off will shut off the earlier note on.  Some devices can be
configured to ignore all note off events (regardless of their time
relative to the note on), and some do this by default for notes on the
drum channel.

> If I send first the noteoff and then noteon, what happens?

The note off will be ignored.  The note on will start a note.

> -If I send two noteon with the same timetick, channel and note, will it
> play only one note? And then, must I send two noteoff to stop them ?

It doesn't matter that the events are sent at the same time, the
synthesizer will handle them one ofter the other.

The handling of duplicate notes depends on the synthesizer.  GS and XG
devices can be configured to kill earlier notes with the same note
number, or to play both notes.  However, with most devices, a note off
will shut off all notes with the same note number.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
