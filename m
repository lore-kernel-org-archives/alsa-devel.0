From: Mark Brown <broonie@kernel.org>
Subject: Re: About snd_dmaengine_pcm_trigger()
Date: Tue, 11 Mar 2014 09:55:55 +0000
Message-ID: <20140311095555.GI28112@sirena.org.uk>
References: <87eh2hql03.wl%kuninori.morimoto.gx@gmail.com>
 <5316D562.3010901@metafoo.de>
 <874n3dqc4j.wl%kuninori.morimoto.gx@gmail.com>
 <5316EC79.4090202@metafoo.de>
 <87pplttk8d.wl%kuninori.morimoto.gx@gmail.com>
 <531EDBB4.1080008@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0589787523397546917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12025261680
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 10:56:06 +0100 (CET)
In-Reply-To: <531EDBB4.1080008@metafoo.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0589787523397546917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8yXJwKnNP0rurr9c"
Content-Disposition: inline


--8yXJwKnNP0rurr9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 10:47:32AM +0100, Lars-Peter Clausen wrote:

> The reason why we factored out the dmaengine DMA stuff is because
> there is a standard API that hides the implementation details and is
> supposed to behave the same for each system. For PIO you do not have
> such a abstraction layer that hides the details, so I'm not sure how
> similar PIO between different platforms will actually be.

I keep thinking that there ought to be *some* commonality between the
platforms that use FIQs if only in the timer stuff at least.  Part of
the reason that doesn't get factored out is that it's normally just a
temporary bodge until DMA is working of course, though Qualcomm do it
because their DMA for the DSP doesn't fit well with dmaengine and the
i.MX AC'97 needs it since the hardware doesn't fully understand AC'97.

--8yXJwKnNP0rurr9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHt2oAAoJELSic+t+oim9sbsP/1jOKDn9ZrHcf6JX6dphZtzS
AWQY+m6cv9ypRy34ZFjO1u5PEUYjWR48P1iHEbauyYRxbK60GcCxqPMDLJ/VexgT
Qe+vtmjgD/xjpCuFfvmEy/ioavCYyJmetBaQga7hXZJ2aRDDT1MwJr3oEW2Odib6
FTYu3+7cXqnVkvXoIK+hiPkgNe1vUWeOdTokWgK3SY+/ODxW8CD7B128zwOnXqep
la/5nxIe81+efnkt/5rtawqdKVQ3vpu8ZBLk4ZdgfhnrrMihqp8m3EffTy8qw6uG
v/z6JnXW5IR/O8GxaAhPjm7efRUHsMYECxKv2ZBm97o3erFDqlKv5YleYC5+tcWs
K2HmHvGG2acRKu1pp9z8nMDHXMt41g7JT7OlNjmcwIbPstIzpgR1fEfkEEyEp849
oiXOM0sAV2+tBKXE6VYXfBVjPZlhs9bp388eSAcFqLyuf53B2VyQzS6GwpLMZK8Z
pK2PwcihqRd4LIkQY4fRqir+pO+M8MCoJKwlrpxrqj9Zb0rk0/cJC4UV8fVOVk2x
75BRHVllbQVDwXOb8S/ilFBr8eZmxh9ZPkVhYeMLwDk474tFrfVYS5jtjwi63FUg
MJOKAfDIwwSQgDGHG4MS1b95QvwUgzB7/rC9tVNB7XmqRhnTA8FeMa7/zS6Ck12K
GQz1grnwKRG7HOP0qcTU
=pzlR
-----END PGP SIGNATURE-----

--8yXJwKnNP0rurr9c--

--===============0589787523397546917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0589787523397546917==--
