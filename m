From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Sat, 9 Feb 2008 13:01:18 +0100
Message-ID: <200802091301.25360.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<s5hhcgjyaqj.wl%tiwai@suse.de> <s5hprv7wiil.wl%tiwai@suse.de>
	(sfid-20080209_111524_764646_9F79E8CD)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5035737507546944005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 794B52464F
	for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2008 13:01:27 +0100 (CET)
In-Reply-To: <s5hprv7wiil.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5035737507546944005==
Content-Type: multipart/signed;
  boundary="nextPart1364587.84TAJZabIh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1364587.84TAJZabIh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Freitag, 8. Februar 2008 schrieb Takashi Iwai:
> At Fri, 08 Feb 2008 11:59:48 +0100,
> I wrote:
> > At Thu, 7 Feb 2008 22:55:40 +0100,
> > Martin Egge wrote:
> > > Am Donnerstag, 7. Februar 2008 schrieb Takashi Iwai:
> > > > The patch below adds the automatic mic switch for Samsung.
> > > > Give it a try.
> > >
> > > I gave it a try on the latest HG. You almost got the hang on it. The
> > > internal mic works for the first time with model=3Dlaptop-eapd. But t=
he
> > > jack sense (autmatic switch to external mic when connected) does not
> > > work. Both mics are recorded at the same time.
> >
> > Do you see any difference in codec# proc file between mic-plugged and
> > unplugged states?

Yes there is a difference:

With mic plugged I get the following in lines 161 to 172 of codec#0:
=2D-----------------------------------------------------------
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01019015: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x1, Sequence =3D 0x5
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0d
=2D-----------------------------------------------------------

With mic unplugged I get the following in lines 161 to 172 of codec#0:
=2D-----------------------------------------------------------
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01019015: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x1, Sequence =3D 0x5
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0d
=2D-----------------------------------------------------------

> Anyway, the patch below might work better.  Give it a try.

This patch does not work. The external mic is always disabled and there are=
=20
not differences in the codec# proc files.

Regards,
Martin

--nextPart1364587.84TAJZabIh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHrZYVVG/GfU56d2wRAi0LAJ93TXwT6G3gKO4M7jDroXMmBvxMfgCeMPW+
VgPg5GdJfXZmiKNQhWh/e60=
=NfNK
-----END PGP SIGNATURE-----

--nextPart1364587.84TAJZabIh--

--===============5035737507546944005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5035737507546944005==--
