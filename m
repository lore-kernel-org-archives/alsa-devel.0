From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Multi device for 2 C-Ports... help needed
Date: Mon, 25 Apr 2005 13:17:21 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504251306330.2934-100000@studcom.urz.uni-halle.de>
References: <1114312187.15165.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1114312187.15165.6.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Geoff Beasley <songshop@bizmedia.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Geoff Beasley wrote:
> I went to the Alsa site to find out how to do this again, but I got
> completely confused. There's no mention of the multi plugin at all.

There is a small example, well hidden at
<http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html>.

Try this:

pcm.cport_a {
	type hw
	card 0       # change the card numbers as appropriate
	device 0
}
pcm.cport_b {
	type hw
	card 1
	device 0
}

pcm.playback20 {
	type multi
	slaves.a { pcm cport_a channels 10 }
	slaves.b { pcm cport_b channels 10 }
	bindings [
		{ slave a channel 0 }
		{ slave a channel 1 }
		{ slave a channel 2 }
		{ slave a channel 3 }
		{ slave a channel 4 }
		{ slave a channel 5 }
		{ slave a channel 6 }
		{ slave a channel 7 }
		{ slave a channel 8 }
		{ slave a channel 9 }
		{ slave b channel 0 }
		{ slave b channel 1 }
		{ slave b channel 2 }
		{ slave b channel 3 }
		{ slave b channel 4 }
		{ slave b channel 5 }
		{ slave b channel 6 }
		{ slave b channel 7 }
		{ slave b channel 8 }
		{ slave b channel 9 }
	]
}

pcm.capture24 {
	type multi
	slaves.a { pcm cport_a channels 12 }
	slaves.b { pcm cport_b channels 12 }
	bindings [
		{ slave a channel 0 }
		{ slave a channel 1 }
		{ slave a channel 2 }
		{ slave a channel 3 }
		{ slave a channel 4 }
		{ slave a channel 5 }
		{ slave a channel 6 }
		{ slave a channel 7 }
		{ slave a channel 8 }
		{ slave a channel 9 }
		{ slave a channel 10 }
		{ slave a channel 11 }
		{ slave b channel 0 }
		{ slave b channel 1 }
		{ slave b channel 2 }
		{ slave b channel 3 }
		{ slave b channel 4 }
		{ slave b channel 5 }
		{ slave b channel 6 }
		{ slave b channel 7 }
		{ slave b channel 8 }
		{ slave b channel 9 }
		{ slave b channel 10 }
		{ slave b channel 11 }
	]
}

pcm.both {
	type plug
	slave.pcm {
		type asym
		playback.pcm playback20
		capture.pcm capture24
	}
}

> When I get it going can I expect any extra latency ?

The plugin will copy the audio samples around, but the time needed for
that should be negligible.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
