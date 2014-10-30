From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: Intel: sst: add runtime power
 management handling
Date: Thu, 30 Oct 2014 18:06:09 +0000
Message-ID: <20141030180609.GG18557@sirena.org.uk>
References: <1414645736-24426-1-git-send-email-vinod.koul@intel.com>
 <1414645736-24426-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5413353442356637636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCBD726069A
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 19:06:44 +0100 (CET)
In-Reply-To: <1414645736-24426-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5413353442356637636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ImbhesNbK26zUpL9"
Content-Disposition: inline


--ImbhesNbK26zUpL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 10:38:55AM +0530, Vinod Koul wrote:

> +	ret = sst_prepare_and_post_msg(sst, SST_TASK_ID_MEDIA, IPC_CMD,
> +			IPC_PREP_D3, PIPE_RSVD, 0, NULL, NULL,
> +			true, true, false, true);
> +
> +	if (ret < 0) {
> +		dev_err(sst->dev, "not suspending FW!!!");
> +		return -EIO;

Better to print and pass back the actual error code we got.

> +	dev_info(dev, "runtime_suspend called\n");
> +	if (ctx->sst_state == SST_RESET) {

Drop this down to a dev_dbg() or remove it please (and some others later
on).

> +		dev_dbg(dev, "LPE is already in RESET state, No action");

Missing \n.

> +		return 0;
> +	}
> +	/*save fw context*/

/* Upstream comment style please */

--ImbhesNbK26zUpL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUn4QAAoJECTWi3JdVIfQbZQH/0sAlaGgdlNzld75LdGk8kQa
kxJemXwi42zOLhGnOErNzaH/YqS/1BVlzhOoEy9ItYV5rJvFdwK08XkJuM7qD4Tg
yuwpZGcbcKcqF4iwFswn5+7TJFpjlvSA+To5Z9+YfKW2F+tw58oVyz6q4/mp3imX
iTT5Tnh6RabK63HIv1RabS0RMtZPrLkXhsFUT2MSP5EK4lSrqFwSA+KBlIqZ8d77
7VGg9jP5e+pRWYAdK2HYJKBJIGm6IXX6359ag0yeutc46ThVqDfIv+V+SKC7tebv
pHJfbLmuHOTaXaLGo6d0Y87UkyQ9d3He5zPg8aHGfAui4YjHxZIKgpdcj94wtqk=
=OnuE
-----END PGP SIGNATURE-----

--ImbhesNbK26zUpL9--

--===============5413353442356637636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5413353442356637636==--
