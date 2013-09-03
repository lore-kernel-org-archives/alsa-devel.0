From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/14] ASoC: kirkwood: add SPDIF output
	support
Date: Tue, 3 Sep 2013 12:59:38 +0100
Message-ID: <20130903115938.GA1560@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
 <20130903111720.GF3084@sirena.org.uk>
 <20130903113832.GF6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8451291410715900612=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E90432616C9
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 13:59:49 +0200 (CEST)
In-Reply-To: <20130903113832.GF6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8451291410715900612==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2013 at 12:38:32PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 03, 2013 at 12:17:20PM +0100, Mark Brown wrote:

> > This is still not a good approach to adding a new digital audio
> > interface since it does not create a DAI but instead adds it like an
> > analogue link (but hooked inside the CPU using the DPCM DAPM hooks).

> This is the way Liam's Haswell DPCM driver works.

Liam's driver also adds DAIs.

> > A new DAI should be being added for the S/PDIF interface, this should
> > fully utilise DPCM but an either/or approach would be OK as a stepping
> > stone.

> A new CPU DAI will be a front end DAI.  So what you're saying here is
> that your earlier statement where you clearly said "one front end and
> two back ends" was wrong.

I have not yet replied to the last e-mail you sent last night but it
appears from that that and from the above that you have front end and
back end confused.  A front end DAI should be associated with DMA, a
back end DAI should represent an external digital audio interface for
the SoC.  This means that the I2S and S/PDIF interfaces should both have
back end DAIs representing them and the DMA should be represented by a
front end.

> Sorry, I'm not playing your game anymore.  I'm not interested in trying
> to work with you anymore, because its totally impossible.  You're being
> as obstructive as you have been from the very start, and as demonstrated
> last night when you said "there is no mixer" in Liam's DPCM driver, you
> don't know what you're talking about half the time.  Or, you're
> intentionally making false statements.

I did not say that - I said:

| This is not correct, there is no mixer in the link between the back end
| and the CODEC.

The mixer in Haswell is in the DSP block which sits between the front
and back end DAIs, external devices like the CODEC are connected to the
back ends.  I fear that your confusion between front and back end may
have mislead you here.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJc8nAAoJELSic+t+oim9eAsQAI3q1rfYe7CX2l8FRAeL93Pn
RexaUjkggNsMuBhdqOYJ3mlAR9YiwNPh16leJIsAxesRocq9KXq4O98Saa1utrzj
dolulY1aBx99rvqrHVsiHWZIlTd/PTreOcw8KxX/hQfZVkYcSLzwdq4EGdXSbqbA
GTWsjfAclIMdj78mT26ISIEMTZQBJkJxdfSWfEGHvpOXauMecRMC1IOEhNfqB10A
ES4ssI24Rj4h6MFiOmZ+B97Txl8nL4bOYrwTLKvjuEMc7uufMmkyFeEqTdsBCCSH
ujTlVgECMSFQPlL2BJwYTXnCjnt9AwrtENUGKefk0kdSqJbsg9rtr7YHgpSa8AqD
gSt05wm3UIivYit4JlGqLZphBWyrW7igJUTgVzoC/k2RZ06xBBb6SSIEuNGMukyP
mJCt7zqPcdkrejuPHBUKrw5vu19i6aMqcpP+jxKvpzhWlUeo8o9jFFGWjvo4I7Fy
8ztGGELjAVXT6KYoxLKnfigpgvKo3U/Jd+TzXcHUDPCg30YHYr4MH3cgi1N1mlol
mcltcyt+AFN5+zjqEDvLr38cRkqL5sjhOODyBGUd41pPeC/TQhLUDC9oEu1BIMYA
YPHxBYYCarZtrFGhkhO0/0teYdRLyRDBYZxjxp/lPI2rZy9i+EnsABMRdrBXHaSG
WyaA6ryhDmOlX3voDp5B
=5c5v
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============8451291410715900612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8451291410715900612==--
