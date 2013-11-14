From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/20] ASoC: davinci-mcasp: Support for fck
	reparenting
Date: Thu, 14 Nov 2013 11:51:10 +0000
Message-ID: <20131114115110.GH26614@sirena.org.uk>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
 <1384421737-4467-20-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7169386735074429693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D9CF26170E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 12:51:16 +0100 (CET)
In-Reply-To: <1384421737-4467-20-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7169386735074429693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:35:35AM +0200, Peter Ujfalusi wrote:

> +- fck_parent : Should contain a valid clock name which will be used as parent
> +	       for the McASP fck

I'd expect this to be specified using standard clock tree bindings?

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShLkrAAoJELSic+t+oim985sP/0rwpWA4DhMqXh6uAxlDqilH
DdO1oMJYjyePInwIdrrh2KDAqmchnyXo8u38KxT0iANPvQVx74+3LUBAkUdasl0v
LCraswNq+QcoEnYRjXHV4oN63MdnsXOTW+rlx3JkH7rzAd9xlW3XWfEP0cqOo7St
Pi+2jjDWnOYZ6EBjZiMOLutwdQUhVG2V4mHFY9qJXqDnDIaUXh6ATjEkDCMk/hGY
sgPNY9lRO4027bto8B8zUeuMaZ0iQB4EBJbI2AM5y3Ciidh9Mbbxd+aK6hTalTfY
qa0j8CaPEEAXiKGtWvt0KbFF/S7MI5HUQvSGUqPrs8TqrpeIAxicqOS0Gb7eVgjX
Ep/nN75NQiGDsGxAHHTORHsHLMbxPnGkZHUi1zs3iyvrgEDrUZLjU578CF81H+ns
UNqX2ilaDz0cJsbLFJsW/pe/TNY8OaNAx7HqJmeVzB5b0txhQS7aMddwMf4l5Z6f
iJB4xjN4AVL6YQooNL+vBv5/4C6U3FPyoPKr3ePM6DnD2U5UuUbyljbwOLDmj4vm
bYe1mZAbPB8mQQ7esVkPi5Ee3pAIZ3TMA4wZMrUc/5dCj1vCn6Bj6Xs97S6CIsIN
WlEm0KXEQFnF0PKfu8SBeA6KXFqGaRs62YOGxSgiDv7rhoRvcvDEG9y0Svn8ol1k
UqyDQoDSK7JDzRSAipjX
=AGUQ
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--

--===============7169386735074429693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7169386735074429693==--
