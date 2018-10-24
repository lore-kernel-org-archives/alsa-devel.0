From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] Introduce dmic mode switch delay
 parameter
Date: Wed, 24 Oct 2018 14:35:56 +0100
Message-ID: <20181024133556.GR2103@sirena.org.uk>
References: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
 <102a22bc-a054-b07d-23c8-95118d69450f@linux.intel.com>
 <108f2ff1-c000-31ba-0a36-e696a912c6e6@linux.intel.com>
 <20ADAB092842284E95860F279283C564568C0050@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738839030914131564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C3F2678F7
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 15:36:03 +0200 (CEST)
In-Reply-To: <20ADAB092842284E95860F279283C564568C0050@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Tc, Jenny" <jenny.tc@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0738839030914131564==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RyOXVFQXzAE23HDB"
Content-Disposition: inline


--RyOXVFQXzAE23HDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 05:11:57PM +0000, Tc, Jenny wrote:

> The driver already exposes another parameter (wakeup-delay-ms) using devi=
ce tree.=20
> Enabling ACPI device enumeration provides a way to pass existing parameter
> and also cover the new parameter(modeswitch_delay_ms) introduced in this =
patch set.
> Isn't it good to adopt ACPI enumeration if the driver has multiple parame=
ters to handle?

If you want to adopt device tree bindings in ACPI systems there is
already the _DSD based mapping for this.  However please be aware that
ACPI and DT systems have radically different approaches in a number of
areas, including describing sound cards, and trying to combine the two
in the same system might lead to disappointment.

--RyOXVFQXzAE23HDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQdTsACgkQJNaLcl1U
h9CYZAf8DufHj3fKUGF0KQKJZ7vWuRY6nd9Ti2oPYHVcKeSgjqoXZ3L/ZERoFUF3
3njlV1Off1/Ang4t6xMQOo9I62B5PEA5jUbf9dDG5JYfuKm43hdvjDA2uZHOeF3n
Uqz8uEHrEM5jcf11CDYrKbx6klpajlnsFJm9d2j+aIY/+6c4UUCXm5m14saZQDP6
ebJPZQ2uNwPHflJsNc3ESvuOd6ZUUNl2sYyYh4mEpCP3kGw4KpAd+UR12/vQX76z
zwiYWmanFVjI46CDGx2VdnXa+eVMRLiYAR0BqHWciK8paiK+dMrjmRKfx+n/rR25
fkdG5ltswkg5zPEq8g4QIwJCTO6nzw==
=5inT
-----END PGP SIGNATURE-----

--RyOXVFQXzAE23HDB--

--===============0738839030914131564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0738839030914131564==--
