From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 07/12] snd-aoa: add tas codec
Date: Wed, 07 Jun 2006 17:42:07 +0200
Message-ID: <1149694927.3925.4.camel@johannes>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130914.735290000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1449716556=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1207D169
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 17:42:14 +0200 (MEST)
In-Reply-To: <20060607130914.735290000@sipsolutions.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org


--===============1449716556==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qAsHBdp2bbyUDSGfVa8p"


--=-qAsHBdp2bbyUDSGfVa8p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> +		/* older machines have no 'codec' node with a 'compatible'
> +		 * property that says 'tas3004', they just have a 'deq'
> +		 * node without any such property... */
> +		if (strcmp(dev->name, "deq") =3D=3D 0) {
> +			u32 *addr;
> +			printk(KERN_DEBUG PFX "found 'deq' node\n");
> +			addr =3D (u32 *) get_property(dev, "i2c-address", NULL);
> +			if (!addr)
> +				continue;
> +			/* now, if the address doesn't match any of the two
> +			 * that a tas3004 can have, we cannot handle this.
> +			 * I doubt it ever happens but hey. */
> +			if (*addr !=3D 0x34 && *addr !=3D 0x35)

And I fixed the obvious bug here now.

johannes

--=-qAsHBdp2bbyUDSGfVa8p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIbzy6Vg1VMiehFYAQKmAg//c/bHTg4/yEP/rubtOv/h+Q7vT/J42/Wv
2D2mk7cXd0Z5NT9hvueG/4eizhJVcrqp4xTLTrzoZcTL4fmjPvpudpanMucOzgDO
/nqsuN2s+sArwUhXMVWnden0XtNe1ABpAHMo9qJJuUK4v0A3yPZVhpIyxNZBsxFA
PzDzfEq39b/TvYSOhCX947g3GQeYgxpe3cXxLIUePu1MwIcdNeGYIq6U6M+A0wAT
cKtDYTHvbWU2I6gTTL+IRzI+3QTWTmc8kAECRsLMz3ySbppQNQGhB8QMSLWwZ9/s
RMyDwaQMKXGtzCYDsXiu4npHB8UlR9upl47Jl2cUel7vjMAn1aZ0hhhFVpQ10hUX
A6Kts7WV4j8DHdTsC/gG9guNNbYh2w+Px9XqOh4QSjMhQQvJmo/4KLOqn0XLTLJW
oNbi7rkVjbxrnHr+RsqvQWhyLM2Ah8S1x8GalwOLFkDG7jyMlPohsaTgZQbkZtyR
1DcbFyCxYdCEme9ALE9Y9EiMk0hUt++gPHaUPwz9l00PeSISfMdMnxbzRXJd0yfm
QGoPWYX5CigE85H/rXlVwgyX23ynpIDKBlLBZaf6sgEEyL8iNghxREnrHm9WyIFE
KfAcr95aXCIqbKKvA+NdExNw4tEXAE6UtetffzbTyHiyP9nS2xtW5P7i2urget8t
vdyZgt6+hvw=
=uV6g
-----END PGP SIGNATURE-----

--=-qAsHBdp2bbyUDSGfVa8p--



--===============1449716556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1449716556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1449716556==--
