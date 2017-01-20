From: Mark Brown <broonie@kernel.org>
Subject: Re: [bug report] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Fri, 20 Jan 2017 12:28:02 +0000
Message-ID: <20170120122802.qlptikqba2xxcusq@sirena.org.uk>
References: <20170119073826.GA28899@mwanda> <20170119092046.GK3573@localhost>
 <20170119103017.GE4398@mwanda>
 <9a00a406-c3b1-39c1-5aea-7ea5b2735dbb@metafoo.de>
 <CACRpkdaYeHay2YFTNVEJo3y04dpA9XiSwZmMJ=go3TLt3O5qwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8445778479976403934=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8103F265A82
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 13:28:22 +0100 (CET)
In-Reply-To: <CACRpkdaYeHay2YFTNVEJo3y04dpA9XiSwZmMJ=go3TLt3O5qwQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org


--===============8445778479976403934==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="emzqzdiheqmub5vm"
Content-Disposition: inline


--emzqzdiheqmub5vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 10:52:31AM +0100, Linus Walleij wrote:
> On Thu, Jan 19, 2017 at 1:25 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> > The warning is correct. It's just the wrong commit. The issue was introduced
> > with commit 37e1df8c95e2 ("ASoC: dapm: handle probe deferrals"). The commit
> > introduces ERR_PTR() as a possible return value for the function, but does
> > not update all callers.

> Yeah so the DAPM code was violating the regulator and clock
> APIs by ignoring potential error pointers (just doing NULL checks), so I
> made it aware of this, but oops it created a downstream problem that everyone
> using DAPM gets the cascaded error pointer.

> I just have to bit the bullet and make a patch updating all DAPM
> consumers, it's just work, I'll keep you in CC.

Yeah, the error handling was already broken - all your patch did was
make it easier for a static checker to spot that there were problems.

--emzqzdiheqmub5vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliCAlEACgkQJNaLcl1U
h9AfXAf/U2i4ESCfyPONIqllEKBCHxgqTs6VKNUNJX+29NaHTQBSjq+YARVrjeZ1
N0fXGIwWsRZ0VChu5Jv2/gjzY0CQ92F5VsZB3fRG5Ez+JuqWIyeaEwSDWRDV7z0/
ERBONbZfu5wRymIkDKrUhuwsIt0Ab5WVAIpMWPGNC6nS4zc5XqLgFNEjh1YfrYKp
nzI8/qM6+RJ4NcQx1EBbywTNVkaWalh5tVf/zrljUF2NkcVTB5Fn6uM2ZZaYS1Pm
YnkOk58w4YAw9Dv3RDbkAiHMkdINii4x+pKd99CF/Vgpxdt2J6wPoq02qs/e9bZh
zr2RP4dqjFZhPKKwRjPKX7B4rSqEBg==
=ltI1
-----END PGP SIGNATURE-----

--emzqzdiheqmub5vm--

--===============8445778479976403934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8445778479976403934==--
