From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/9] ASoC: max98095: Add missing negative
	channel checks
Date: Wed, 30 Oct 2013 09:46:53 -0700
Message-ID: <20131030164653.GG2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-7-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2291352519731327055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C0613265514
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:10:32 +0100 (CET)
In-Reply-To: <1383118507-21503-7-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2291352519731327055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 08:35:04AM +0100, Takashi Iwai wrote:

> +	if (channel < 0)
> +		return channel;
>  	BUG_ON(channel > 1);

This doesn't seem to fit in well with the adjacent code - the handling
of out of bounds data isn't consistent though it looks like they're both
doing essentially the same thing here.

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTf5AAoJELSic+t+oim9o2gQAJiwBPXR5HaxlpAZIhPdqAEt
uNYyXMqCuPhhBBx2UKQyA2L9crUVSVXI6blawM4uplSiElwN0XoGVNWRkFhVXFFu
11wFiwGsZZUtjC222UoTBlOoMwRmeFH3ILzdr9mn4fpZYjAqWXtW9/Av8TzTRSiH
Rtl5c83/SR88plr70UOcStwPttzGkTiahwNSh/PsVeExQgofAR2MhodmKjGaTmJf
2JwayM50jStNHmWldeO7ItCCCRYwljeFPeJNDDumrZ9nNiHss59nunDV9NbhENto
yingOTe2/Rl4U+Yo3VOi4L4mMdUuXpHcgvB3HxnmOlneWQn78/CDbk3oV95afeJX
ocoyaeS2nZiUi95wGHeZ0nmxyLvceFJQjwhTWhHjjDr8JB9xmOOm8eSMtUA/YNpQ
Gr3mfmhEVBQvXTi4zQY7QUByNHP+f99LC1Gb0/NfF5LWwBlEjKeJeBPF8fDg5O6n
omgUXDKpbc0gDI5Vv94oN9v9QrD3l1VqYLPXjrkmWW8a/zJMaGfrZ8BWk7ktrdoa
b9cyaqX7Lf+/ScxAfY2rDNckrl2WpNENigUr5nWakArXbQAa6/o/2gLr5gSQlEU7
hZl3gB425766Hun5MASSQDY8ZqpvWcKHzH5/ZRo8LawSF9ybWg4svUZv+ZcMfJb+
DNTBAz0JRq4VOZ35bC2J
=t5pP
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--

--===============2291352519731327055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2291352519731327055==--
