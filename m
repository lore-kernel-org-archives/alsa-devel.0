From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Wed, 21 Feb 2018 11:54:52 +0000
Message-ID: <20180221115452.GD8334@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0164181136570966590=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EE32C267567
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:54:56 +0100 (CET)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0164181136570966590==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 11:15:01PM +0100, Hans de Goede wrote:
> Instead of duplicating the DMI quirks between the codec and machine driver,
> add a rt5651_set_pdata() codec private function which the machine driver
> can use to pass in pdata.

It's not clear to me that this is a great idea.  The goal in general is
to keep as much of the CODEC configuration in the CODEC driver as
possible so we can move more towards generic machine drivers, this is
moving us in the opposite drection quite dramatically.  That might get
in the way of improvements we could be making when we get the component
based changes further on and can avoid having all the DPCM stuff in the
Intel drivers.

It is really unfortunate that ACPI based systems aren't embracing
standards here and using this mess of open coded quirks but it feels
like the way to do this is to keep the code as close as possible to well
designed firmware interfaces and hope that they come round.

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNXgsACgkQJNaLcl1U
h9DX2wf/ceuqRbLLWkCVuVyhqTxB1Tz21zK+5u0WRMP3wnDfwydJcw4hxEEyKkto
CeDB1uTlpYJwEdxzODtGgzF2jQCdRE4T6AfNVYuXmRcdOBISm+/0KzU+3puW6JGa
Hq+e+iDPoCbZPuLHQkfWwyAOuNYCEJB3tzA1bO8UAOXBAtLcOeqYIg/l+NAsU2wy
w8Ds2ScF6gjz8zQYki1CEegCVYIkQVBX4zgW+xwcKKeLo2/sjtbFU11YJf08jjWy
NrXEtx4+pq3WFj4BGk9rbMUk2TrZ0n4FGQMmfvj/KfsrinyjsrZRxfZzg5mBUyGY
7BjaX7tUqpVPqu0g15z3HKzncX62rQ==
=MQnE
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--

--===============0164181136570966590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0164181136570966590==--
