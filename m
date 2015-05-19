From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: fix kernel hang when call
 rt5645_set_jack_detect()
Date: Tue, 19 May 2015 13:11:09 +0100
Message-ID: <20150519121109.GK2761@sirena.org.uk>
References: <1431916443-22588-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2935552561247000581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97FD726528B
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 14:11:16 +0200 (CEST)
In-Reply-To: <1431916443-22588-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2935552561247000581==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iDz/PsN11jbXo3Nh"
Content-Disposition: inline


--iDz/PsN11jbXo3Nh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 10:34:03AM +0800, John Lin wrote:
> rt5645_set_jack_detect() is usually called from
> snd_soc_dai_link.init() and it calls snd_soc_jack_report() from
> rt5645_irq_detection() if jack is inserted. snd_soc_jack_report()
> results in kernel hang if it is called from a context which cannot
> sleep.

Applied, thanks - I rather suspect this is a case of trying to reacquire
the same lock rather than being called from a context that can't sleep
though, we shouldn't be doing device init in atomic context.

--iDz/PsN11jbXo3Nh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVWyhdAAoJECTWi3JdVIfQYnQH/ilXJxTKOtl5hT50Bs5SHbq3
OmTEkJwKdiLgGs6lCXmODDJNTVW5qZR6YeRt/YYuKuSqycCKHKq3tPQ1sNNFqr5a
tzw0eQBSMCTc33qOzowwYVqKoa/Hlpvy9hrAgJZjUaZ373X4CLU8gaaojzKiOadv
asqaX12r8Sa7FsjDoZsUtEheANgTRmQbXOa6dMQRXkYwZCXYYiPCjXVpOzcz1NcP
ja0h/7Q6NuBuQ8f+rSl0lhXO3C7Y0sVoJDkdY6N+ZP6pq1iXyrDAYiRq1SeU1hSk
0zt59cAOC/B55jTOKThNJRFZX3o2yTuVagGL1BIk7qo9VBwXV/d1+M9Ib79gLxc=
=3wsz
-----END PGP SIGNATURE-----

--iDz/PsN11jbXo3Nh--

--===============2935552561247000581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2935552561247000581==--
