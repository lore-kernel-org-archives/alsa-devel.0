From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Maximum 50 dB gain in ALSA softvol plugin
Date: Mon, 15 Jan 2018 16:26:33 +0100
Message-ID: <alpine.DEB.2.11.1801151547220.2359@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1801121645540.16471@lnxricardw1.se.axis.com>
 <s5ha7xj3ug4.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151410060.2359@lnxricardw1.se.axis.com>
 <s5hd12b2q99.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151446420.2359@lnxricardw1.se.axis.com>
 <s5h8tcz2pje.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151520280.2359@lnxricardw1.se.axis.com>
 <s5hshb718wx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 326F5267515
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 16:26:40 +0100 (CET)
In-Reply-To: <s5hshb718wx.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Mon, 15 Jan 2018, Jaroslav Kysela wrote:

> > The usecase we have actually calls for 55 dB of gain maximum, but I was =

> > thinking that looking at the code the maths can actually handle 90 dB s=
o =

> > it would be good 'reasonable limit' - it's a nice round number and fits=
 in =

> > 16 bits (signed).
> > =

> > The usecase we have is using digital MEMS microphones ((2S connected, =

> > with no integral amplification) and when the sound source is far away, =
a =

> > fair amount of gain can be needed.
> =

> Wow, the signal quality from few bits per sample must be really good ;-)
> It would be better to use ADC with higher resolution (24-bit) and low
> noise floor (but I see the possible costs requirements). This is why we
> have such good audio in collaborative conferences :-)

Ok, I wasn't expecting this kind of discussion on this subject ... =


It's true that for best performance, analog microphones (even analog MEMS) =

trump digital MEMS microphones when it comes to SNR, but in many cases, =

the SNR of the room itself will be the limiting factor anyway.

The point is this: a typical digital MEMS microphone has 0 dBFS output at =

120 dB SPL. Looking at one typical recording usecase, the background noise =

level in a quiet room is 40 or 50 dB SPL, with speech at a distance of a =

meter or so being around 60 dB SPL. So in this case we're 60 dB below full =

scale for the speech signal, with the acoustic noise floor being 10 or 20 =

dB below that. The noise floor of a MEMS microphone of this type is =

equivalent to about 30 dB SPL, so the acoustic noise is still higher than =

the electrical noise in the system.

Now, assuming we actually want to hear what is going on, so we bring up =

the gain by 60 dB in order to get the speech to full scale. That =

means that the noise floor comes up too, and there's not much we can do =

about that anyway as it's part of the acoustic scene we're capturing. The =

fact that we loose bit depth is not of much consequence, as the acoustic =

noise in the scene is above the resulting quantization noise anyway, in =

much the same way that adding dither to a signal masks the quantization =

noise. The acoustic SNR is 10-20 dB so we could actually represent the =

resulting signal with 8 bits and still be fine.

A side note here is that many PC's, especially laptops, do not provide =

much playback gain, so there is a point in bringing up signals to close to =

0 dBFS.

The bottom line is that, yes, we loose bit depth when we apply gain, but =

that itself doesn't impact the sound quality, as long as the noise level =

is above the quantization noise to start with, which it is in many =

microphone cases. And we really might need a large gain in certain =

situations.

On Mon, 15 Jan 2018, Takashi Iwai wrote:

> [ ... ] the amplification in softvol is really dumb, and such a high =

> gain like 90dB is doubtful whether it's really useful.  As Jaroslav =

> already suggested, we need a better setup to get more meaningful =

> results.

In what way is it dumb? Amplification is just a multiplication with a gain =

factor, and the softvol plugin seems to do that fine. I just tested =

patching it to 90 dB gain max, and applying a (24 bit) sine wave at -90 dB =

and amplifying it by 90 dB using softvol, and I couldn't see any odd =

artfacts.

Of course, for the usecase I described, an AGC of some form, or dynamic =

compressor would probably be better, but for a static gain, softvol could =

very well be employed.

Ok ... bottom line ... I'd like to increase the maximum potential gain for =

softvol above the current 50 dB. I suggested 90 dB because that's how much =

the algorithm can handle, and that's what I figured the MAX_DB_UPPER_LIMIT =

in pcm/pcm_softvol.c should reflect. Furthermore, I can't see any problem =

with increasing the limit; it does not degenerate the algorithm or cause =

potential problems for existing users. Admittedly, this is not kernel =

code, but if it were I would expect that the point of view would be that =

the code should not make assumptions on user's policies but only its own =

technical limitations. And if the input is 32 bit audio, we'd still end up =

with about 16 bits of resolution when applying 90 dB of gain, so =

mathematically it's not unreasonable.

The only problem I can foresee is that it means that all future changes to =

the algorithm might need to accommodate the specified maximum gain to =

avoid annoying users who are actually using it, which might be a problem =

somewhere down the line.

But for my usecase I'd be happy just pushing the limit to 60 or 70 dB if =

that's more acceptable.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
