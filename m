From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: Re: ALC268 test model not working
Date: Mon, 14 Jan 2008 18:30:01 +0100
Message-ID: <478B9C19.4070709@harddisk.is-a-geek.org>
References: <478B8ECE.4020707@harddisk.is-a-geek.org>
	<s5hr6gkibw3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6683299226902918746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.velirat.de (velirat.de [85.25.68.44])
	by alsa0.perex.cz (Postfix) with ESMTP id CEECA2460A
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 18:29:56 +0100 (CET)
Received: from dslb-084-056-058-006.pools.arcor-ip.net ([84.56.58.6]
	helo=[192.168.0.102])
	by www.velirat.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.68) (envelope-from <marco@harddisk.is-a-geek.org>)
	id 1JET8G-0000s5-EZ
	for alsa-devel@alsa-project.org; Mon, 14 Jan 2008 18:29:56 +0100
In-Reply-To: <s5hr6gkibw3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6683299226902918746==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig348FAA97E5AA10B188770623"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig348FAA97E5AA10B188770623
Content-Type: multipart/mixed;
 boundary="------------010806020904040302020005"

This is a multi-part message in MIME format.
--------------010806020904040302020005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai schrieb:
> At Mon, 14 Jan 2008 17:33:18 +0100,
> Marco Schuster wrote:
>> Hi all,
>>
>> finally I got the patch applied to kernel src :)
>=20
> Any reason you don't use simply alsa-driver tree to build the external
> modules?  You missed many features that will be added after 2.6.24
> kernel.
>=20
I use the make-kpkg debian way of building kernels, and so I always
get a warning "current directory is kernel src directory" :(
>> But it doesn't work correctly, because when running alsamixer, dmesg
>> tells "hda_codec: num_steps =3D 0 for NID=3D0x1d", and alsamixer fails=
 with
>> alsamixer: function snd_mixer_load failed: Invalid argument.
>=20
> 0x1d is the PCBEEP.  Maybe it's disabled somehow although it's listed
> in the datasheet.  The patch below should fix.
Strange, I don't get any sound thou' all channels are unmuted.

Marco

PS: Do you live in Germany or speak German?



--------------010806020904040302020005
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC42IChH
TlUvTGludXgpCkNvbW1lbnQ6IFVzaW5nIEdudVBHIHdpdGggTW96aWxsYSAtIGh0dHA6Ly9l
bmlnbWFpbC5tb3pkZXYub3JnCgppRDhEQlFGSGk1bFNXNlMyR2FwSlV1UVJBam1KQUo5cHJq
eVBiaVNxYXdKZC9BZUFSWFc3U0ZOcFZnQ2ZSalYwCndnaVgrMEhNSXU5d1p5bGd4ZTlDd3ZR
PQo9M2pTdwotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KCg==
--------------010806020904040302020005--

--------------enig348FAA97E5AA10B188770623
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHi5wZW6S2GapJUuQRAouqAJ9OPFB5aO8CjBNLXSL2EGHOS76TjwCfQx7i
9Unw8giuKj4bAfVlEztlEFA=
=Kaed
-----END PGP SIGNATURE-----

--------------enig348FAA97E5AA10B188770623--

--===============6683299226902918746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6683299226902918746==--
