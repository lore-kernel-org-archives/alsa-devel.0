From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] A question regarding open ioctl for user
 space in ASoC driver.
Date: Tue, 20 May 2014 12:30:22 +0100
Message-ID: <20140520113022.GM12304@sirena.org.uk>
References: <20140516105939.GA2544@MrMyself>
 <20140520001834.GJ12304@sirena.org.uk>
 <20140520044323.GA10471@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2351068181331193611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77BD1261A99
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 13:30:39 +0200 (CEST)
In-Reply-To: <20140520044323.GA10471@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2351068181331193611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8UlzpBRbXzws3PGf"
Content-Disposition: inline


--8UlzpBRbXzws3PGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2014 at 12:43:24PM +0800, Nicolin Chen wrote:
> On Tue, May 20, 2014 at 01:18:34AM +0100, Mark Brown wrote:
> > On Fri, May 16, 2014 at 06:59:41PM +0800, Nicolin Chen wrote:

> > This is moderately common in mainline already.  You shouldn't need to
> > have any custom code - we should just be able to figure out that the SRC
> > is needed (and a quick glance at your out of tree code shows now ioctl()
> > so that's fine as you say).

> I was thinking about just leaving P2P as an initial version and reserving
> some essential interfaces for M2M function so that I can add it up later
> in our internal branch or we can figure out a better approach in community
> style. And now, it looks like a good idea for me to try this way so as to
> move on quickly.

Yes, that's going to make progress faster and it's probably going to be
the most commonly used bit anyway.

> > > 2) M2M, memory to memory, can simply make ASRC as a sample rate converter
> > >    without playback via any BE sound card, just like using any software
> > >    to convert a WAV file in one sample rate to another WAV in a required
> > >    sample rate. The driver has its self-designed application to compelte
> > >    this function by sending the audio data from a wave file into a misc
> > >    device via non-generic ioctl:

> > I would expect this to be handled by just routing the audio between the
> > two front ends using DAPM/DPCM rather than by having a new kernel API.a

> Two front ends: one for ASRC and the other is...? And how does it transfer
> audio data with user space?

The front ends are the PCMs userspace actually sees and not usually tied
to anything except by routing constraints in the firmware/hardware - I'd
expect to see one available for each side of the ASRC, I guess at least
one of these is just a normal audio streaming FE used to route to the
back ends.

> > If nothing else representing the ASRC block as a CODEC would do the
> > trick though that doesn't entirely play well with DPCM, it is kind of
> > doing the right thing though in that the ASRC block terminates two
> > digital paths.  I'm not loving the elegence there though.

> Sorry I can't understand this CODEC approach either...

> Yes, ASRC has two digital ends but each of them is just a FIFO register
> , input FIFO and output FIFO, waiting for DMA to handle the Tx/Rx job,
> not like a normal CODEC that has DAI outwards.

Right, the DAIs in this case are just connected back to back inside the
device like if you looped line input and line output together in a
normal CODEC but without the DAC and ADC.

--8UlzpBRbXzws3PGf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTezzLAAoJELSic+t+oim9ke8P/j+PAryTSMZTnLDcjOQcS8st
MPl+xKvhWzCvQQbmLlFcef7KodHRS2ofPX+pwoUhOJnJfL0nesoJ/P8wu8+2aBeu
y+4Ww+X+EjAHFPbgzxuBWmSh6xjcP35RBsY1+jmR5TulwszwXJ+IJtQ+NQnpkzJo
E41uLDJ6AmLdwitD/KUBx73XkYjaaMt4qMhn82vVvQoHQNbiaRgiEG3SlmpzjRm8
A4cUie+E9nrCBL2LGbubamhVaW4SZCaGrcCo7MH47KmWKzQPn9onAsjzqedOMOaM
ug7Tnn6avbJimt+0+NEkml4YTWI23AVOCYPvA0TvGoVbzwHhgdBN6UVq2MrmZEoi
fJ3a6veuSbOggho0YZKi45nKDDzlkrdxDRRNHq2QMoKr380bnejyyaF9F0J+2IO5
zNC3og7O3dnTdtH6vSylkwkkSp78UnUVpqAbBia27I/0d4YSC6mQDlJ7PmhP14lC
EVVZaMO9bjUA5IKknat9dCmRbpkiymC8hhmcGnxP8/Haa5eSBGPTdAvRwHbDC8tp
k1RElIcUS4FyPNF9Y+4DOaMvSH3/21a5wnjv3ddX9K7XqTgKX/vcUUCeWlvi/9KA
Rhyan86j0Tz0bEWwzHwbEv2JpWAN94XgQ8LG5FpTamh1sYT65pnvsXhWLjK7prt+
T8kUVLN5CnfCibaQV68z
=UZRP
-----END PGP SIGNATURE-----

--8UlzpBRbXzws3PGf--

--===============2351068181331193611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2351068181331193611==--
