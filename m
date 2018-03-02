From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix cht_bsw_nau8824 machine
 driver build error
Date: Fri, 2 Mar 2018 11:32:17 +0000
Message-ID: <20180302113217.GD6255@sirena.org.uk>
References: <20180302102258.10081-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4047537798998417867=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E35BD267377
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 12:32:22 +0100 (CET)
In-Reply-To: <20180302102258.10081-1-hdegoede@redhat.com>
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
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>
List-Id: alsa-devel@alsa-project.org


--===============4047537798998417867==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02, 2018 at 11:22:58AM +0100, Hans de Goede wrote:
> The cht_bsw_nau8824 machine driver is passing snd_soc_codec to
> nau8824_enable_jack_detect(), but that expects a snd_soc_component
> as argument, causing a compile error.

Thanks but John already sent a fix for this.

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZNkEACgkQJNaLcl1U
h9DVywf7BJR9YdZt5J5QdKGQaUPeMa5CN7Xwtpa4ueXhfTTASK6uORHoqFF9bEp1
yz7zHEVTKV0Wk36Cw9agQsw1u+9nYhN2iBxyh5SgYV+oMgkIoG3AOOw+RXvHPS59
iCtk/x8P0BkBAI0k1dNm3xcbllGyyFZFd0mHAYqWxEUpCxENtsPfRhenSPEZFhDD
vAE8xUjvorrmKHgt3GPy6675AZzCP2PSgonWjMZKWrFt2E5ZZ48i75ra1udyPet5
c5yEttRsJD3mnrNKNLrGKqrv/r/EQfa91LiLLBL5SaGSZTCgIWszQjwFpbfICdz6
YCklNYMvEbgVSHpSPjPvZKAND8BwQA==
=2EA6
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--

--===============4047537798998417867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4047537798998417867==--
