From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Wed, 25 Nov 2015 21:43:11 +0530
Message-ID: <20151125161310.GF25173@localhost>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7393645164463907487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 189D6261AA0
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 17:09:44 +0100 (CET)
In-Reply-To: <20151118134843.GU25173@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7393645164463907487==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9+VnUxDxRuy97YQ+"
Content-Disposition: inline


--9+VnUxDxRuy97YQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 07:18:43PM +0530, Vinod Koul wrote:
> On Wed, Nov 18, 2015 at 01:17:57PM +0000, Mark Brown wrote:
> > On Mon, Nov 09, 2015 at 11:19:59PM +0530, Vinod Koul wrote:
> > > From: Jeeja KP <jeeja.kp@intel.com>
> > >=20
> > > soc_link_dai_widgets() creates codec-codec loopback link which
> > > allows DPCM to trigger these links and program the parameters for
> > > these links These links are:
> > >=20
> > > 	Codec1 Tx (Pb)  ----------> Rx Codec2 (Cap)
> > > 	Codec2 Tx (Cap) <---------- Tx Codec1 (Pb)
> > >=20
> > > But as we try to model a CPU based loops for non host links like
> > > modem to codec loop, the above mapping gets wrong as:
> > >=20
> > > 	CPU Tx (Pb)  -----------> Codec Tx (Pb)
> > > 	CPU Rx (Cap) <----------- Codec Rx (Cap)
> > >=20
> > > So we add a new flag to handle above scenario and link widgets as
> > > depecited above
> >=20
> > So, what I was really thinking of with the renaming was a bigger rename
> > that updates the names in snd_soc_dai_driver and everything that comes
> > from that.  That's a much bigger thing though, let me think about it a
> > bit more.
>=20
> ah, yes that kind of change does make sense, but as you observed that will
> be a larger rework. And I think I am up for it in parallel to my SKL work=
 :)
>=20
> But that will take a bit of time and I would like update these in bits
> rather than one shot
>=20
> Let me know what you think and how you would like to approach this

Hi Mark,

Any recommendations on this, how do we go about this

Thanks
--=20
~Vinod

--9+VnUxDxRuy97YQ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVd4WAAoJEHwUBw8lI4NH0PMP/0ZmxanMurdLYCGtlX1kw4CP
X2Y8GQKnK6O49CMHWq9DarQIYqnbXieu9Y6VZJOtvT85UwzANjq34nJIKtXVwT9T
rGiRNvF99SbOr9szakZ59aVXdIteYDE+i8BHjw29YKP5p34LlkI2kdA6gx3aEt54
NF+JorrFGAzEuU1wNr9mvnd26ZWLPRDzGETA+InjmEBmfrpRDzF4oDq1dNz/34iv
DYCJ/zhGBoSkmhR4bbGElIvnlT4KTDiUdKEcBEukJ9YYYTCA49mkct/kW6adTzc/
aLRYWejf1v53fKIgrnP2tDYoYOU9zVcay8lzN9LsKz5bxXZnSxRVgIBUVVJKi4Ts
A21hKemkaTzdds2YEMIqXwK/LF1FxgbYg+5wvf6iIpIzbT7ds9fRmPH6zRIXlmGq
4cFsRtg3s/SQzy3cMv6BfBRAqZPn1H5F+feDdywXwWZH3HR9pAQrzOToXNj0j3Jg
NikuGViOtAoKCBjDSIP5upW5IHcZDtboLdvDpfrVY5O/42TErfntsQlaNlyftL2j
a4uOV4L42ceNGsObJZevQdH4uCb6tU3OjPi1rZpvupg55fV6di6ApknZQ0y58D3S
IefNuo7mZyasdW2pger4Uqst6nAZso8LLIJq223y6NSpSSQyAaSMKVjAtOTaQ1bR
su4K7a94b9PMBx47MNK3
=O+wJ
-----END PGP SIGNATURE-----

--9+VnUxDxRuy97YQ+--

--===============7393645164463907487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7393645164463907487==--
