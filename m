From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Fri, 25 Jan 2008 20:05:29 +0100
Message-ID: <200801252005.42391.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<200801251644.52626.mailinglists@martin.egge.info>
	<s5hwspxj2ir.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2442151872574567634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E26732474A
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 20:05:45 +0100 (CET)
In-Reply-To: <s5hwspxj2ir.wl%tiwai@suse.de>
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

--===============2442151872574567634==
Content-Type: multipart/signed;
  boundary="nextPart2092794.JK4qn4u0BG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2092794.JK4qn4u0BG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Freitag, 25. Januar 2008 schrieb Takashi Iwai:
> Thanks.  I couldn't find any missing setup for the SPDIF.
> I thought the similar setup worked well on other machines with
> AD1986A, but I'm not sure whether it's still OK with the recent
> version...

Is there anything I can do, to help you to get it working?

> Anyay, the patch below is to change the mic input behavior.
> With the patch, the mic input is toggled automatically via jack plug.

The external mic input is toggled via jack plug now. But the internal mic=20
still is not working.

> It assumes that you didn't change the model preset
> (i.e. model=3Dlaptop-eapd).

What does this mean? Do I have to insert
options snd_hda_intel model=3Dlaptop-eapd
in my /etc/modprobe.d/alsa-base or not?


Regards,
Martin

--nextPart2092794.JK4qn4u0BG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHmjMFVG/GfU56d2wRApRGAJ9chM1K/RxbHYilu0iMN+8x6XlAWwCfZex9
KCUyG/1iTC7g7iHz948PIXY=
=Qs/z
-----END PGP SIGNATURE-----

--nextPart2092794.JK4qn4u0BG--

--===============2442151872574567634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2442151872574567634==--
