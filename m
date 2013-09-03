From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2][RFC] snd_soc_codec include
	snd_soc_component
Date: Tue, 3 Sep 2013 12:32:38 +0100
Message-ID: <20130903113238.GI3084@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <878uzellkb.wl%kuninori.morimoto.gx@renesas.com>
 <5225C77A.6030706@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7829913443977088965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF0F2652E1
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 13:32:45 +0200 (CEST)
In-Reply-To: <5225C77A.6030706@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7829913443977088965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JKvC8Wn6JllzUPdT"
Content-Disposition: inline


--JKvC8Wn6JllzUPdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2013 at 01:26:50PM +0200, Lars-Peter Clausen wrote:
> On 09/03/2013 03:51 AM, Kuninori Morimoto wrote:

> > I can send "use component" patch for all codecs
> > if you want me it.

> While nice to have I don't think it is a requirement to do this before we
> can continue with the changes to the core. So if you want to do it go for
> it, but it's also not a problem if it is not done.

I was going to add a devm_snd_soc_register_component() since so many
devices only need to do the CODEC unregistration in their remove
functions - it's probably best to wait until that's done then go through
and update them all once rather than having to go through twice.
Equally well it won't hurt.

--JKvC8Wn6JllzUPdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJcjTAAoJELSic+t+oim9UfoP/A0YqGezFsTccvZi33GISow7
WKhc4CBsp4AHwR73KUfto5hbldMagbsgLjL5rUyCPrvildLXxlGRUC42pLICT0As
c3nJawBqlAmldaNPj6UOlGOZAZE0wqSvqSi2bwcKnVWRt/eOVm9963wBCL9mI/Xx
TJrg0TXC6apvTfoXsM9RZH6i2S5eXxxJXwjwwkzyuxxnB9I40KLGjnxv72N2Zi9E
Xkd+FuaultGhLXuxEs5U+o+CxRM8vsOzWxx4F7XWelBApXZ2SdkXc3sx1F9mHHCV
U/gGm4F6dIB73MzBLoFy/JzAu8Gld+ydXpmi/9ijagvwaoOqXYN8fyrbcTqSSekW
xR7zNC0IHo51GY1dPQS68UZXT25cT0Pjjm60kZmUibLLW1Auoyf7HGlkE5sGddM+
oCYm1+UbYsJa360X41z6FdmRlCDA8y6y4PplIdOS9IjKTCvgVuH0t732iQwKDRTK
MODWDYHJC7N939JOV7MXVyAGT3ZdONGgDD/UGunkNIefItvEWz++WetoWkDM0/em
X2C3QlyW2onDMX+y50tAW8ikUo6arHe0Pt4rUFjbsjWobLoMKnzn1niPpU8z6YfR
L1earjJDDsVNvmiGN7boqmgotup9AbGFWRr/D7pbt7PLYGR40sUJYZYTCK2uoXNu
l1Wy4gkD7X9gbH4fLRCc
=7V5P
-----END PGP SIGNATURE-----

--JKvC8Wn6JllzUPdT--

--===============7829913443977088965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7829913443977088965==--
