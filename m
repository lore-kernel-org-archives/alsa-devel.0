From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using hardware timers for the ALSA sequencer
Date: Wed, 16 Mar 2005 09:26:08 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503160923070.28424-100000@studcom.urz.uni-halle.de>
References: <1110913849.17931.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110913849.17931.4.camel@mindpipe>
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
> On Tue, 2005-03-15 at 09:55 +0100, Clemens Ladisch wrote:
> > For USB MIDI ports, 1000 Hz is adequate, and that is the system timer
> > resolution on 2.6 kernels.
>
> So how does MIDI work with 2.4?  Not very well?

With the default settings, MIDI playback will have jitter up to 10 ms.
A few people use the RTC timer or a sound card timer instead.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
