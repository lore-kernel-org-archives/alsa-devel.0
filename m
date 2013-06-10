From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Mon, 10 Jun 2013 10:30:43 +0100
Message-ID: <20130610093043.GJ31367@sirena.org.uk>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
 <20130607143428.GR31367@sirena.org.uk>
 <51B2EC7A.8090309@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3851742615923963948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4881126109C
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 11:30:50 +0200 (CEST)
In-Reply-To: <51B2EC7A.8090309@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3851742615923963948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQziCMYVe1V9fMJ2"
Content-Disposition: inline


--lQziCMYVe1V9fMJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 08, 2013 at 04:34:02PM +0800, Qiao Zhou wrote:

> This call back only takes substream as parameter. In case that a
> wrong/fake interrupt of other drivers triggers this call back, like
> a careless/bad design, then it panics in audio driver. Can we add
> such checking and give a warning log rather than to let the system
> die directly. Could you consider it?

Why not fix the problem in the paths that do the teardown instead?

--lQziCMYVe1V9fMJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtZy/AAoJELSic+t+oim9k38P/2v4DOjb0c84y0Ya3AYX1L3H
FlatuX2aaQe+8ll8nIVK+KOZnwjJOoLkHlvGowXj1FYqUMkYQa9l2uzcyyFIty3Y
EJz/OmTga63XMMFWutGYfRsDb0SlcKG7WBKLOVsCABY6zo8VjU17r3+MAjZfjHFP
q8PfbTzTcI1KYmI7Yu9Z4KsVsQw0CuR91MBQBT0b/7hS6wxAkWUBE/TOJF8RmbkG
A8hWAoOYlpYRV+pmWF2hkooDQw2t0Cp0ou37kds6vY8r/KJwM74lem2Wzo3UxmAQ
MzGI0VIadEWH63QZvOUH35q9Jgbafe8VnqItnK9Vuva4S0Z4bXzaTiK0upnlkODP
BqR7fYtU5UJkmyV81N8Io3pA9z9GxicGBFp5n0NeD8/sYREzlKPH/VtonjJ0/efI
1ToA1d+AtIZ6Tgs3o5Il89OoeQbpO515iTBHmx0a+ST4leTIhFcN7Do2RGIwKXFx
lKAL4vvbeizMTypFyCA50aUHMprSKbATj700tR/zCf3YZNjVZtWqjqWBBiiNl3jq
/J7RzFm4hcR8SFPIkJ/2aACXD0MbYCjwTTh/+zkW3iBYoavzcj6sSF7o36o47Y8b
BNC4RMj3OVyXm9UVin+MGC0FPlAvpjk7dxQ5MPpClOiW1z2MBNgTrhGhC08SLEgF
cdoz1y6u6u3dyvpcZdGB
=qFZe
-----END PGP SIGNATURE-----

--lQziCMYVe1V9fMJ2--

--===============3851742615923963948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3851742615923963948==--
