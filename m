From: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Wed, 12 Apr 2006 20:17:05 -0700
Message-ID: <20060413031705.GA9160@hurl.ugcs.caltech.edu>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu> <1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1144878001.27496.33.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 12, 2006 at 05:40:00PM -0400, Lee Revell wrote:
> 
> Please disregard last message - try simply surrounding hw:0,0 and hw:0,1
> with quotes.
> 
> pcm.multi_capture {
> 	type multi
> 	slaves.a.pcm "hw:0,0"
> 	slaves.a.channels 8
> 	slaves.b.pcm "hw:0,1"
> 	slaves.b.channels 8

Quotes don't work.  To get around the parse error, i need
to give a name to the device elsewhere then refer to it by
name.

So for some reason

pcm.multi_capture {
	type multi
	slaves.a.pcm "hw:2,0"
	slaves.a.channels 8
	slaves.b.pcm "hw:2,1"
	slaves.b.channels 8

will fail to parse, but

pcm.layla_analog {
	type hw
	card 2
	device 0
}
pcm.layla_digital {
	type hw
	card 2
	device 1
}
pcm.multi_capture {
        type multi
        slaves.a.pcm layla_analog
        slaves.a.channels 8
        slaves.b.pcm layla_digital
        slaves.b.channels 8

  
will parse OK.  


However, trying to run jack via qjackctl with a 
few simple configs that the LAYLA is capable of yields:

/usr/bin/jackd -R -t5000 -dalsa -dmulti_playback -r44100 -p256 -n2 -P -o2
jackd 0.100.6
loading driver ..
apparent rate = 44100
creating alsa driver ... multi_playback|-|256|2|44100|0|2|nomon|swmeter|-|32bit
configuring for 44100Hz, period = 256 frames, buffer = 2 periods
ALSA: no playback configurations available (Invalid argument)
ALSA: cannot configure playback channel
cannot load driver module alsa


Maybe need to define channels and/or rate in layla_* and/or multi*
but in the past the presence of those has also seemed to cause problems
(even if the definitions are accurate).


Beyond that, the solution you suggest creates two devices, one 
16 channel playback the other 16 channel capture.  The core problem 
is that JACK will only open a single device.  So even if multi_playback
and _capture worked, to the best of my knowledge that would still
not enable me to run ardour in 16 channel duplex.  Wouldn't it require
another layer of asym or something to present it as a single device?
Or can _playback itself be opened duplex?  The definition seems
identical to _capture anyhow....

  -geoff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
