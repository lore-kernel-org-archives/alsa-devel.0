From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: dolby digital output
Date: Sun, 17 Feb 2002 17:48:28 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFCEAACBAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1013927613.9422.10.camel@samoyed.wuff.dhs.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Hod McWuff <hod@wuff.dhs.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Any AC3 or DTS takes some time to decode even with an external decoder.
The nice thing about them is that the standard tell us that they are fixed
latency decoders.
So, AC3 decoder will take a fixed amount of time to take a digital SPDIF in
and convert it to 6 analogue out's for your speakers.

The delay is long enough to make it not suitable for low latency
applications like games and telephony.
Some applications which don't care about the latency, but only care that it
is predictable work ok with AC3 audio.
E.G. DVD playing. The latency of decode does not matter, what matters is if
we can predict the latency so we can keep audio and video in sync.

If you then add an encoder, so you can mix streams, you add to the latency
again.
PCM is the audio amplitude sampled at fixed time periods.
These samples can translated into samples in the frequency domain using the
Fast Fourier Transform, thus giving the amplitude of certain frequencies at
certain times.
These samples in the frequency domain is what is contained in AC3.
If you could mix the channels in the frequency domain instead of the PCM
domain, you could save a lot of CPU time.

Before: -
1) AC3 stream from DVD
2) decode to 6 PCM channel
3) Mix with other PCM source
4) 6 PCM to AC3 encoding
5) SPDIF out.
6) External decoder.
7) speakers.

After: -
1) encode other PCM source into AC3.
2) mix DVD's AC3 with other sources AC3 using a frequency domain mixer.
3) SPDIF out.
4) External decoder
5) speakers.

Notice that alsa just provides the SPDIF out bit, nothing else.
ALSA knows nothing of AC3 or DTS. It just outputs the digital stream without
modifying it.

I think it would be best for your application to do the mixing.

Cheers
James




> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Hod McWuff
> Sent: 17 February 2002 06:34
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] dolby digital output
>
>
>
> What would be involved in enabling 5.1-channel spdif output?
>
>
> I'd imagine the first step would be to add an ac3 encoder, and then
> (possibly) the 2->5.1 channel demuxing for stereo streams. This would
> result in the ability to mix dolby digital streams (DVD's) with more
> mundane PCM streams, such as IM or telephony apps.
>
>
> I'm willing to tackle some moderate coding, but I haven't attacked alsa
> internals at all yet... where's the best docs for that?
>


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
