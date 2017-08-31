From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6 v3] ASoC: AMD: Audio buffer related
	changes for Stoney
Date: Thu, 31 Aug 2017 12:27:27 +0100
Message-ID: <20170831112727.rsqk6kiiakn6xb5k@sirena.org.uk>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <1503079830-16072-6-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4112981904083623036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 32807267217
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 13:27:29 +0200 (CEST)
In-Reply-To: <1503079830-16072-6-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4112981904083623036==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jlj4fajhflrc3ecs"
Content-Disposition: inline


--jlj4fajhflrc3ecs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 02:10:29PM -0400, Alex Deucher wrote:

> +#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
> +#define ST_CAPTURE_MAX_PERIOD_SIZE  8192
> +#define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)

These defines will go wrong if the capture size is changed independently
of the playback size.  Either just use a single define for both or have
separate defines for the maximum buffer as well as for the period.

> +#define ST_MIN_BUFFER ST_MAX_BUFFER
>  static const struct snd_pcm_hardware acp_pcm_hardware_playback = {

Missing blank line between the defines and here.

> +	if (adata->asic_type == CHIP_STONEY)
> +		return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,

As I've said previously it's better to write these variant checks as
switch statements, that way if more variants appear (or special handling
is discovered for existing chips) the code can be modified more cleanly.

--jlj4fajhflrc3ecs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn8p8ACgkQJNaLcl1U
h9AneAf+JyzM8W/whRquV7oxf5g6K5o4KublyXowFGWfvySrletHk0HY63dk+Xdv
WIeNgQlI1j3yQLW03LbPz+FfTdjRRyrm887jCFIxjulAujY3p6pAJaDVaPLabLKG
x1bCfdvRM8T18Yy+yzvUKidBNj55Eu0QDdFCyUBCW3O21Zp/b4AnXotWJnNU7nJV
Dq2KkMU8pIA4LM9DfD/9VtH58j8nKiCOoHdYSB/L54bUmM+4Qf1sHnpXUd1H+rJn
+lx+lWhvarayUZuuGE972GeN7XU1lLYbVxGSutRuEl0q9xe5Kuk+Yv3n9AlVSgGk
zNK25rrl1G9OOw4ZeiJcF9QySRbosQ==
=CR21
-----END PGP SIGNATURE-----

--jlj4fajhflrc3ecs--

--===============4112981904083623036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4112981904083623036==--
