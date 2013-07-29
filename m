From: Mark Brown <broonie@kernel.org>
Subject: Re: Broken headphone and speaker amplifier
 suppliesforthe rt5640 driver
Date: Mon, 29 Jul 2013 07:45:50 +0100
Message-ID: <20130729064549.GT9858@sirena.org.uk>
References: <51F29064.8080003@metafoo.de> <20130727173509.GJ9858@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB935C48A592@rtitmbs7.realtek.com.tw>
 <20130729060716.GQ9858@sirena.org.uk> <51F6085B.1080900@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0894720241980610684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B7708261A29
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 08:45:57 +0200 (CEST)
In-Reply-To: <51F6085B.1080900@metafoo.de>
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
Cc: Bard Liao <bardliao@realtek.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============0894720241980610684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DQXhpAggXBILGy0M"
Content-Disposition: inline


--DQXhpAggXBILGy0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2013 at 08:14:51AM +0200, Lars-Peter Clausen wrote:

> Yea, so the stuff I was working on while I stumbled upon this was more or
> less that. Support for letting DAPM mute controls, which are also exposed to
> userspace, if necessary in order to avoid clicks and pops. Once muted by
> DAPM userspace will only see a cached value of the controls state and once
> DAPM unmutes the control the userspace state will be restored.

Oh, cool.  That's not really been an issue with most ground referenced
hardware (at least not normally) but it'd really useful for a large
proportion of VMID based devices.

--DQXhpAggXBILGy0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9g+aAAoJELSic+t+oim9olEP/15yhADTly41jzneLNn+xHg+
8GPr1pED+ikXtHJh35LFsWfrqK8BFfta9AQ4Witi9PQ1aR4IOlKM/yzl8PpBvcEu
4IvrSBYTgn4d7Py5iKe7rE5GymVRmf3q4hTnBuqeoXIIhGjx94pTL6pWvQCaL4oq
rE0qVcKAnhB5e9iZO0mFqi8jU4Pk3u/qW7wOJ3LpO/huYADzgjZxaX+LKZKQQpeQ
VYVti0lFT9qbMQERsUqvHVcN21w4YsgV5VZxRIc3WRJFdGjyy1nZjfeom4TsqHXS
hHGa4el3Ajsp0HTO/9vKDDrzgUPY7nAqhKYkUHIwbAX8RiKbXyVpLKAaeswmgV49
qh0rMuNAffxBQwP/eDsKoDR+TyGCLnRC2IBc04ugVDoGzO2M7vEk9HzcfUF41k9I
qBoVfDQep9MSq2ARGxF9IaNQDPajnWQiOg2YYhInqnedbZy/1P3TnvBWo3vKUS3I
2GL3FEi6XeCKUzLbg+9qzn2qYayEGX6/KthVEvozT7IgQupdEhCphYMqmixOs1Pi
momQ+c+PlccdzhWoSHHIVf0TQj3IAEFB98QwxLU0I34yD8Q6pDkBOC+d60n61j0l
0AQKVju8kcjaHuzH+619bpMIinU0lrN0ERYoy+ba6NSBBrOXJCi83B5arIiUhoFe
rUVJ/L1FbQXhwJxZolHW
=lS/Q
-----END PGP SIGNATURE-----

--DQXhpAggXBILGy0M--

--===============0894720241980610684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0894720241980610684==--
