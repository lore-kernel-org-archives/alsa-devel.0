From: jlunder@catfish.dhs.org (Joseph Lunderville)
Subject: GUS Classic driver, PLUGHW problems
Date: Fri, 4 Jul 2003 02:12:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030704091249.GA1692@catfish.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm trying to get a 486 with a GUS Classic working through ALSA, and I've
run into a couple of problems:


1. plughw doesn't know how to convert from interleaved data to
noninterleaved data. in fact, as far as I can see, nothing at all except the
GUS driver knows what to do with noninterleaved data.

I'm writing my own software, so this isn't as big a deal as it could be, but
anybody else who tries to use the GUS will be stuck. I imagine that the only
reason this hasn't been fixed yet is that nobody wants to use a GUS with
ALSA :)

2. the GUS driver seems to have a problem with outputting PCM data. I had to
test it using my own code (since the example uses interleaved data), but I'm
reasonably confident that the problem's in the driver.

the problem I'm observing is that there are frequent clicks in the audio
output (coincidentally, they arrive at a frequency corresponding exactly to
the size of the ring buffer -- I've confirmed this by looking at the output
on an oscilloscope. the click looks like one or two samples are being
skipped). this is when I use a buffer size that's a multiple of my period
size -- when I use other combinations of buffer size and period size, things
get worse. some combinations of buffer & period size cause I/O errors.

3. finally, the example doesn't start the audio output. it's difficult for
me to tell whether you're supposed to call snd_pcm_start() in order to get
output from the speakers (in which case the example is wrong), or whether
the gus driver requires this when it's not supposed to, but either way
something's not right.


at the very least I'd love it if these could be documented on the known
issues page. if these are in fact the bugs I think they are, is there anyone
around who's interesting in fixing them? I imagine that bugs related to
obsolete hardware are fairly low priority, but I'm tossing this message out
in case the will is there and the fix is easy. if there isn't anyone else
who has the time and inclination to investigate these problems, then I'll do
it; for various reasons development on the target machine is painful though,
and I'd especially rather avoid working on something as large as ALSA (which
takes something like 40 minutes to compile and install).


thanks,

-joe


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
