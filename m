From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: Use the platform data for
 DMIC settings
Date: Mon, 31 Mar 2014 17:05:08 +0100
Message-ID: <20140331160508.GU2269@sirena.org.uk>
References: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
 <53359DDD.7090900@wwwdotorg.org>
 <20140328234659.GA21628@sirena.org.uk>
 <53398D7D.3010507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7342476379394424687=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4628326513D
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 18:05:26 +0200 (CEST)
In-Reply-To: <53398D7D.3010507@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7342476379394424687==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MljkYTiQARTYtn+v"
Content-Disposition: inline


--MljkYTiQARTYtn+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 09:45:01AM -0600, Stephen Warren wrote:
> On 03/28/2014 05:46 PM, Mark Brown wrote:

> > The driver has no DT support at all at the minute but if it's being used
> > on platforms using DT (which of course it is now I think about it - I
> > just looked for the DT support when reviewing) then yes it should.

> The driver doesn't have an OF match table (I'll send a patch to fix that
> soon), but certainly does support DT; see rt5640_parse_dt().

Oh, dear.  That's not clever and we do need the IDs adding, that's the
baseline thing needed for DT support.

--MljkYTiQARTYtn+v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOZIxAAoJELSic+t+oim9QCIP/iWkOLGFtWm9gyi4YJnfuGP4
CNWObHsAVBxsV+FuTk/PD7HZ/+aew8YvjPmtM/SpKjp7xg8TKzVBVGJ5wCHxzy8D
EBx+jBWeZ2xBviZeh56cQAZ42dfX0Yronr6oyThgeO6IKPF2OVPI3fDrAEo2c+RZ
X02c8J+rLK6lrT09VxmzQx4V16NuJW62OAovPPxwaIgwat8Nw98LDlLKcJDJP4d9
GXwCMCupU69z3lv8s/Lmj3EnuwqHfvZ9KTSU/PoJcz8PO+D0rfxRgjJfDxFuq7Pw
msyTyTv11PQIorlabNfdEY9xbTI0vLPygaxNwXuhKl4ChfNTHAiVu+3qEmq64gNg
jooEiG2Ru7F97814RHPkew5nDBT0iu2XJ3U57N3toRqvV8JwMHMTnzIhEWa93cKi
A8o4yzhCyKTwmaK8BmaF+uDS0hWc93BkGIVFNiQ3m8XrjYPioKFuoB/Y1pbGmBKo
SKuKrb/EiWPPapyFX9zHRuCD42q8yR4XbyI3wIaVbG1XJ1aiWhJ/D5aVRFShjyEg
DsoKtj7qMkwGT8l5dUyA5woHCK3rJS/0WNEppJ3J4tQkdGi7jNaoFNGN7fQIbusH
HKvoC1t8E6ORseekon8sk//WIIFQ6T1f5/4yT8yCLsy6PUQJUf8TUMEhVwsaSDfk
jjIGqEAVXB17R7u1s9SV
=2PsW
-----END PGP SIGNATURE-----

--MljkYTiQARTYtn+v--

--===============7342476379394424687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7342476379394424687==--
