From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/12] ASoC: dmaengine_pcm: support use of
 generic DMA helper
Date: Fri, 1 Mar 2013 18:23:22 +0800
Message-ID: <20130301102320.GV25302@opensource.wolfsonmicro.com>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
 <201302272102.40811.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7693099496401100438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 648F7265DC7
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:24:05 +0100 (CET)
In-Reply-To: <201302272102.40811.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7693099496401100438==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L0mHLbha4YKvhGtu"
Content-Disposition: inline


--L0mHLbha4YKvhGtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2013 at 09:02:40PM +0000, Arnd Bergmann wrote:

> I would actually prefer having a new API in the soc-dmaengine-pcm
> module, like

> static int dmaengine_pcm_request_slave_channel(struct dmaengine_pcm_runtime_data *prtd,
> 						struct device *dev, const char *id);

> For sound drivers that are fully converted to using DT, it would be
> a more natural interface to use IMHO.

Yes, please.

--L0mHLbha4YKvhGtu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMIGQAAoJELSic+t+oim9zAoP/A+KanF8hADSmRaMRjUxGDnI
x2C1faS/5lY15FIKhWNmtEpWdzmzJ0pMlA6gFxoMk6OZx2aYiNJEkBE4yq4PZTk5
6SAhshlJQQ13dutbY8d0547XVeyXiV1oE5cvP41jmOn/FdABAFA7Ja5Tetmom5lS
ef7Hqkzsv2rX4ck+KafHtN5hBAojzhr13sEaTRSRdGrpW9N70sGm7qp6kWi1ugsZ
fnrRvpYB838lzbvOHP2nygrLp+yZD5gWkkqFwUz9zHH/Yqstyh40Hs+EZbVHQvTx
RhQoW7sF86GEpsk34sTexPPmLNIM4b99QWQlfK5wwljfoYB9k+WcqvMRsuy7KbXe
W99NIG5f2mYX26n4wDLMm9jxlUxlFYDHCWXrvFWHzkIRsjMy5oB4FW7uoXytvwkV
9jYRw4Sq4l/796SYgBFJuVtkKzjC0tcZuLvgUtLgyy+LNc3DBCN/qY7BeTNHTrNA
Uy7iYBtvzDLe2+6Roi7cNLXyyZ/QXKPy+PM/jTYHxvmVzgil9hfpy6zeFBPFzTI7
cBNC+7B9SHSnwNWn1xL+0ipjP5xfgqiBR8a70ohvpiyrvFaJYaa1eB6gDlEZ8rI4
DpRLS+ruVoFu+hKm+BHEhyvRRQYwx3euHxQlkdjRkRhdnnzj/ijU4yciHt5Ni+Bf
R+t0tOyH+CE/syrpFcrg
=R+/J
-----END PGP SIGNATURE-----

--L0mHLbha4YKvhGtu--

--===============7693099496401100438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7693099496401100438==--
