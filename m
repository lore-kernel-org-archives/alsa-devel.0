From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Sun, 25 Jul 2010 13:56:36 -0700
Message-ID: <AANLkTim0RRttC7__TVxU++ToC3iBSu7LNnUUkwKu8jdG@mail.gmail.com>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
	<AANLkTin6TTnuQPhP6t5-YmNEodfAmsR6Hjqyfsznwhce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTin6TTnuQPhP6t5-YmNEodfAmsR6Hjqyfsznwhce-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Paul Davis <paul-dDzkXPnfpdxaomM2pvQuqZqQE7yCjDx5@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linux Audio Developers <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 25, 2010 at 12:21 PM, Paul Davis <paul-dDzkXPnfpdxaomM2pvQuqZqQE7yCjDx5@public.gmane.org> wrote:
>> (2) All volumes are represented as decibels, including the 0 to -48dB
> i don't own one, so its not of much concern to me, but dB<WHAT> ?

The http://en.wikipedia.org/wiki/Decibel is a unitless measurement. :-)

However, in this case there are a few different semi-implicit
http://en.wikipedia.org/wiki/DBFS and other markings that I left off
in the name of saving on screen-real-estate and reduced redundancy.
Tooltips across-the board would be a very helpful addition to the
envy24control 1.0.0 interface. On the other hand, these are exactly
the same dB values as reported by ALSA's "amixer" and "alsamixer" so
such complaints should go upstream. :-)

Specifically:

(1) The db markings in "Analog Volumes" correspond to analog levels
that can be set for the DAC or ADC's. e.g.
0 -to- -63dB attenuation of the output of the analog DAC, and the +18
-to- -63dB attenuation/amplification of the
analog ADC. These are the exact same dB readings reported by ALSA,
e.g. "amixer -c M66":

> Simple mixer control 'ADC',0
> Limits: 0 - 163
> Mono: 163 [100%] [18.00dB]
> Simple mixer control 'ADC',1
> Limits: 0 - 163
> Mono: 163 [100%] [18.00dB]
> Simple mixer control 'ADC',2
> Limits: 0 - 163
> Mono: 152 [93%] [12.50dB]
> Simple mixer control 'ADC',3
> Limits: 0 - 163
> Mono: 152 [93%] [12.50dB]

(2) The "0 to -48dB" peak metering  levels are based on values from
hardware peak metering
(per http://alsa.cybermirror.org/manuals/icensemble/envy24.pdf )
> Peak data derived from the absolute value of 9 msb.  00h min - FFh max
> volume. Reading the register resets the meter to 00h.

When "0dBFS" reads on the peak meters in the new envy24control, it
means 0dBFS relative to these 9MSB's.  (see the red "0dBFS" labels in
http://nielsmayer.com/envy24control/Screenshot-Envy24Control-MonitorInputs.png
or http://nielsmayer.com/envy24control/Screenshot-Envy24Control-MonitorPCM.png
). Note that the signal would be able to go 7 or 15 LSB's higher
before reaching actual full-scale peak. It would be more useful if
there was a way for the hardware meters to detect actual clipping,
e.g. value=256, whereas normally the meters report values from 0-255.
For example "amixer -c M66 cget iface=PCM,name='Multi Track
Peak',numid=45" returns:
> type=INTEGER,access=r-------,values=22,min=0,max=255,step=0
> : values=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,198,255,198

For proper metering, I suggest using Fons' excellent jkmeter with it's
nice (and free) implementation of the K-System
http://en.wikipedia.org/wiki/File:K-14_spectrafoo.jpg (caption:
"digital audio meters in the Metric Halo application, called
SpectraFoo").

(3) For the envy24's built in digital mixer, the 8PCMs + 2*SPDIF out,
and up to 8 inputs + 2SPDIF inputs, all send to the digital mixer via
24dB attenuators. Seer
http://nielsmayer.com/envy24control/envy24mixer-architecture.png for
details. Thus all mixer input sliders have "0 -to- -144dB
attenuation."

(from http://alsa.cybermirror.org/manuals/icensemble/envy24.pdf )

This is what the above manual says about the Envy24's digital mixer:
> 4.5.5 Multi-Track Digital Monitoring
>
> The Envy24 integrates a 36-bit resolution digital hardware mixer. The
> width of the data path is strictly to ensure that during processing of
> all the channels, under any condition, no resolution is lost. The
> dynamic range of the end user system will be limited by the range of the
> physical output devices used. In order to maintain identical gain to the
> input stream (i.e. 0dB), the resulting 24-bit is not msb-aligned to the
> 36-bit. The overflow bits correspond to the analog distortion due to
> saturation. The user would need to reduce the overall attenuation of the
> inputs to avoid clipping. Insertion of the digital mixer adds only a
> single sample cycle delay with respect to the original data. This
> extremely low latency all digital mixer provides monitoring
> functionality and can replace a traditional external analog input
> mixer. There are 20 independent audio data streams to mix and control
> the volume.

-- Niels
http://nielsmayer.com
