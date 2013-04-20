Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Fri, 19 Apr 2013 17:35:33 -0700
From: Joe Rayhawk <jrayhawk@fairlystable.org>
Message-ID: <20130420003533.GA4607@richardiv.omgwallhack.org>
References: <5171700A.50308@ladisch.de>
 <Pine.LNX.4.44L0.1304191359350.26229-100000@netrider.rowland.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1304191359350.26229-100000@netrider.rowland.org>
Subject: Re: [alsa-devel] BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1317642456468470199=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>


--===============1317642456468470199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2013 at 02:18:24PM -0400, Alan Stern wrote:
> On Fri, 19 Apr 2013, Clemens Ladisch wrote:
> > Alan Stern wrote:
> > > +		next =3D uhci->frame_number + 2;
> > >
> > > That 2 is the minimum latency, in frames (one frame per ms).
> >=20
> > One frame worked fine with the old driver.  What is the reason for
> > this regression?
>=20
> Perhaps that was a mistake.  Joe, you can try changing the 2 above to a=
=20
> 1 to see if it fixes the problem.

Hey, that worked great! Audio's coming through continuously, now.

root@richardiv:~# uname -a; cat /sys/kernel/debug/usb/usbmon/4u & perl -e '=
print pack "H*", "00FF" x 2048' | aplay --period-size=3D48 -r 44100 -f S16_=
LE -c2 -D hw:1,0; kill %1
Linux richardiv 3.9.0-rc7-nextframe #8 SMP Fri Apr 19 16:29:37 PDT 2013 x86=
_64 GNU/Linux
[1] 4598
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster=
eo
ffff880154aba440 3793290194 S Co:4:005:0 s 01 0b 0001 0001 0000 0
ffff880154aba440 3793292190 C Co:4:005:0 0 0
ffff8801515a20c0 3793292289 S Co:4:005:0 s 22 01 0100 0001 0003 3 =3D 44ac00
ffff8801515a20c0 3793293167 C Co:4:005:0 0 3 >
ffff8801515a20c0 3793293206 S Ci:4:005:0 s a2 81 0100 0001 0003 3 <
ffff8801515a20c0 3793294188 C Ci:4:005:0 0 3 =3D 44ac00
ffff880142054dc0 3793294216 S Zo:4:005:1 -115:1:0 1 -18:0:176 176 =3D 00000=
000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffff8801420541c0 3793294221 S Zo:4:005:1 -115:1:0 1 -18:0:176 176 =3D 00000=
000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffff880142054dc0 3793305177 C Zo:4:005:1 0:1:362330:0 1 0:0:176 176 >
ffff880142054dc0 3793305202 S Zo:4:005:1 -115:1:362330 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793306165 C Zo:4:005:1 0:1:362331:0 1 0:0:176 176 >
ffff8801420541c0 3793306186 S Zo:4:005:1 -115:1:362331 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793307191 C Zo:4:005:1 0:1:362332:0 1 0:0:176 176 >
ffff880142054dc0 3793307208 S Zo:4:005:1 -115:1:362332 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793308190 C Zo:4:005:1 0:1:362333:0 1 0:0:176 176 >
ffff8801420541c0 3793308203 S Zo:4:005:1 -115:1:362333 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793309191 C Zo:4:005:1 0:1:362334:0 1 0:0:176 176 >
ffff880142054dc0 3793309209 S Zo:4:005:1 -115:1:362334 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793310194 C Zo:4:005:1 0:1:362335:0 1 0:0:176 176 >
ffff8801420541c0 3793310211 S Zo:4:005:1 -115:1:362335 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793311192 C Zo:4:005:1 0:1:362336:0 1 0:0:176 176 >
ffff880142054dc0 3793311211 S Zo:4:005:1 -115:1:362336 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793312194 C Zo:4:005:1 0:1:362337:0 1 0:0:176 176 >
ffff8801420541c0 3793312212 S Zo:4:005:1 -115:1:362337 1 -18:0:180 180 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793313172 C Zo:4:005:1 0:1:362338:0 1 0:0:176 176 >
ffff880142054dc0 3793313188 S Zo:4:005:1 -115:1:362338 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793314192 C Zo:4:005:1 0:1:362339:0 1 0:0:180 180 >
ffff8801420541c0 3793314209 S Zo:4:005:1 -115:1:362339 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793315192 C Zo:4:005:1 0:1:362340:0 1 0:0:176 176 >
ffff880142054dc0 3793315210 S Zo:4:005:1 -115:1:362340 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793316192 C Zo:4:005:1 0:1:362341:0 1 0:0:176 176 >
ffff8801420541c0 3793316209 S Zo:4:005:1 -115:1:362341 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793317196 C Zo:4:005:1 0:1:362342:0 1 0:0:176 176 >
ffff880142054dc0 3793317207 S Zo:4:005:1 -115:1:362342 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793318191 C Zo:4:005:1 0:1:362343:0 1 0:0:176 176 >
ffff8801420541c0 3793318209 S Zo:4:005:1 -115:1:362343 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793319193 C Zo:4:005:1 0:1:362344:0 1 0:0:176 176 >
ffff880142054dc0 3793319211 S Zo:4:005:1 -115:1:362344 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793320191 C Zo:4:005:1 0:1:362345:0 1 0:0:176 176 >
ffff8801420541c0 3793320208 S Zo:4:005:1 -115:1:362345 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793321196 C Zo:4:005:1 0:1:362346:0 1 0:0:176 176 >
ffff880142054dc0 3793321213 S Zo:4:005:1 -115:1:362346 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793322191 C Zo:4:005:1 0:1:362347:0 1 0:0:176 176 >
ffff8801420541c0 3793322208 S Zo:4:005:1 -115:1:362347 1 -18:0:180 180 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793323193 C Zo:4:005:1 0:1:362348:0 1 0:0:176 176 >
ffff880142054dc0 3793323210 S Zo:4:005:1 -115:1:362348 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793324191 C Zo:4:005:1 0:1:362349:0 1 0:0:180 180 >
ffff8801420541c0 3793324208 S Zo:4:005:1 -115:1:362349 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793325196 C Zo:4:005:1 0:1:362350:0 1 0:0:176 176 >
ffff880142054dc0 3793325213 S Zo:4:005:1 -115:1:362350 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793326192 C Zo:4:005:1 0:1:362351:0 1 0:0:176 176 >
ffff8801420541c0 3793326209 S Zo:4:005:1 -115:1:362351 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793327196 C Zo:4:005:1 0:1:362352:0 1 0:0:176 176 >
ffff880142054dc0 3793327216 S Zo:4:005:1 -115:1:362352 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801420541c0 3793328190 C Zo:4:005:1 0:1:362353:0 1 0:0:176 176 >
ffff8801420541c0 3793328220 S Zo:4:005:1 -115:1:362353 1 -18:0:176 176 =3D =
00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880142054dc0 3793329165 C Zo:4:005:1 -104:1:362354:0 1 0:0:176 176 >
ffff8801420541c0 3793330191 C Zo:4:005:1 0:1:362355:0 1 0:0:176 176 >
ffff880154ae6c80 3793333265 S Co:4:005:0 s 01 0b 0000 0001 0000 0
ffff880154ae6c80 3793335191 C Co:4:005:0 0 0
root@richardiv:~#=20


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRceLVAAoJEN+cO+D+7b7va40P/3wUNE+wkjdcZaaf6fPYpRRi
pHSWlWhsHgKywvk8oiuR1C/IsLs+Tn90Cy7ZIhlaTjZq/+u7m2emh5Rnlpb1Bn5l
Om422XOcbXE36jRCY5hiIi9XjOPvK7l5N04vQHdGXedZ/aji6SrYAEw8d4aiQWQT
L+vBX7kkbYEOoybXsRmkOeIYDEJaD1XPMuE0RVmiIp7UIDiDCk1AbWfa30zx57hb
WoxhCl1xrpjNFWCjoyNEFMMKJ+v7FCgx6EdtGQGh0ZI8kb9FPQIMD7yrsCAMpJSC
c8PqntJrPkZ2I2uTbb3mjrmkQ/cJ4ZP8YmEsAsbFSOQ/9ZCjNteob2cbJrIxtDT1
Nf0pH19DFUzlR+k+/LcBl9hKirXChbQNTJXEvF5DaGk6KqNfYqDxcW3ODn0CzV/x
Mk2AxQoEgmBoNDU71/o5TAEAlhcIkwIyPSbijbcBvgfmLobIDM751dkZX8TBVVNH
U0YcjzFFd6wQZ+zeNBGBpYDRno3H5acaUGNZxaWhAAf/tP0i0+LpucYPfRNlVvQF
w+7Z1jl54UBiLY/jNcO80JkqlspAIyvCNgkVLbPMlN+yZvYXE32lJ6KXJ3BXTYB2
etoljU+nckOxq3+qELjKjof3qOHgoqecHBbIubWmvbx2KNK36V4NhQKGPyWJw1Pb
kSr+HhyVpBUlwSH15YeT
=Ywbz
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============1317642456468470199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1317642456468470199==--
