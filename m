From: Glenn Maynard <glenn@zewt.org>
Subject: Re: hardware channel mixing
Date: Tue, 7 Sep 2004 01:04:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907050458.GZ21120@zewt.org>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.58.0409030913180.9962@pat.dumaisnet.ca> <20040903155801.1ae48548@mango.fruits.de> <Pine.LNX.4.58.0409030957010.9962@pat.dumaisnet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409030957010.9962@pat.dumaisnet.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 03, 2004 at 10:04:29AM -0400, Patrick Dumais wrote:
> That's the thing. I'm writing a soft-sampler. meaning that I have multiple
> samples playing at one time when the user presses the keys on his midi
> keyboard. I don't like software mixing because I feel I could gain quality
> by relying on the hardware (am I right?). And I also want my app to go
> faster by letting the hardware do this job. But I realize that opening 16
> devices (16voice polyphony for my app) can be ressource consuming, so it's
> a drawback. I'm not too sure what to do.

FYI, I did this in the sound system for StepMania[1]: if the underlying
sound system supports multiple hardware channels, it'll use them.  If
it doesn't, it'll just start one stream and do it all in software.  It
works very well--and this is a game, not a soft-sampler, so it's doing
a lot of other things, too (like decoding videos and rendering graphics).

The original reason for this was improving latency in Windows: DirectSound
has a minimum latency of about ~40ms (which is a joke)--if you don't buffer
that far ahead, it croaks, but you can start playing new streams faster.
This isn't a problem with ALSA.

However, a bigger win is that SB cards do hardware resampling.  Since sound
data for this game comes from any number of sources, there's no consistent
sample rate; announcer files are often 22khz, songs are usually 44khz with a
few 48khz oddballs, etc.  With software mixing, we have to resample all of
this manually, and I havn't found a resampler that can handle it[2].

I can play a dozen stereo streams at once, all resampled, and keep plugging
along at 95FPS (in Windows).  In practice, we probably never will really need
to resample more than two streams at once during play (we may need to play a
dozen or more, but most can be preloaded), though those gross cards that only
support 48khz may need to do three.

Of course, none of this necessarily means hardware mixing is a good approach
for your application.

[1] www.stepmania.com

[2] FWIW, we need: reasonable quality resampling--good enough for use in a
game based entirely on music but not "high quality"; very low CPU use,
preferably under 5% per stereo stream on a typical low-end 1ghz PC; and
permissively licensed, 2-, 3-clause BSD or MIT, so it can be integrated
directly into our MIT-licensed code.  I don't know if all of this is
possible, DSP's not my field.  :)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
