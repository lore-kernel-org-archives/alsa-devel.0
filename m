From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: davinci-mcasp: Add
 overrun/underrun event handling
Date: Tue, 11 Nov 2014 11:02:27 +0000
Message-ID: <20141111110227.GT3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-7-git-send-email-peter.ujfalusi@ti.com>
 <20141110185814.GE3815@sirena.org.uk> <5461BF11.7050506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0426083894665978648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 632F2264F36
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 12:03:54 +0100 (CET)
In-Reply-To: <5461BF11.7050506@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0426083894665978648==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hfrKWVwgcCUHJy30"
Content-Disposition: inline


--hfrKWVwgcCUHJy30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 09:47:29AM +0200, Peter Ujfalusi wrote:
> On 11/10/2014 08:58 PM, Mark Brown wrote:

> > This will unconditionally report that any interrupt that gets delivered
> > is handled and acknowledged regardles of what was reported.  This isn't
> > ideal, I'd at least expect a warning to be printed if we're handling
> > interrupts we don't understand.

> The setup code only enable interrupt generation for XUNDRN for tx or ROVRN for
> rx. If we receive the interrupt it is because either of these happened.
> We are not yet interested on the other bits in the status register and not all
> bits are signaling error.

Sure, I'm sure it's fine now - the goal here is to be robust against
future changes.

> If we would have prints for other bits, we should have at least strategy to
> deal with them.

The strategy I'm suggesting is to either log them so people know what's
happening if they do go off and can go look at the code or not handle
them so that the generic interrupt handing code can provide a default
implementation of that.

> At the end of the function we ack the interrupt to the HW.

This is the problem - it means that if they do go off they're silently
ignored, and if they start screaming for some reason we don't have
anything in place that will handle that.

--hfrKWVwgcCUHJy30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYezDAAoJECTWi3JdVIfQ/xUH/ixVA26sCNi3RcK+P5HhvvIa
aS2Y1pEwVd5M5mSUsFOiiTyDs6llRvlCKpil1QyAiX5gW7JeFTkDHqsObR4colPY
19Gq1t49YbrMWsmDhFTIhQ4x/8/GVsEIvqp/irYkhJlO/5WaF7K64Qcb0uYByWiS
ddzXT79RnmIPwlx6ZlmBUQDKgOkvRY2V2XG0f2ZODHf9VzzN/OsZKWwFK+U6rM5B
o2Wckw+5boaSycp+dOXzqd0is3YUWAGQh7VjjQV0qM2Bb/q69NRzIgYZ2/SqfpE9
kiF2HNTG5sI5zwarqw7/dwI7M0twR1POxjJcnLJ/T8BX2mLn44o3Kr6zV8GHeSA=
=auqB
-----END PGP SIGNATURE-----

--hfrKWVwgcCUHJy30--

--===============0426083894665978648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0426083894665978648==--
