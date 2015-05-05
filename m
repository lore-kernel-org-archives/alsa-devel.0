From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Tue, 5 May 2015 22:49:02 +0100
Message-ID: <20150505214902.GG15510@sirena.org.uk>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7838249371051971892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D62D260492
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 23:49:11 +0200 (CEST)
In-Reply-To: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7838249371051971892==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VRRZwUeiQeu7kZYj"
Content-Disposition: inline


--VRRZwUeiQeu7kZYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 05:19:20PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> rt5650 codec supports 4 buttons detections so enabled it

> @@ -43,6 +43,7 @@ struct cht_acpi_card {
>  struct cht_mc_private {
>  	struct snd_soc_jack hp_jack;
>  	struct snd_soc_jack mic_jack;
> +	struct snd_soc_jack btn_jack;
>  	struct cht_acpi_card *acpi_card;

This is a bit weird - why are we adding an additional jack here, surely
the button is attached to the mic jack here?  The jacks should
correspond to the physical jacks on the system rather than the function
so that users and applications can tie the jacks that we have in
software to those physically on the system.

Now I'm wondering if the headphone and microphone are expected to be a
single jack here?

--VRRZwUeiQeu7kZYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSTrLAAoJELSic+t+oim9po8P/11m/8ErPjGeOkBXrr4IVUPc
Txyw3+Fl6JGwTSzs3cm03xmXBJd6Ojs0zRE3RXuN3fYuFMAcxmgQnezag9RF2Idm
jGne/ZCRaejMaBE2uNJnaDmAFl8O0WHKZaA1rrcHlwRkG9A2EhDtgb0yPKZxN1F9
bFBjJtDqCAqw2NF4333r2qscVADenmtnEAIW0/UNAeCOYNg+7P9UM+sBVVc81sXX
Y90wkgWexrv02CykrNyz3kfOL9Pa8uPslE78EzkCEaBaMK2bL2j0hU8Z7WEXw1+g
XwyrHM5fsmP/Skm5NM4FCR5onhF0Mj/ZsJUgbfh94KF0rqs5CS0mjJAdz3DZ8xCQ
IWXxdsqbXGdnICwc1VDa9PL6yZmlw8WpFTig8pamSPlRdG3SMxivigoof3EG+r22
QtHcDptvfFRLgwgw1s0SXl6+VirWktmJjy84Zt+Ml7nylrc3HJdIun32Kzm4Iuho
rMEA8ca1wjxrp28YKmukP/xpHOyyHwHFP5Mr0uYtkNSlCgKlqYE2sW3CId0g8P03
aaAym5Rq9fl8V/ILG3McF906OJzFWVGMXI9YENXgN55lTrfo8tRsRsRhJ0e4rtLl
EeUTNeGQDZJ2iP+uY5/1PNk+zvV4JqhUEfX9Hu7KE0BrZdv3hs+O92p5ksOGw8nO
Ns5h7hxVEjf9VC3Bjjlz
=64qG
-----END PGP SIGNATURE-----

--VRRZwUeiQeu7kZYj--

--===============7838249371051971892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7838249371051971892==--
