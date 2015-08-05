From: Mark Brown <broonie@kernel.org>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Wed, 5 Aug 2015 10:39:05 +0100
Message-ID: <20150805093905.GF20873@sirena.org.uk>
References: <20150714150352.GW11162@sirena.org.uk> <55BC772C.50801@metafoo.de>
 <20150803032128.GO29916@localhost>
 <20150804161335.GW20873@sirena.org.uk>
 <20150805025603.GE11789@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3268761104748288982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78F63261515
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 11:39:21 +0200 (CEST)
In-Reply-To: <20150805025603.GE11789@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3268761104748288982==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y3pDWE12QfphwjBl"
Content-Disposition: inline


--y3pDWE12QfphwjBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2015 at 08:26:03AM +0530, Vinod Koul wrote:
> On Tue, Aug 04, 2015 at 05:13:35PM +0100, Mark Brown wrote:

> > That'd require us to move all the DAPM information for drivers out of
> > the kernel and into userspace which seems a bit worrying - it's going to
> > be harder for things that need events and I worry about the effect on
> > quality of implementation if people stop sending things to get reviewed.

> Not for this option, for example in SKL.

> kernel doesnt have toplogy information coded in, it is parsed and build from
> topology binary which is built by alsa-lib. So if we add more alsa-lib APIs
> to parse the installed binary we have good view of system without going to
> kernel, we know complete graph and controls...

That's a specific case where the topology definition is coming in with
the actual implementation.  For CODECs where things are in silicon
things are a bit different.

--y3pDWE12QfphwjBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwdm1AAoJECTWi3JdVIfQ+LoH/3ai2GLA6rd4VvTdTqJWZX4k
k+6K5A8GDZGsAFkd877mhRLAV93MZO0OOeLQYESV3WPreN4gWtGjgWpVeje3w+BO
oD6WDCIXh5fGSUxWjiQc/tzgyI1kOh6nun5kojWy21oJ8KNg919TDUKEvj73LmxO
u71NG9mqRFnf/UNORzvjbG9tF6hI+vtr/34NbZxQE24kMfhneqdWKbt5BU60MBTO
IHapugowWwsC54SWQOdhcZ51uqlVbuiIWXBZnma0+p4SlQcML+soUppcpKZnVanB
OqB7D+RaTJXMLqKcRdAPWLQG1qLyzsI9dEEZMyauLcLnv1nuKc34610TodtyVds=
=CArk
-----END PGP SIGNATURE-----

--y3pDWE12QfphwjBl--

--===============3268761104748288982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3268761104748288982==--
