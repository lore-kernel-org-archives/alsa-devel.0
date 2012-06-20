From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] asoc: add i2s dai driver for bf6xx
	soc
Date: Wed, 20 Jun 2012 11:27:41 +0100
Message-ID: <20120620102741.GJ3978@opensource.wolfsonmicro.com>
References: <1340226031-19930-1-git-send-email-scott.jiang.linux@gmail.com>
	<1340226031-19930-2-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6955797699735319478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACBFF24484
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 12:27:42 +0200 (CEST)
In-Reply-To: <1340226031-19930-2-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6955797699735319478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2012 at 05:00:31PM -0400, Scott Jiang wrote:
> This driver enables i2s mode support on blackfin bf6xx platform.
> We reuse bf5xx-i2s-pcm.c as its i2s pcm driver because it's the same
> for both bf5xx and bf6xx soc.

Applied, thanks.

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4aWUAAoJEBus8iNuMP3dWUcP/3IgQI1L7ePVUMjbHmK6yDXH
5hEYrB3doPvGsFbPoIj/iMAys8sP0Y545ci4jx0/IzPA5YP1RkKVZPFsSY8hoj/y
JRoHynV/5I21zFAqrad745WzL0uE8Lipq/IeYuB5xwN9qF9uJvKij73aRPaBYix7
TO66LRa3FG3/RG6pp05bIVO3i9zkH7mxLe4k4JvaXDuZPOT4LchvSwrvWz3yAd0v
kX6tYsJ9/1N8mm558iJ1XqlemeYrbT4b0DTEYl/uvhcV58Xzu7AVpJMB404Wzxk2
tSD5TlMTpegl44l0x1DqgLMTfmsGqS2PKcdkpKEPgIRoR6Gc6SfGJDP1yImWLvJN
hnbw08pXyuAdez/LIWcYcq44bd8h6l6aE3ulIqiW+4DqMbTKfrtenCUvKAkBqpPY
S/4+l2UxHFkSuKb7SkUDV51v/kCjoSrcsFBXyUf1O6WEiNTycQF+JjNpAjdq0Vyh
mR03iwpDd5Xo0SbP3MDGUbFIG4qYzK2bXDAoMZp7JLRbroga3cc70tHhtrxAd+Fx
AFTLuZEO1ZJJVEYip8PxeJz6PBRwkx0ZAHdKpwUQXyTfrhmo4LjyK66TZugTo4KT
3eeQt4J6q3GHOmHOzvI5UgbovFzKZWiJWToeZa6e4FDn7+VwAqpo5GCzCfySQ1G4
rC0SP/wRcck1VeT42Dr0
=DaoP
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--

--===============6955797699735319478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6955797699735319478==--
