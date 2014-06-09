From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Make sure register value is in
 sync with DAPM kcontrol state
Date: Mon, 9 Jun 2014 20:57:52 +0100
Message-ID: <20140609195752.GL5099@sirena.org.uk>
References: <1402312829-1163-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7291750314133646138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAC082652B0
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 21:58:07 +0200 (CEST)
In-Reply-To: <1402312829-1163-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7291750314133646138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Khiu2s0Zk5P3S+XT"
Content-Disposition: inline


--Khiu2s0Zk5P3S+XT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2014 at 02:20:29PM +0300, Jarkko Nikula wrote:
> Commit c9e065c27fe9 ("ASoC: dapm: Make sure to always update the DAPM graph
> in _put_volsw()") stopped updating register values in those cases where
> initial after boot state of kcontrol appears to not change but where
> register value still needs update because it is not in sync with the
> kcontrol state.

Applied, thanks.  One thing...

> -	int connect, change;
> +	int connect, change, reg_change = 0;

It's better not to mix initialisations in with other variable
declarations, it's a bit messy and marginally unclear.

--Khiu2s0Zk5P3S+XT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhG9AAoJELSic+t+oim9hZUP/0tc/BS0ozbuByR3B/1rQci6
NKrzvLx2cPKG61OvCoa/4QADGNpkDzWJrtkTODArth3klDG5TPCp/P69CDjglZLp
VnuexqLjCzmqQ76G9bl+rlVCJwSHQ3J2qfwk9Q6LwD76NlLGwKhl+P0kpTvAanbC
/+LoyWE/mT2d8rAhRNlh1nFl45upjeqHvE37wPAqQ2rEyIP2ksCfXIUOsEElBzb0
evp9xhPJYz3KUJ4Ctqsp9OT3yq+ejwdEu6/mVkMh6JwLXlmUR3wLmEp3jhZCybMj
7xg7E3v4kkeineEHqpX0uq/Eup9jXmbYQO5NwJb64FDGNv3klTaT35gd0fAxhDUB
Vwy8r0rx2RHHHDDNBSHhN/ae9Z5hbCafE6lSfanvjPT2m9IiYCTCLwxdvsvLt8Fx
1XWphDXKgIiQc8ShHQU7hO5sXo52H3W55LyCYnnbi64VaJ3wzg1LNifK4d1ZgZRS
j4rMUdVFbODeh12Z3B6IoyAigDCYcEk83PctVWwIsqN5xqOObZKGrwhUrU1O7BQf
UPlMxI6Y+ZEIe9OGgpNc/gIyU6BGk6OcyOGbkmgslzQ0cOwCJI//vuhEjTadIdVE
zsLhmA2RzNcFWtlZcTOYXwEVfIkm1lv8+oImTuQBy+cMBdPUBXyS3gPxYYBmyrbO
FHes0Puujg07EB7ntRTC
=OgcW
-----END PGP SIGNATURE-----

--Khiu2s0Zk5P3S+XT--

--===============7291750314133646138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7291750314133646138==--
