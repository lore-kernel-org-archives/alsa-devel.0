From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dapm: Add support for virtual
	mixer controls
Date: Mon, 7 Oct 2013 11:45:20 +0100
Message-ID: <20131007104520.GF21581@sirena.org.uk>
References: <1381059831-16074-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4955883110948639450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B092265063
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 12:45:26 +0200 (CEST)
In-Reply-To: <1381059831-16074-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4955883110948639450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 06, 2013 at 01:43:49PM +0200, Lars-Peter Clausen wrote:
> This patch adds support for virtual DAPM mixer controls. They are similar to
> virtual DAPM enums. There is no hardware register backing the control, so
> changing the control's value wont have any direct effect on the hardware. But it
> still influences the DAPM graph by causing the path it sits on to be connected
> or disconnected. This in turn can cause power changes for some of the widgets on
> the DAPM graph, which will then modify the hardware state.

Applied, thanks.

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUpC9AAoJELSic+t+oim9NUEP/1645B7cgJ7Ep+PxICsAe4qn
JVT2fMDzJ/qlT7JxPze/c2A7yzMi3uM4OnSmltUstSGcqiXIKxhBBC/nlDy3mpSm
iqP7Pirsgb1aXATlh8+ooNT1FaOAG5jbikFGKfBqvXiZqPhgG+9/1zjwsRpivFPs
YNy8P1/gF5xKzzaaF/7BNVe4BWa0Fhew6dL1p3NplaJAYghwPYJQJWSPQSx+N8n7
/piH0wgezfOLD5tYMSZvMl1SVRNqc1LZ8FT8kUge3uyx2PJQX/sURP2hKU22Gz06
gY/kAX+amhmV1Mu4rvrroKQSERrA16ktcSES50rYJnfCh/99BbX9mM6arjQ5gSmv
iUaIJTMq2IK+RQWSxCyKLXEIN+tnNwpcW19xFTvVB4ugmbRaSp8appEUt2UjqgMH
WYonw5jNUpjlV5RtNYmIU5U+hnna0m8kcMvILJ+PnjmM4V9Wc798azwqlNT9H+Mx
FssfOowbesGs9RPMh2MfeoChRqLfGnEuU7AvQgUw06p+tOwfm0iKf/QKQyheSwb5
o284wKShatsdQPWxU8HMicnw4iojXEXQdeg9m5EoQURzo++npiFHvZWvteqInh+t
dMa0+0sNUEHVY2ZZWlzPFasGmPdZdhYy+5faxPGETrB1PbXUI2JP0cuFbUdhS1e+
FWZnGqVfK43Hl6bHnNkS
=Yioy
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--

--===============4955883110948639450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4955883110948639450==--
