From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tas6424: Allow disabling auto
 diagnostics for faster power-on
Date: Tue, 24 Apr 2018 11:19:53 +0100
Message-ID: <20180424101953.GA22073@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
 <20180423154411.GK19834@sirena.org.uk>
 <d6a1c01b-7a9f-423f-d314-ff2e52aa9ab9@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9024464989625510573=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5414B266CA1
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 12:20:04 +0200 (CEST)
In-Reply-To: <d6a1c01b-7a9f-423f-d314-ff2e52aa9ab9@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============9024464989625510573==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2018 at 09:00:18PM +0200, Jean-Jacques Hiblot wrote:

> I can't think of anything that would make it unusable.
> This auto diagnostic is really useful in cars where wires can get
> disconnected or shorted to ground.
> In quieter environment it may not be as useful, and a test at startup may be
> sufficient.
> Diagnostics can also be triggered at will.
> Do you think a sysfs interface would be better suited to disable the
> autodiag ?

I'd just make it an ALSA control TBH.  sysfs should work as well though.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfBMUACgkQJNaLcl1U
h9AmdAf9G2hWHGY7WD/hfxizWfpUaXImjYIXNKDx+C5ZRJNzNR0J34RRiOi4l7R9
PCD9FYNShJiWygRKrE8XhNbLouhXw6M02W+7zjD2Hj280TLTbg4JcH/IpwPvgwER
ZWiRyWLsm5CY/TwM9HqBhDTfSZWZuC3hLK9fWezm1HCkFGZyQA1b34Bg/7ZdNbDH
rRpL1vN7cWoNiESP7GPikmCDyVI8sU5BPV6mfu9yW1C72wcsy6KTZ+uTRyKc9F1z
qXsvHUpQtwktIDPXe+u1BKbRLO69y/unfgrF97ANFii5ziWYLh3lLwUg9ZSTbM9R
PL7Nuh2gZaZJIilyxvbiHg7pfuGkzQ==
=2PQK
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============9024464989625510573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9024464989625510573==--
