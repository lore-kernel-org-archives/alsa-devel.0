From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/9] Add DSP topology management for SKL
Date: Mon, 21 Sep 2015 09:33:53 -0700
Message-ID: <20150921163353.GU30445@sirena.org.uk>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <20150903081454.GU13546@localhost>
 <20150911114500.GK12027@sirena.org.uk>
 <20150919165612.GA32072@sirena.org.uk>
 <20150921035739.GH2381@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3225473529726706022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E74EB261519
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 18:34:29 +0200 (CEST)
In-Reply-To: <20150921035739.GH2381@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3225473529726706022==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mIJwGTFTwAlEXlA"
Content-Disposition: inline


--7mIJwGTFTwAlEXlA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 09:27:39AM +0530, Vinod Koul wrote:

> I wouldn't have pinged but had been more than few weeks so was wondering if
> this got missed. I did realise you were travelling and merge window came
> up, but still thought Mark's typical turnaound is 1-2 weeks so was expecting
> something. I do understand this take time but no harm in checking if it is
> beyond usual window one expects.

I'm also not going to merge large patches which have wide impact close
to the merge window and I don't tend to review things without a view to
merging them, especially not things that are more work to review.

> We did decide to use DPCM, DAPM and topology here to solve manging the DSP
> using these frameworks. yes hard coding a simple mixer and two pipes could
> have made code look easy to follow but then we would be redoing those bits
> as we scale these to defferent designs.

Sure, and my point here is that that this process of redoing things
would most likely be a lot faster since it'd be a lot easier to follow
which would make the review a lot easier.

> And to provide what we are trying here I have attached the SKL Topology conf
> file to give a picture of topology we are trying to build as a reference.

I think you missed the attachment here...

> Also where you feel something is missing please do ask. Sometimes things are
> perceived intuitive for us as we are doing this for quire some time but
> may not be so for fresh eyes :)

I have been doing this mostly but it's easy to miss things without the
picture of where we're heading.

--7mIJwGTFTwAlEXlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWADFwAAoJECTWi3JdVIfQ6nsH/2sr1zX7foebByxIWyfOS+pr
ulJ1WzSkfY/FfIBbFXewvekijdfD8vIaLuU71ojWlOToljAO5C19M7iY4pvHfkWw
lgbEMq/6NwngTOJ3In841+mod07QKClzWKx5dzmQKBYf7Ik663TdL3NkTpeUqKDc
X7s9txYhlU3v29wfhi2kkm5bnhF9EfjyYEjMsE2fWBYI0MKjZea9l3ArB6n5K/i9
xChwKXmxYprScVGYAWGuzyKBtr/dlV+9cSvisotuLv2V4zuzyf8DiUlXaWihafTl
zrt9fGA/M3anxts8OWVzuOKPctpWJJvPzrhg69me2J4j1yi/vob24hoprT6Z3Dk=
=0AVr
-----END PGP SIGNATURE-----

--7mIJwGTFTwAlEXlA--

--===============3225473529726706022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3225473529726706022==--
