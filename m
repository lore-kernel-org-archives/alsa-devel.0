From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using hardware timers for the ALSA sequencer
Date: Tue, 15 Mar 2005 09:55:29 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503150932200.186-100000@studcom.urz.uni-halle.de>
References: <1110845236.15588.23.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110845236.15588.23.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> How hard would it be to get the sequencer to prefer the hardware timer
> by default and fall back to the system timer otherwise?

Probably not very hard -- registering a hardware timer would change
the default timer, or something like that.

> Probably would not be noticeable for a MIDI keyboard, but for
> applications like sending MIDI clock/MTC, the system timer
> resolution can be inadequate.

For USB MIDI ports, 1000 Hz is adequate, and that is the system timer
resolution on 2.6 kernels.

The theoretical upper limit for other ports would be the MIDI bit
clock, i.e., 31250 Hz. :)

> Would this be a good idea?

I think the only application where a higher resolution would be useful
would be sending MIDI clock/MTC, and we would want a kernel module for
this to prevent _any_ scheduling latencies.  A special module like
this could easily have its own mechanism for selecting the timer to
use.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
