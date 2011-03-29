From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH alsa-kernel] snd-hda-codec-realtek: Add
 quirk for Jetway NF92
Date: Tue, 29 Mar 2011 15:46:04 +0200
Message-ID: <1301406364.15348.35.camel@mattotaupa>
References: <20110328184307.GJ29800@alittletooquiet.net>
	<1301389809.15348.3.camel@mattotaupa>
	<20110329133607.GL29800@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3451496990117405844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A927103937
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 15:46:07 +0200 (CEST)
Received: from f053045115.adsl.alicedsl.de ([78.53.45.115]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q4ZFF-0000gZ-PA
	for alsa-devel@alsa-project.org; Tue, 29 Mar 2011 13:46:05 +0000
In-Reply-To: <20110329133607.GL29800@alittletooquiet.net>
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


--===============3451496990117405844==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2v8/xiZHyvY3fqRdFuAV"


--=-2v8/xiZHyvY3fqRdFuAV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Forest,


thank you for reporting back.

Am Dienstag, den 29.03.2011, 09:36 -0400 schrieb Forest Bond:

> On Tue, Mar 29, 2011 at 11:10:09AM +0200, Paul Menzel wrote:
> > Am Montag, den 28.03.2011, 14:43 -0400 schrieb Forest Bond:
> > > The Jetway NF92 mainboard works with model=3D3stack-6ch-dig.
> >=20
> > what did not work before?
>=20
> My testing notes say that the S/PDIF output did not work and the analog a=
udio
> was too quiet, but I'm no longer able to replicate.  Maybe I made a mista=
ke
> during testing.
>=20
> Please disregard the patch.  Everything seems to be working fine without =
it.

Great.

> > > Add a quirk to automatically configure the codec accordingly.
> > >=20
> > > Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> >=20
> > Please make sure that your From line and Signed-of-by line match.
>=20
> Okay.  I generated the patch on my work machine but my list membership is=
 with
> my personal address.  I think I can fix this by putting a From: line in t=
he
> message body (that's what some experimentation with git send-email sugges=
ts).

I think that is the way to do it.


Thanks,

Paul

--=-2v8/xiZHyvY3fqRdFuAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2R4pwACgkQPX1aK2wOHVhfLACgiKzEZRn/DJLAX8NGN3lL79nA
ucYAniGPnHvM6apFxdJPiic56Sq4XD1D
=ra21
-----END PGP SIGNATURE-----

--=-2v8/xiZHyvY3fqRdFuAV--


--===============3451496990117405844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3451496990117405844==--
