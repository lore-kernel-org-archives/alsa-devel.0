From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8903: disable mic detect irqs
 until jack registered
Date: Sat, 9 Jun 2012 09:31:58 +0800
Message-ID: <20120609013154.GA3924@opensource.wolfsonmicro.com>
References: <1339177075-20506-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7516726325002027388=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D0022103D92
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 03:32:23 +0200 (CEST)
In-Reply-To: <1339177075-20506-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7516726325002027388==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2012 at 11:37:54AM -0600, Stephen Warren wrote:

> This problem can be triggered by fully initializing an audio card, then
> removing and re-inserting the machine driver module. This would leave
> mic detection enabled in HW, and mic_jack set to a stale value.

This isn't a good fix for this issue, - the fact that it works is more a
sign that nobody got round to moving the interrupt registration to the
I2C probe() function than anything else.

> As an aside, I wondered instead about modifying wm8903_remove() to disable
> mic detection, and clear any status. However, even if we do that, I think
> we still want to make this change too, since I think we want probe() to
> work the first time without relying on previous HW state?

It does currently work without relying on previous hardware state, the
first thing that we do with the chip as soon as we get control of it is
a hard reset.

In terms of the mic detection itself it's really the responsibility of
the machine driver to say that the jack doesn't exist any more when it's
being removed - it should be calling wm8903_mic_detect() again during
unregistration to disable the interrupt.  Otherwise there's always going
to be an interval where the jack object has been discarded but the CODEC
driver is still active and could get an interrupt.  That fix should be
enough for 3.5.

Normally nobody cares about this because for most systems there's no
realistic use case for removing a driver like this, it's something
you're only going to run into during driver development.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0qeCAAoJEBus8iNuMP3dWFMP/jMMyvGfcGfs6XyAjBifdZyY
WvGPL39x5O1mCAxP/W7JnBt5QBaDJILXn0TtAerqfniO0pevhoc3JTK7Pm+5UHlJ
hG4oVuoa4Qide4L+FEBT+FhDEveEJrxAUV6A7lVHPC+MMCG3dIrE/VAQjRrCN2Ju
pcJ7Q6PIHGzAEmLIcMJ1S1LRrZhw8cZQrv5DoLPeFVBvBaSEVqL+gD02Lv+QabDS
f2x8JUFnx7IdIh/76b26ozYnSyRkdC1ozB10kIyKwtuUojd4f8l+fPFJxzB50UY7
TFP4chFS/XZHPeyInNAHOVNkh/5v4eBfq66CVaT0+svML7OJv3HZmkY8fxzNMHca
z/v3N5VjuJTtdZZkNRZ5c9SfUmoAL3N2jkqQku2cvqACYGrMhEyivSBUbvmvok+B
XKWtbvwwBtjCp0YiTI9CI1ukf9JjfPj6EB8uqghS05pCkPdW8BL3i7Ogv20iLzfB
gu/qzO3czzScpFJNYZE8Hm/rLNnxWk2JBeAt3Q1A9zLNzDzqAdHUjsernLgYS3TF
pOsBm+P3cHe6ML87PcdH3kD2LytdCLf3s3TXCPP7u12non/nn+V789gq9zqmVc4E
TMgYa/BweAOkm2il7XTC66ykhND4vPSQwtl2nj/4BqYXA8yV61/Cy5s/8g1E40jG
wiFUmjCE0KjnXZjOwGRU
=MNLw
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--===============7516726325002027388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7516726325002027388==--
