From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: add bf6xx audio dma driver
Date: Thu, 25 Sep 2014 14:25:41 +0100
Message-ID: <20140925132541.GR27755@sirena.org.uk>
References: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
 <20140924082622.GW4015@sirena.org.uk>
 <CAHG8p1BxYz1ZunaGRo0ruJPSU17uF5XRttqn--QeWEExMWWNtw@mail.gmail.com>
 <20140924114232.GI16977@sirena.org.uk>
 <CAHG8p1Ad0RbLjdXpjAor8pZXs_9OfUbp142vQ_pc2KReTy9u8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5309027361316371349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 331EE26040C
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 15:27:37 +0200 (CEST)
In-Reply-To: <CAHG8p1Ad0RbLjdXpjAor8pZXs_9OfUbp142vQ_pc2KReTy9u8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, adi-buildroot-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============5309027361316371349==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K3vkeaB0MlFjg8U+"
Content-Disposition: inline


--K3vkeaB0MlFjg8U+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 03:24:45PM +0800, Scott Jiang wrote:
> 2014-09-24 19:42 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > These sound more like extended functionality and tweaks rather than
> > massive updates which need a completely separate driver - new modes and
> > so on.

> Yes, it looks similar in i2s mode. But in tdm mode, because we don't need to
> copy 2 channels user buffer to 8 channels dma buffer, it might looks
> very different.
> If you think this patch is not good, I'd send a new one after I merged
> tdm driver.

Well, I'd rather not see the driver split into two separate drivers
again if at all possible - ideally just the bits that need splitting.
It sounds like you need separate copy operations for the two cases but
otherwise things are fairly similar?  If the driver ended up being
nothing but conditional code that'd be bad but if it's just a few places
then it's going to be better to avoid duplicating the entire thing.

> By the way, if the channel order of hardware is different from what is
> expected by alsa,
> the copy work is left to plugin or driver?

If the format is just not something ALSA understands then the driver
ought to do it.  If ALSA does understand it but it's just not what most
applications want then the plugin should be a better choice.

--K3vkeaB0MlFjg8U+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJBfUAAoJECTWi3JdVIfQdvgH/RbPW3O4XCcNQz53nl2lhFXn
fedaDqK21+ee6idCB0W4aMojStnKj71+BpVRmRlkgVgx9wnWraF9R5eYZW6pTNjz
DIYsf4yf9Bg+ruBQsg12eMBNS7PUOJcDuRY+2cL2TRS8rkFHCDUZw7Rf0nLiLILP
FeWhLbi0LBvJs3umRUL6DjT9ArxbCHMQAkkMpqvUpMCKK7CnxzMr5s6raj+UPYpx
LMlRb2A35bUWhSkPwKeXJgtD3fvCXuMGK3rAKH5S/WdsC2N8oXV6wf8NpxtiMLZ4
vDY5d0Jj9B5zv4GgOqhwADWucBvRvKo5KveJUzQ+cHBK8tYHHScxSG9Ais3OF3o=
=5HnO
-----END PGP SIGNATURE-----

--K3vkeaB0MlFjg8U+--

--===============5309027361316371349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5309027361316371349==--
