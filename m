From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Fix component_list corruption
 when unloading modules
Date: Tue, 29 Apr 2014 10:09:39 -0700
Message-ID: <20140429170939.GF15125@sirena.org.uk>
References: <1398688251-11374-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5041255806818243787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99867260320
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 19:09:55 +0200 (CEST)
In-Reply-To: <1398688251-11374-1-git-send-email-jarkko.nikula@linux.intel.com>
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


--===============5041255806818243787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 03:30:51PM +0300, Jarkko Nikula wrote:
> This fixes module unload regressions introduced by commits 98e639fb8a3e
> ("ASoC: Track which components have been registered with
> snd_soc_register_component()") and b37f1d123c69 ("ASoC: Let snd_soc_platform
> subclass snd_soc_component").

Applied, thanks.

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX9zQAAoJELSic+t+oim9eeEP/1gJ0Llc/QeW97ERnz27whKU
jVGj4NXlmP7u7GgmZ8VD+fCWvuZlKrp4yBE0Dl7NzGHrmQrr9x5oubNE4TJ2ES/T
mn4I4UrViy1WmyXB6chYWy2kwyC9fvtSHLjnzhwAxjjRLoSiqKWCUbgHmeSC/Ojj
U+ojkgiLfFTHx9YOWfJXPhnTn0Aa8JCm17SBDUi/Cct8cv/0FKTxp9oN6yGtCsP7
krRyDM1lShO6U5rVeu2Q6JMqWNwJX3yJ3JF9mx1vMFsoA9cufiVNW0jB3NOFY/xy
R77o15NuUJ0Hz7sctiNtYZJVnDBNX/wa1mODqD53DGzXCDNQK699vgit77rLB3lI
GzfCezeMRPnOls8JoUcgHelh9al2Fe8sxQs+VjQCRQGdnpHzJtcUu9g9wMP8TcZV
Jg/T7P1E2i6A9r/oAgdZ3CF3BuuXT+fNZMFJ5vezr/Pd/t1VLfiPCDu3cKtujasi
OIsorrxbokK1iXhq1is9m3GB0FiP/YvhJOQ4llaIu7W3w+JYDtZydlQqqROPqH7Z
8Cz2EPXe+fX4VY+Ddxjt3IuoSg4wSU9ybEsUg4W+FvMyZchqBEf7Mivqw47nrvYB
RyrRYCnOapIJ/2+Fr7SdDzLC/k+c/G9qvvvKqIgeXe/EYW94p0Ue79CozbReY0Re
Z/tbjciLipQqyZhcV5Sm
=ojvy
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

--===============5041255806818243787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5041255806818243787==--
