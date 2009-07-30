From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
Date: Thu, 30 Jul 2009 16:17:00 +0200
Message-ID: <1248963420.16129.0.camel@johannes.local>
References: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6062695826875944000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 62B561037FC
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 16:17:36 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6062695826875944000==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1aAgYaYXl+i4hAkpYGaf"


--=-1aAgYaYXl+i4hAkpYGaf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-30 at 16:11 +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
>=20
> Check that the result of kzalloc is not NULL before a dereference.

>  		irq_client =3D kzalloc(sizeof(struct pmf_irq_client),
>  				     GFP_KERNEL);
> +		if (!irq_client) {
> +			err =3D -ENOMEM;
> +			printk(KERN_ERR "snd-aoa: gpio layer failed to"
> +				" register %s irq (%d)\n", name, err);
> +			goto out_unlock;
> +		}

Looks good, thanks, but I'd really drop the printk if only to not have
the string there, that doesn't really seem interesting.

johannes

--=-1aAgYaYXl+i4hAkpYGaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKcatZAAoJEODzc/N7+QmaC/kP/1WQTpl1VPuF4Gxnf9ihDUe0
U0Oo+Zi0PZy87OMRTXTXEEwhzDEH6lC1wETlI3NIofQ5Md13G9/jJUR9fUMDWi7O
j7EKy+1iwrNmGeif8Yaicx3ZSUj+/hKDQFc6mg1NyxB3V2Cf1L7PJEE6fqqXLpHA
tt/irChip+rpWaFBy+r1yD0wUw2rGwB/CVsN9zasH91fbzg6pU6xU3dwQpaUPzt9
bIxNd7ucne/TtYKRYSpEYSCjy/XfKctgNspyD2O1MmnrotpaW33YcGo5PAZekvJj
LKoc0ScM7XxrBjT/W6oKmueQzrSu4PFqenKgJlBZI6O1fmPZig2GkFDdcfIW3qXK
13A9TBAofWd4p4uQRAUVRJ/25RBKLdSZ3J0SlB3Pd7jDB7lcl0dfFI9ofO8OqHCP
rlklAyAv9GEtns2oqq3IIkgAnz6g5eJgsuaeh+ZNfbvLvmFjGU8D41FMeidW4BNW
/1iww2ENSafqe8hkR1LYmcP+OOlIqHebKywqp/9Fw3V69fwy0gSYhFsqZDj3MW7o
q3VksjHoMI333dwg/A/+5kR+xiijFORYNfRJ4esaEpvG7eTVB3CBqbnR7aYn7GYa
mcZLW5aZ+hG4glkC6ijGwm3gyQwZLkqBFt2ohv4fC0XQvgie2XyiAdn9oEQlBXgB
hZSmSHQCTc/yGIA7+O5h
=sGsV
-----END PGP SIGNATURE-----

--=-1aAgYaYXl+i4hAkpYGaf--


--===============6062695826875944000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6062695826875944000==--
