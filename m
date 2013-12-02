From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: n810: Convert to
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 2 Dec 2013 18:25:14 +0000
Message-ID: <20131202182514.GP27568@sirena.org.uk>
References: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
 <20131202111615.GL27568@sirena.org.uk>
 <529CE9C1.4080907@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1190161337616013775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0543B2616CB
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 19:25:18 +0100 (CET)
In-Reply-To: <529CE9C1.4080907@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1190161337616013775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zauH5iP2Zn8HCP3x"
Content-Disposition: inline


--zauH5iP2Zn8HCP3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 08:12:49PM +0000, Jarkko Nikula wrote:
> On 12/02/2013 11:16 AM, Mark Brown wrote:

> > That looks like it still means v3.10 and up could use the fix?

> Well I kind of fear linux-stable user base for N810 is next to zero. I'd
> even insist this forward if just one shows up :-)

I think you're right but on the other hand the cost of sending fixes to
stable is also very low and it seems more friendly to help people out if
they do exist.

--zauH5iP2Zn8HCP3x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnNCHAAoJELSic+t+oim9qTIP/jYrNwiqCroJyPA4Qk9t41+r
FARCn8ES0XrJzti3SG+i/WL0wve++1PEruGNoOgBilJTszlX49B/FhIhv6d4zgP9
b4HBlbyltQ3WD1JEZKbD5HaEDpAu077wyEaiR8XAgEKecF84XFN+sKa7YDB8ul4+
zgoiEW2oOY1eX+6kx7M8D8wC6TsSvsJzVX7wLgHW8DrwDvSckn7P96EzZXH4PPGW
z4q3onCja1N3nCljpMCPhQoPjyR0B7nXijKa7wMx/BU7WZU88JKfkiUHQooFuea9
6P0kVdVzR9BbcJ/G/Xw1bHiGN/0JnsDKYla8MmYK5OQfzDYT+7VTRLZFIUs8gi7B
+Yq/AHv0nY6QnXfaaGpTXFg+lOrm4jhIMscKsmFj4MCui1hvguFaH/YMpfMUjlHs
L6rF0fsmHNGo7PcbO8d3t+OAeURiWcSZ/o+o+LH1xCbmUT9ahi+WrpHWJL3OFxIM
0Ztxxr+QW5W5nRDJ17dMu3ZYzXe3gn8PZLC2Axobx8NCx2U9Ya1EGgUnR2pwABef
dVGcyPq8HJN4EuU8v5aWlcrf41HeZtD63slY+a6smLsHXleHi/8DJI20I+ehjjVP
/HDWGgg0Z1AeL25jhmksfS25MKW6hmCaL88ipMJwXg4vxsGSC3uV0cNXJzeui34P
lQ6UE5kMNMNU1K4dTsgp
=dewV
-----END PGP SIGNATURE-----

--zauH5iP2Zn8HCP3x--

--===============1190161337616013775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1190161337616013775==--
