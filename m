From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 22:07:03 +0100
Message-ID: <20100216210703.GA18109@tango.0pointer.de>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AD7024431
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 22:07:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 16.02.10 17:29, Jaroslav Kysela (perex@perex.cz) wrote:

> > I remember that a while back we had a discussion on alsa-devel
> > regarding the fact that ALSA does not define relative to what the dB
> > values reported by the mixer elements actually are measured. Some
> > mixer controls export dB values relative to max amplification (e.g. my
> > integrated USB speakers here), others relative to the output of some
> > other mixer element, and others relative to different standard or
> > not-so-standard output voltages.  And there is no API to figure out
> > what the base is.
> >
> > Now, what Jaroslav listed above suggests that he chose carefully where
> > he put 0dB. I was just wondering about that. Jaroslav, how did you
> > choose where to put 0dB?
> 
> Basically, if I remember correctly the discussion, 0dB on all elements 
> should main unchanged volume, <0dB attenuation and >0dB gain.

But you need some kind of "anchor" for that. What you write above
applies only for elements that have some kind of analog input and
output. But the most interesting components are probably the DAC and
ADC (i.e. the "innermost" elements), and it's not clear what level they
output, so the "anchor" for the relative dB values is missing...

> So, if you use one headphones and speakers with defined and fixed volume 
> settings, you can measure differences for the card with broken dB volume 
> ranges. I just used another HDA card in notebook with 0dB settings on all 
> playback controls on path, captured stream from this card on my USB card 
> and played this stream back on my USB card watching and relating the 
> volume levels according dB values. It's not 100% correct, but at least 
> it's something to start with.

Hmm, so you basically tuned the USB card's DAC/ADC level to the HDA
card's DAC/ADC.

I now measured the "Master" slider of my aureon (USB 0ccd:0028,
TerraTec Aureon 5.1 MkII) with the aforementioned dbmeasure tool and a
loopback cable. The aureon has 65536 volume steps, but
I was too lazy to measure them all. So I only measured every
3000th. From the max volume to the min volume:

65536 0 dB
62536 0.00560039 dB
59536 0.00694678 dB
56536 0.00616732 dB
53536 0.00645077 dB
50536 0.00673421 dB
47536 -1.49514 dB
44536 -1.49455 dB
41536 -1.49648 dB
38536 -2.98666 dB
35536 -2.98486 dB
32536 -2.98536 dB
29536 -4.48688 dB
26536 -6.00084 dB
23536 -5.99928 dB
20536 -9.00246 dB
17536 -10.5425 dB
14536 -16.5274 dB
11536 -32.9435 dB
8536 -43.4326 dB
5536 -43.5066 dB
2536 -43.2968 dB
0 -43.4431 dB

If you plot this it looks as if the card actually only implements 10
or so discrete steps, and at around 10000 just becomes a constant
function.

ALSA reports -47.87 .. -1.97 for this. So it seems the overall range
the USB data reports is not really that far off, but the volume
function in bteween is.

The noise level of these measurements is < -58 dB.

What's the next step with this measurement data? Will you take it from
here, or shall I provide you with more data?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
