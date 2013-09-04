From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Wed, 4 Sep 2013 20:33:53 +0100
Message-ID: <20130904193353.GA3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
 <20130902204421.GW3084@sirena.org.uk>
 <20130902211830.GA6617@n2100.arm.linux.org.uk>
 <20130902223500.GA3084@sirena.org.uk>
 <20130902230011.GC6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2544207999584552280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3748E265560
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 21:34:08 +0200 (CEST)
In-Reply-To: <20130902230011.GC6617@n2100.arm.linux.org.uk>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2544207999584552280==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pI6hLdwVzam1XFuA"
Content-Disposition: inline


--pI6hLdwVzam1XFuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2013 at 12:00:11AM +0100, Russell King - ARM Linux wrote:

> > You should have one back end DAI per physical DAI.

> What do you mean "physical DAI"?  Do you mean "CPU DAI" which would be a
> front end DAI?

The same question got asked and answered in another subthread but for
the record I'm speaking here about the back end DAIs - there should be
one for S/PDIF and one for I2S.  With DPCM there should also be a front
end DAI for the DMA.  I've cut a bunch of other discussion which was
duplicated in that subthread.

> > Unless there is a need to actually take some action you can, naturally,
> > provide stubs.  You should provide the minimal set of stubs required for
> > operation in your testing.

> That needs to go in the ASoC code though - I don't think I have access
> to the ALSA PCM which has been created for the backend DAI(s).  Remember,
> the backend DAIs are "owned" by the dummy DAI driver, not the CPU driver,
> so the CPU driver doesn't get to see any operations for that.

If you need to define operations for the dummy driver then modify the
dummy driver.  However as indicated in the other thread you should not
be using the dummy DAI driver for the CPU side back end.

--pI6hLdwVzam1XFuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJ4sdAAoJELSic+t+oim94GwQAJGQ5ONMzbms8t5vdBGZdidL
10LPvE4ByYpnbPuxEsGY0RjHPZSsSj3B9JWQzw+NGXx/4ffa1k20n2os/SX2beGc
5s6wq1PvN8jRfkiAjXqwriQcdIZJRCuWNhQkN20iHWuKMqqF51zyyWgEtu9pQCDt
US6q3MTE0VUEUZ5qBXUGD/8/CzF2R7ktLZArrd0fG7cgVSbkFwWnPndHcmo+dVWp
fccPMyoK8UA9xx2VQESMBj/PqoPZ+R7F5QppzuIU1B9leiq8iR7Sl5qJ6IJWVSNQ
RjgRcmxSno2MSInqMfrnFFbYuvmR30yWyI+tHu6RslEDSAbN7Tm6Nl01u8/92Kgt
EK1Kch5JBShMuYkJOz5K88B0E7n8hNUz2jWy61qV6og62K1y0NiEu3TsWiXrl+bO
DgdyBVd19NmLbwY2GEdoj2FohcIBK7EBJstDM4qQkzkDHPljz2XWIgXx3koTxINi
psYsMi4ygx0b4flUvZwfUp/amjlNwlOKyubT2CSstksjojivqV1nwBLgjnbahkIc
XRmhzx7MGpL+uPhA45Bsw9nH9QIlnkPRc3foqWNA80iCTmLVuwMw42IxJd5stDod
lNlhIHl/ZzmtbX419pYJ+Qba9e3bFG2UUtcfJGSZDKLLxR6K5sBSyl3Hk/ycdAvQ
JyQ7jtzlMdHNwolFhtXo
=ZtoB
-----END PGP SIGNATURE-----

--pI6hLdwVzam1XFuA--

--===============2544207999584552280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2544207999584552280==--
