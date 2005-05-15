From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0_synth
Date: Sun, 15 May 2005 14:41:13 +0200
Message-ID: <200505151441.18029.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <200505131628.03297.alien999999999@users.sourceforge.net> <4285B2D4.8010506@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1554493.6XHhDxEBtE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4285B2D4.8010506@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

--nextPart1554493.6XHhDxEBtE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op zaterdag 14 mei 2005 10:12, schreef Raymond:
> Would you post the result of "more
> /proc/asound/au8810/codec97#0/ac97#0-0+regs" ?
>
> http://www.wolfsonmicro.com/products/digital_audio/ac97/WM9701/
>
> Unless ALSA mis-identify the AC97 codec on your au8810, WM9701A is a
> stereo codec
>
> Do alsamixer or windows driver told you that your card has "4 speakers
> mode" or your card has out1,out2 jacks and coaxial SPDIF ?

I have no windows or a 32bit OS. the card manual told me it had a 4 speaker=
=20
and stereo mode, i never used the 4 speaker mode, so I can't be sure of=20
anything like that. I'll try and look for the card manual some time.

I'd like to have other stuff fixed first, if you don't mind, my volume is=20
randomly changing at certain points (the 32bit compile didn't have that) an=
d=20
sometimes the audio modules hang (since that patch, i haven't had that=20
problem anymore).

furthermore, i notice that I can't choose between 41000 and 48000 Hz anymor=
e=20
in alsamixer, and that the equalizer sliders look odd (though i never used=
=20
them). i can tell you only what changed versus the 32bit mode, and=20
with/without the patch.

i got the vortex reg error in the 32bit version too. and i never had a=20
problem.

> http://www.watch.impress.co.jp/akiba/hotline/991106/newitem.html#19
>
>
> EN_CODEC0 - enable the front channels of au88x0 to ac97 codec
>
> EN_CODEC1 - enable the rear channels of au88x0 to ac97 codec
>
> Alien wrote:
> > Op vrijdag 13 mei 2005 16:05, schreef Raymond:
> >>It is abnormal to get the message "vortex: reg error" on your au8810, it
> >>does not appear in my au8830.
> >>
> >>http://savannah.nongnu.org/support/?func=3Ddetailitem&item_id=3D102951
> >>
> >>You will need to find out the code which cause "vortex: reg error".
> >
> > if i have some time, i will try it...
> >
> >>You may try the following:
> >>
> >>1) Remove code relating to SPDIF ( only SQ1500 and au8830 has SPDIF )
> >>
> >>2) use hwwrite(vortex->mmio, VORTEX_CODEC_EN,
> >>hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC0);
> >>
> >>No need to use (EN_CODEC0 | EN_CODEC1 ) since your au8810 only has
> >>stereo codec.
> >
> > you sure about that, the card told me it had stereo and 4 speaker mode?
> > or are we talking about different stuff?
> >
> >>>>Use alsamixer to find out which ac97 codec on your au8810.
> >>>
> >>>chip: Wolfson WM9701A
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart1554493.6XHhDxEBtE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCh0NtuBWKXETrtdcRAnpJAKDEMlH4Is039m42okE1T4VcHNd1HwCcDBs+
HtSHcvGaISqm1Nsg00P3UpQ=
=KNbj
-----END PGP SIGNATURE-----

--nextPart1554493.6XHhDxEBtE--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
