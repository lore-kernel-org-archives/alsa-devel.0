From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/wm9705 1/1]
 sound/soc/codecs/wm9705.c:330:18: error: implicit declaration of function
 'snd_soc_new_ac97_component'; did you mean 'snd_soc_new_ac97_codec'?
Date: Mon, 12 Feb 2018 14:49:11 +0000
Message-ID: <20180212144911.GD12976@sirena.org.uk>
References: <201802122255.cGsOCM1z%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0419359778834257021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A3902673C4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 15:49:20 +0100 (CET)
In-Reply-To: <201802122255.cGsOCM1z%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0419359778834257021==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2018 at 10:19:57PM +0800, kbuild test robot wrote:

>    sound/soc/codecs/wm9705.c: In function 'wm9705_soc_probe':
> >> sound/soc/codecs/wm9705.c:330:18: error: implicit declaration of function 'snd_soc_new_ac97_component'; did you mean 'snd_soc_new_ac97_codec'? [-Werror=implicit-function-declaration]
>       wm9705->ac97 = snd_soc_new_ac97_component(component, WM9705_VENDOR_ID,
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                      snd_soc_new_ac97_codec

I've dropped this and the other patch that had the same issue.  I wonder
why 0day didn't notice this on the list...

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqBqWYACgkQJNaLcl1U
h9DyhQf8Cfv5Ow4f5e/hzStigp8/HFGa1bqHbcdVYGCply7l7thszIxMxODWZnk+
+RKCaJaGcBLw3tpZcwQOfDwkx+3jJrVF1ngXqMgM0VIqzGGxruQAr2B7WQCZBiBu
QWmWjFI2NxsNoh+ZZFBTiNH23BB1zWGOrEYW/omOsAg2nB7fkmvOe4GHg5UJ7GsD
Z2yKefoaWMFzeWF5c7n+TNuKuvxxQ3mi94LYgpZBX5V+kHg1lz2Uh7VftYfMR5j9
meBhAbRcGOxJC2TKjA+zZOtbqjmLsv4iwDBsCt22FUhWpyQUlLwj5nd+Rj9XYJg9
Fzvz9tZaHE742Ik8frDt9sLyt0RgHg==
=qjAD
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--

--===============0419359778834257021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0419359778834257021==--
