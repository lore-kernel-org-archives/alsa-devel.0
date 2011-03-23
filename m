From: Jan Losinski <losinski@wh2.tu-dresden.de>
Subject: Re: [PATCH] ALSA: HDA: Realtek: Avoid unnecessary
 volume control index on Surround/Side
Date: Wed, 23 Mar 2011 19:39:22 +0100
Message-ID: <20110323183922.GJ13972@atlantis.wh2.tu-dresden.de.de>
References: <20110321113702.GA15206@atlantis.wh2.tu-dresden.de.de>
	<4D87C6AF.2090906@canonical.com>
	<20110321231321.GA13972@atlantis.wh2.tu-dresden.de.de>
	<4D89A7B2.6050204@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2625016748208409608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atlantis.wh2.tu-dresden.de (atlantis.wh2.tu-dresden.de
	[141.30.228.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 3777F103913
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 19:39:22 +0100 (CET)
Received: from localhost (x41a105b.wh16.tu-dresden.de [141.30.216.67])
	by atlantis.wh2.tu-dresden.de (Postfix) with ESMTPSA id DB30E83D0CA
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 19:39:20 +0100 (CET)
In-Reply-To: <4D89A7B2.6050204@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2625016748208409608==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YolNsh7G+K7zsfIR"
Content-Disposition: inline


--YolNsh7G+K7zsfIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Henningsson <david.henningsson@canonical.com> [2011-03-23 08:56]:
> Thanks, I've attached a patch that fixes this issue - Takashi, will
> you apply it?

It works, thanks a lot.

Jan Loosinski

--YolNsh7G+K7zsfIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2KPloACgkQ1Hv7AMjH+2Ey+QCgtq9ufAAaWvtICw6yF2wEzRBg
GB8AnA+ayQTDywbwFh9OVDz/4GVR2w/c
=0Eks
-----END PGP SIGNATURE-----

--YolNsh7G+K7zsfIR--

--===============2625016748208409608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2625016748208409608==--
