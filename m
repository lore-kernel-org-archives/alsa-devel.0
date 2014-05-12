From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/5] ASoC: dapm: Use
 snd_soc_dapm_add_path() in snd_soc_dapm_new_pcm()
Date: Mon, 12 May 2014 21:35:54 +0100
Message-ID: <20140512203554.GL12304@sirena.org.uk>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7360511746229693903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B29A2650FE
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:36:09 +0200 (CEST)
In-Reply-To: <1399472428-11034-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7360511746229693903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0Mxzo05v1hOU+a1"
Content-Disposition: inline


--Q0Mxzo05v1hOU+a1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 04:20:27PM +0200, Lars-Peter Clausen wrote:
> We already know the widgets we want to connect, so use snd_soc_dapm_add_path()
> instead of snd_soc_dapm_add_route() in snd_soc_dapm_new_pcm().

Applied, thanks.

--Q0Mxzo05v1hOU+a1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTCnAAoJELSic+t+oim9Yd0P/3b5VQZTL8XDvHjgA2N91ECM
1/SIvMH0SGGj9D4uSb9U1S7j6OQLkG+CBhnlNY5/JH15xUGMqxhhqQiTM4xtsB3k
DGJo4ltVfK5AnLAjgdWmCIqQmqnt9gylONYn1vbxdZGnkTfJoLaQ9wYViJqnPh5G
4yWXwSgFi5vQj1eMDKP8Wu80aR4nFd/EHB2eGQdtzwVQQH3UwJGiehHqy3j5LOJX
ABBQuJTHA9G/t8X64VFZnvw147QLzvzLR5r3lNzS+x1V9R8YATq9yK5RairJra5u
IfWlG36mlJv88E3J/zvVQcJhK+7wZdeSGO2CGPlpmIIngAmMIHObsUk3325nmICh
nQmTDxpngD7MXrg354CQ8nXuz8XDRdYmh6QT9ZVqMhGa65AcjjwlEE46nHvK/VHs
RoYyy6R3w5mWak5Wglg/9qjHp5TO9pxpYjmp72e+zA2biB/cE8yZLVpTRqovFDqh
iMF8AsYwLuZV9uJU7TSDAyMGQyDoZ8v7jQCpYpbIVaTDJHC/3hHg0wKx6YZvnmzE
BAfqyiLhfh87e0nR3k5pYlL1ZXWIYv44oQUi8fYl6OCpYjIkZPtftl/Aw/qRTlNB
Eh1pqwrSKcbMvSQsuVW0GOc0IbFOWy6u/5fnUBMvww7NWg+XMccVsOQa8rC91CVq
kvJGxpM7BH+/L7OXilxF
=O1pw
-----END PGP SIGNATURE-----

--Q0Mxzo05v1hOU+a1--

--===============7360511746229693903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7360511746229693903==--
