From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 16/31] ASoC: pxa: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:34:23 +0000
Message-ID: <20131106103423.GX11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-17-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3758744001637544674=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CAD19261645
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:34:25 +0100 (CET)
In-Reply-To: <1383673218-18405-17-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3758744001637544674==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/3kIrr+SWblMf9a"
Content-Disposition: inline


--b/3kIrr+SWblMf9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:03PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--b/3kIrr+SWblMf9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehssAAoJELSic+t+oim9vpsQAIwsjujWGevnpPG0fIkrR0sR
fV4zAMNIUIKv7EjSEAQOEAKQlvTeJWPxHX7LRrNknrrd1xm7O93OmdjzR4GXprB0
pMWNBoWy+44JKtvlGMvnBXDXQ9WQzHAtP+codWtZjIL1trxZ5De+rtxaJo8D/0nn
khKxkGHq/d7rcWr1zNBSaCPot1lzZm1fJNg9EV3pyp6j28xIW9dKIcVX3zPqLe0E
93mUu6UydJaGSmCV+fSzQkr2TFO+kk4cb3A1fA6RPmf4HpoAm4+aXulADuEXjA2e
6rEizulwWXgHkUiIbTNERYks3wLEEf/8+v6ow1pThMRnPUQPv0VbjxWNB5z1LD5K
3ABj5OX9YzAHtFBln21DX7LwUjtaSZfQVOnWcRhay2JFscSFZq7a/AtV12Q19wc4
I4zl+0cCFYyPXHridIK3FpyGtq/khdN1GC1URdKeewCiAGVe5Ozu6hRjro+uMOCL
IcNx27S2HDrNQ0fc/4BEYP54n3YDACLb2Adft9zno6OBarW8GFAye44mJNgOCoFe
exDqEQN90J3UQzOXzzot2TCw/4n1DGIRT02UuWiJ9/1beRicZruQVnnsvLbhATox
Am6K/8mfZyOZ2cD5sXzdBg6D8weLddXSoawt0Cce2NDV8jKFiDqzzTfBjrkALFyn
IpOYOYW5kZekZ7C7vKwc
=UWld
-----END PGP SIGNATURE-----

--b/3kIrr+SWblMf9a--

--===============3758744001637544674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3758744001637544674==--
