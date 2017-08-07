From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: compress: Remove duplicated code
Date: Mon, 7 Aug 2017 16:07:14 +0100
Message-ID: <20170807150714.e7aecqskfelp7h5z@sirena.org.uk>
References: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
 <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2408838166233867078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17CA32672A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:07:22 +0200 (CEST)
In-Reply-To: <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2408838166233867078==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cjvxitc7w7mztkoz"
Content-Disposition: inline


--cjvxitc7w7mztkoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 09:18:09PM +0800, Donglin Peng wrote:

> The value of the variable new_name is assigned repeatedly.

> @@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
> *rtd, int num)
>         }
>=20
>         /* check client and interface hw capabilities */
> -       snprintf(new_name, sizeof(new_name), "%s %s-%d",
> -                       rtd->dai_link->stream_name, codec_dai->name, num);
> -

Are you sure that this is the assignment that should be deleted, and if
so why?  Note that it's both conditionally and unconditionally assigned
later on...  Some words in the commit log about why this copy is removed
would be helpful.

--cjvxitc7w7mztkoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmIgiIACgkQJNaLcl1U
h9CAOQf/Y1iJKOPnN2qi++MLSwLXoY4eikrqsm6LcD8GyHwZKfRjxDCdhmdaRQLW
jB/cs6+P0QiBf1NCRLO9Djtsg2ZHKRgFDbqBddcxVIrV4j14aGMEo3tU6iqSQyqy
RjMNF8BQ4+9HzsGxl9y/c5sIpugzD8Lzaj9FlocWikEi23YhlzT0dERqMzzp9Pvy
E9vXdcG840w4JxxxUfjncNec/f58M/6E5z0YFwG0p0stRFUEdYOEvGOztTqvPZNF
bTcxOY6G1WER6DZb63kssNZEalCL3uKN1oJ/5cC53+f73vaxqdkWFEnH3hoMzaKu
zy6LLpQenjV+YGzrFBx+wIyjKb18Mg==
=qu/k
-----END PGP SIGNATURE-----

--cjvxitc7w7mztkoz--

--===============2408838166233867078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2408838166233867078==--
