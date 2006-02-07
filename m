From: Doug McLain <doug@nostar.net>
Subject: Re: Multi Delta 1010 sync
Date: Tue, 07 Feb 2006 15:27:26 -0500
Message-ID: <43E902AE.1000804@nostar.net>
References: <20060205161525.GA2691@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060205161525.GA2691@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yesterday I set the master 1010LT to 96000 Internal, and the slave card 
to SPDIF In (with an rca cable connecting SPDIF Out to SPDIF In), ran 
jack at 96Khz, and fired up xmms and ran an mp3 in repeat mode for the 
last 24 hours, with its outputs connected to all 16 outputs, and all 16 
inputs connected to my mixer, with no xruns.

Doug

John Rigg wrote:
> After some reverse engineering I've found out why I was having trouble
> syncing my two Delta 1010s at high sample rates using the word clock inputs.
> 
> The Delta 1010 uses a 74HC4046 phase-locked loop (PLL) to lock onto the word
> clock input signal. This is used in a feedback loop with a /256 counter to
> produce a frequency that's multiplied by 256x at the output of the PLL
> oscillator. With a 48kHz input this gives a PLL frequency of 12.288MHz.
> 
> According to the 74HC4046 data sheet, the maximum frequency it can
> work at is 13MHz. In other words, even a 48kHz clock is close to the
> specified limit, so forget about higher frequencies. (I didn't discover
> this until after I'd built a 96kHz word clock :-(. )
> 
> The S/PDIF receiver OTOH uses its own internal PLL which works with 96kHz
> sample rate. However,I couldn't sync reliably using the S/PDIF in/outs with
> one card as master and the other as slave. At 96kHz jackd would die at random
> times with a floating point exception, so often it was unusable.
> At 48kHz this would still happen, but not often (every couple of hours).
> I'm guessing that this is due to a phase difference between master and
> slave clocks.
> 
> My conclusion is that the only way to sync these cards reliably
> at all frequencies is to clock them both from an external S/PDIF device,
> and to make sure both cards are receiving the clock signal directly from the
> master device (ie. not going through the S/PDIF circuitry of the first card on
> the way to the second card).
> 
> John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
