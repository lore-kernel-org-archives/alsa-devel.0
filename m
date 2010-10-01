From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [LAD] question on ADAT S/MUX using snd-ice1712 and Alesis AI4
Date: Fri, 1 Oct 2010 12:20:41 -0700
Message-ID: <AANLkTi=sRJ_JS-P8SSEcw37JkQnvEpdK0GKboS+7q3VY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux Audio Developers <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Now that I have an ADAT-capable card ($20 ebay ice1712-based terratec
ews88d) I'm curious... if I combine it with
something like http://www.kellyindustries.com/computer/alesis_ai4.html
( http://www.alesis.com/ai4 ) and use the
S/MUX mode built in to the AI4 across eight channels to create four
24/96 channels.
//// //// //// ////
In order for the AI-4 to operate at the 96 kHz samplerate it has to be
run in S/MUX mode or sample split mode which means that you get 4
channels of conversion and not 8. This is standard and perfectly
acceptable. The first two channels will be routed out to the ADAT
lightpipe outputs 1 through 4 and the 2nd two channels with be routed
out ADAT lightpipe outputs 5 through 8.
//// //// //// ////

Would I be able to "transparently" use these "S/MUX"d channels in a
linux DAW, by simply recording/playing-back a higher channel count per
track (e.g. 4 for a stereo track, 2 for a mono)? This seems like a
good way to achieve "studio quality" 24/96 record&playback at a
distance from the computer -- via ADAT cable -- using high quality
outboard A/D and D/A or interfacing to external equipment already
presenting AES/EBU format I/O.

If a device like the AI4 actually does all the bit-splitting and other
fu, both for input and output -- wouldn't it not matter that the
actual 2-track or 4-track contents are essentially "noise" because
nothing in Linux-land would understand the S/MUX format.

Next question: to avoid the hack suggested above, is there some kind
of ALSA plugin that would reconstitute/create synchronized pairs of
S/MUX data on the same soundcard into single 24/96 streams, both for
input and output? How is S/Mux handled in Linux & ALSA?

Thanks.

Niels
http://nielsmayer.com

PS: The Alesis AI4 seems nicer than the http://www.aphex.com/144.htm
-- for one I won't need to make 110 ohm cables with XLR connectors to
DB25. The AI4's support for S/MUX mode is especially nice-sounding --
if there was a way for it to work in linux. Any other suggestions for
converting ADAT to AES/EBU (or spdif)  w/ decent synchronization
options for input?
