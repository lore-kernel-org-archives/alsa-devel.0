From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 6/7] staging: bcm2835-audio: Deliver
	indirect-PCM transfer error
Date: Mon, 22 May 2017 09:33:19 -0700
Message-ID: <87tw4cn968.fsf@eliezer.anholt.net>
References: <20170521190258.1178-1-tiwai@suse.de>
 <20170521190258.1178-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4206227956366900274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id B5CE4266FD1
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 18:33:24 +0200 (CEST)
In-Reply-To: <20170521190258.1178-7-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, linux-rpi-kernel@lists.infradead.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============4206227956366900274==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Takashi Iwai <tiwai@suse.de> writes:

> Now that the indirect-PCM transfer helper gives back an error, we
> should return the error from ack callbacks.

As far as bcm2835 goes:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlkjEtAACgkQtdYpNtH8
nujCdQ/9HCIsf8UhkDEPoIab3SFtJSq6A9eUJaaOtazSuLU2LI0bp1mR4edQOpkb
wuyI7zLBVYgfTmLv/j0PVItbYhXO5w5KCKBhNNGQfwod/6a4CB85aki6b/muGhld
Gv6EFc0qvbUBBZpvGZm1Kw3rCop3nI7Bn4JfNXMPoSv2K1lahGJ8VHsOTpl7csaW
BKBE2t1LmGfFa+XLH/IdQkxwpTVfU4rE2P8zvYofi89EphIPzU5oFz2B5hJ9gcxH
CwEb3Q6ThtcErapkikFkxygfjG4UeAOFul1ZRcMgC/ETWD+NChHXMbARtjW2glaO
XJur+MTYAyflsMFmORRFTeVyAGdult63VuEjIYSIakPfOOxcB/8IBaWQB8NQyXXK
fX8yLF2H3G1BAkRVJPJITEhrv5hxDbcyEK8ICa+TF7DDxDincZkw7hU0ZExjWCAZ
RMKcQWKzMyEEQzgXWqpDz4SByyumCMX9MdehGZPx5MdD/YLt37y3XT4WVfYxK4Tu
bbaSVvCR0KXnBhAym51cETdvy4Rro8mFFEzmgEUs7mJpUYvls0Brznb3aUFqDLi/
ukJtW1ixTLAjRRsQOKThzlqQYdc4f0h2y9hUPGUP4HClBJYsDTHhIALm6DIPG/dm
7jHECZSYeWY8U6gMEo6yCrczPdXOO1u5W15xA5OFIR0aIcII2fo=
=3A5C
-----END PGP SIGNATURE-----
--=-=-=--

--===============4206227956366900274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4206227956366900274==--
