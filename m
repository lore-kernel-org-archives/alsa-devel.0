From: Andreas Hartmann <mail@andreashartmann.eu>
Subject: Re: Bug: LADSPA implementation - no up/downmix handling
Date: Tue, 22 Sep 2015 16:16:20 +0200
Message-ID: <1817696.X2CRQ36k7l@deep-thought>
References: <2541800.vBPmoIL6Xo@deep-thought>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3708757934266488532=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from stcim.de (stcim.de [78.46.73.102])
 by alsa0.perex.cz (Postfix) with ESMTP id E2FBB264F22
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 16:16:24 +0200 (CEST)
Received: from [2001:a62:1b1:f701:5550:d1f4:56d9:9b57]
 (helo=deep-thought.localnet)
 by stcim.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.84) (envelope-from <mail@andreashartmann.eu>)
 id 1ZeOMp-0003MC-Su
 for alsa-devel@alsa-project.org; Tue, 22 Sep 2015 16:16:23 +0200
In-Reply-To: <2541800.vBPmoIL6Xo@deep-thought>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3708757934266488532==
Content-Type: multipart/signed; boundary="nextPart3547973.HYJmJ1RD6Q"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3547973.HYJmJ1RD6Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 12. September 2015, 22:10:40 schrieb Andreas Hartmann:
> Hi,
> 
> Using the surround_encoder of the swh-plugins I noticed, that the alsa
> implementation only assumes an equal number of in- and output channels for
> ladspa plugins. This occurs from Line 752 onwards in pcm_ladspa.c and leads
> to a Segfault shortly after.
> There needs to be a check and correct handling for up/downmix scenarios.
> 
> Andreas

ping
--nextPart3547973.HYJmJ1RD6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJWAWK3AAoJEFdgwA+zsF1UpH4P/3YRiF5WxIV6UzeML9Ph2CVu
ef5XzfH1yzmXPOutdk3hcS7ZQKUFzi8UiCQlWTLc3CL8gE1XMlVaWuIoIFRUfhPa
+ssKoCeDfvKL2XEfH4ofU9ZMo15WrPmolhst/15fnKz9TN5RqMzmYNgz/kpbR7kw
OIpgTjGG+POmQoejc5ZTBRSg4aanj98s7tr7ZulJtrNp9KPfQNfP4I3/m2k4saE1
ojiFab3Vi+rRAE4nA1zVCvT03o1554wtbwbkgPEiTu/9Zh0a6IdHKHHvzGLXMyvq
2Iv0QKljysxJEm7+nt9PzsA4hxL1neuXgFWaPCrOrSNlEfEjDUY0M4n16zWRy7Ul
pdjlT4srBU62zc4YI1Us5Q1X1hMMWPkE3vBRDwdSjDvMlDoTquck+YLiXNILTly/
p51mgDj+UT6E4x9xVnGC2VU8wvTfFi37cRG2taHBwDkQiSW0UIDdq367oz4lf+f6
ywirTpNk//8sPrwIZQrWEtOXIYxQ0uYEr2wf5vAV4qxv97uMGHppmPhbLlEJNyvx
9+j7KnteivC9CQPOkLJWzTHspUG6gYE7V7g+aNSVIBpLS2xhjcjFcHnKH7/XXRt7
CVtUDh36a9FdTeQpIhDzyJHwRGMZj06RR9Yovd1b1ye0a0b39PUfkxpETti7XCLx
y9o2KJrmJWwhXfKc4M+5
=JxCF
-----END PGP SIGNATURE-----

--nextPart3547973.HYJmJ1RD6Q--


--===============3708757934266488532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3708757934266488532==--
