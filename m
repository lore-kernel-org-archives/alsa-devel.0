From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 01 Oct 2004 15:31:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096659069.24868.64.camel@krustophenia.net>
References: <200410011833.i91IXsMn001748@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410011833.i91IXsMn001748@sanctuary.aproximation.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: thewade <pdman@aproximation.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-10-01 at 14:33, thewade wrote:
> > > Lastly, what is the best way to determine the latency of my pesent
> > > kernel?
> >
> > What is the smallest period size you can use without xruns?
> 
> 256 is too small, 512 works fine. I cant seem to set the period to
> anything between that, proabably because its not a 2^2 value. I tried
> 360 and 384 but jackd wouldn acecpt those. So just over 10ms I guess...
> (512/48000 sec)
> 
> What is the typical latency with the mm+VP patch installed?
> 

With the VP patch the lower limit on latency only depends on the
physical limits of your hardware (the minimum size of a DMA transfer,
PCI timing, etc).    Of course, you might want to use a larger period
size than the lowest your hardware supports, due to increased overhead
with an extremely small period size.  There are people using JACK at 32
and 64 frames (0.66 and 1.33 ms), even with consumer sound cards.  With
RME hardware it should work very well at these low latencies.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
