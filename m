From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Re: [Alsa-user] ALSA, JACK, ASIO
Date: Sat, 12 Feb 2005 13:32:06 +0100
Message-ID: <20050212133206.7f0dc7a7@mango.fruits.de>
References: <9e47339105020710162d246fed@mail.gmail.com>
	<s5his52u6et.wl@alsa2.suse.de>
	<9e473391050208182623c5b3ea@mail.gmail.com>
	<1107982073.1806.10.camel@radium.gaugetheory.org>
	<87y8dxp9fm.fsf@sulphur.joq.us>
	<1108029414.1806.23.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108029414.1806.23.camel@radium.gaugetheory.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: Jack O'Quin <joq@io.com>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Feb 2005 04:56:55 -0500
Brian L Scipioni <brian@gaugetheory.org> wrote:

> Thanks.  A couple more ASIO questions:
> 
> Could the ASIO protocol be implemented on top of ALSA or within JACK? 
> Would it provide for low(er) latency operation on cards that support it?
> Would ASIO perhaps just provide some parallel functionality that is
> already represented in ALSA and/or JACK?

AFAIK ASIO was introduced because the win32 mm drivers sucked badly and
didn't allow to use a soundcard to its full potential. As ALSA doesn't
have the problem of being completely braindead (as the win 32 mm driver
(architecture) were), there's no need for ASIO on linux..

To answer the other post: With a modern Realtime Preemption kernel and
an M-Audio Delta 66 i can use buffersizes of 32 or even 16 frames
without dropouts (except for those produced by badly coded apps) with
jack using its ALSA driver. The cpu load goes up a bit though with such
small periodsizes due to context switch overhead, etc. It's very well
suited for noodling my guitar through jack-rack though :) At a
samplerate of 48khz a buffersize of 16 frames corresponds to an input
latency of 0.3ms. The same for output latency. Disregarding any
processing latencies by effects i use this gives a total roundtrip
latency of around 0.6ms. I find a buffer size of 32 frames (1.2ms
roundtrip latency) still perfectly usable with no audible delay (at
least for my ears),,

Your results might differ greatly depending on the soundcard used. For
example my CS46xx based terratec dmx xfire 1024 always produced some
xruns, even at 512 frames. I suspect either a driver or a hardware
problem.

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
