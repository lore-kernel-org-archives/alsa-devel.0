From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Fri, 25 Jan 2008 15:57:55 +0100
Message-ID: <200801251558.02569.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<s5hr6g87qfu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6089624481490250494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C8F524813
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 15:58:05 +0100 (CET)
In-Reply-To: <s5hr6g87qfu.wl%tiwai@suse.de>
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

--===============6089624481490250494==
Content-Type: multipart/signed;
  boundary="nextPart1232032.OgXB5Utr4j";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1232032.OgXB5Utr4j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Mittwoch, 23. Januar 2008 schrieb Takashi Iwai:
> The SPDIF is disabled intentionally for your model because no one
> could test it.  Does the patch below work?

I tried this patch on the newest hg-version a few minutes ago. Digital-Out=
=20
still does not work, even though there is a IEC958 in the alsamixer now.=20
By the way the digital-out is shared with the analog one (green 3,5mm jack)=
=2E I=20
only get an analog stereo signal whatever the state of the IEC958 is.


Regards,
Martin

P.S.: There is also the not so demanding problem that the internal mic has=
=20
never been working

--nextPart1232032.OgXB5Utr4j
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHmfj6VG/GfU56d2wRAvzFAJ0TelMa7MTyiQ3POINz7/4XQ4h+DwCcDbqx
s1hNVk0ddnVvEBfOo9JUKfY=
=GwT8
-----END PGP SIGNATURE-----

--nextPart1232032.OgXB5Utr4j--

--===============6089624481490250494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6089624481490250494==--
