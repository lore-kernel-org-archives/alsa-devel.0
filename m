From: Kaushal Shriyan <kshriyan@redhat.com>
Subject: RE: Sound Card Driver
Date: Mon, 20 Dec 2004 12:23:04 +0530
Message-ID: <1103525584.5179.22.camel@oaks.mumbai.redhat.com>
References: <92C0412E07F63549B2A2F2345D3DB515F7D5C6@cm-msg-02.cmedia.com.tw>
Reply-To: kshriyan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IOJvZzZZpPhH6kQszQXH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D5C6@cm-msg-02.cmedia.com.tw>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "\"Tien,  C.L. - =?UTF-8?Q?=E7=94=B0=E6=89=BF=E7=A6=AE=22?=" <cltien@cmedia.com.tw>
Cc: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-IOJvZzZZpPhH6kQszQXH
Content-Type: text/plain; charset=
Content-Transfer-Encoding: quoted-printable

Hi Tien

I have used the following steps
./configure --with-oss=3Dyes --with-sequencer=3Dyes --with-cards=3Dsnd-azx
make
make install

The drivers get compiled successfully, but when I run the soundcard
detection gui application, I get NO SOUND CARD Detected.

My lsmod are as below:-
[root@pcs root]# lsmod=20
Module                  Size  Used by    Not tainted
snd-azx                25692   0  (unused)
snd-pcm                90432   0  [snd-azx]
snd-timer              21628   0  [snd-pcm]
snd                    51172   0  [snd-azx snd-pcm snd-timer]
snd-page-alloc          8296   0  [snd-pcm snd-timer snd]
soundcore               7044   0  [snd]

Awaiting your earnest reply

Regards

Kaushal Shriyan

On Mon, 2004-12-20 at 11:38, "Tien, C.L. - =E7=94=B0=E6=89=BF=E7=A6=AE" wro=
te:
> 9880 is the azalia codec so snd-azx is needed here.
>=20
> ChenLi Tien
> -----Original Message-----
> From:	Lee Revell [mailto:rlrevell@joe-job.com]
> Sent:	2004/12/20 [=E6=98=9F=E6=9C=9F=E4=B8=80] =E4=B8=8A=E5=8D=88 12:43
> To:	kshriyan@redhat.com
> Cc:	alsa-devel@lists.sourceforge.net
> Subject:	Re: [Alsa-devel] Sound Card Driver
> On Mon, 2004-12-20 at 11:05 +0530, Kaushal Shriyan wrote:
> > Hi All !
> >=20
> > I have got INTEL915GM Mother Board with onboard sound chip
> > C-Media CM9880L with RHEL 3.0 Base kernel Loaded(2.4.21-4.EL).
> > I would appreciate if you can guide me how to build driver.
> >=20
> > I have downloaded alsa-driver-1.0.7,but I am getting the below error
> >=20
> > 1 out of 8 hunks FAILED -- saving rejects to file pdaudiocf.c.rej
>=20
> This looks like a bug.
>=20
> But, you could probably work around the problem by only compiling for
> the card you use.  Assuming that chipset requires the intel8x0 driver,
> try cvscompile --with-cards=3Dintel8x0, or ./configure
> --with-cards=3Dintel8x0 in the alsa-driver directory.
>=20
> Lee
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.=20
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20
--=20
Regards,

Kaushal Shriyan
Technical Engineer
Red Hat India Pvt. Ltd.
135, Mittal Towers
13th Floor, B Wing
Nariman Point
Mumbai 400021
India
Tel    : +91-22-22881326/27
Fax    : +91-22-22881318
Cell   : +91-9820367783
E-mail : kshriyan@redhat.com


--=-IOJvZzZZpPhH6kQszQXH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBBxnbQbz6HAjcmEroRAhldAJ4nJLOL6BRM/CYITpJPndYEHpECSACgmguC
yziH9JTXe05xOr1Cr6Fvlbk=
=aZ29
-----END PGP SIGNATURE-----

--=-IOJvZzZZpPhH6kQszQXH--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
