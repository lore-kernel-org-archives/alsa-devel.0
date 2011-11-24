From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 6/8] ASoC: SigmaDSP: Provide diagnostic
	error messages
Date: Thu, 24 Nov 2011 12:32:41 -0500
Message-ID: <201111241232.43809.vapier@gentoo.org>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
	<1322138908-32127-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4368552969914831596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C8C9103E62
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:32:33 +0100 (CET)
In-Reply-To: <1322138908-32127-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============4368552969914831596==
Content-Type: multipart/signed;
  boundary="nextPart2918387.Ott1kBgXoW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2918387.Ott1kBgXoW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 24 November 2011 07:48:25 Lars-Peter Clausen wrote:
> +	if (crc != le32_to_cpu(ssfw_head->crc)) {
> +		dev_err(&client->dev, "Failed to load firmware: Wrong crc checksum:" \
> +			" expected %x got %x.\n",

it's my understanding that string constants should not be split
-mike

--nextPart2918387.Ott1kBgXoW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOzn+7AAoJEEFjO5/oN/WBZ4YQALkPFH11yape78gS5ndHPKIh
KhZIt4z+Av4eL1jeRf7TVcwsaZ5Xcfc2sEbwtSrHXPug9TgAI8bFIsxa7H42mnsF
DOB5oVOQZ+yGGviUkcgyDkuzeuoj4NJvxFl+WGYJRnJpo4shwx0WCIPA8tag9fI8
AKSXLahEWznnN4Q22O62jgONzsMBJV+867VXWrTLNsNoxmYcY59lw4l4oqOiykix
Y6vYPPWitIeK2z6HHXDrGv9/oI0TjlpxLImfRUjE0tT+n0E0mz8U3WXgtSpmlBgx
tljPnjzuTGenWknpSsFxglye8BzXasHIMlc16egoNSqDzDzb856SOmYsFgiLewK0
jt+oD857X6hAugJUmJ4Py42aq4X8STTbH898c/rBSygBa41whZMTHhz44iHQAFg7
7Bii9mYh0UwpVK8bTbDF92uaVglYnbal2/JzOMMlkxWaM2fE5hmv4frzExI9n5mg
H0Hx9f3A4dLJKwcwb9GuLxPL38JJyJRqBEJI1Xw0Y7312xqZptPC4xPZb0uxVKpp
id2jJCygjnpdP/XUPXVSHz7Jt+5nN4vrPZsGu6k50OTtY6lBacJ+WPxmYesE0lIe
5wMhBrqUchQupfMXHCcCyp/BYnNu/l6uyoFFnRBG7wpWxNCBwRHk0JpnghoByEdU
VyPfYKYAnEa2bh34mHUM
=2bQc
-----END PGP SIGNATURE-----

--nextPart2918387.Ott1kBgXoW--

--===============4368552969914831596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4368552969914831596==--
