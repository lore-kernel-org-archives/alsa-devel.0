From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re:
 =?iso-8859-1?q?Samsung_P50_Heaphone_Jack-Sense_not_w?=
 =?iso-8859-1?q?orking_with=09latest_ALSA?=
Date: Wed, 24 Jun 2009 17:14:38 +0200
Message-ID: <200906241714.55484.mailinglists@martin.egge.info>
References: <200906231425.47946.mailinglists@martin.egge.info>
	<s5hhby5akne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8623666161652709269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 34CCB103814
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 17:15:06 +0200 (CEST)
In-Reply-To: <s5hhby5akne.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============8623666161652709269==
Content-Type: multipart/signed;
  boundary="nextPart2539166.pmGTm3nvHa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2539166.pmGTm3nvHa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Takashi,

Am Mittwoch 24 Juni 2009 schrieb Takashi Iwai:
> Does the patch below work?  It's against the latest alsa-driver, not
> 1.0.20 nor 2.6.30.
> =20
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-s=
na
>pshot.tar.gz

The patch could not be applied.

patching file sound/pci/hda/patch_analog.c
Hunk #1 FAILED at 72.
Hunk #2 FAILED at 670.
Hunk #3 succeeded at 702 with fuzz 1.
Hunk #4 FAILED at 757.
Hunk #5 FAILED at 798.
Hunk #6 FAILED at 808.
Hunk #7 succeeded at 940 with fuzz 1.
Hunk #8 FAILED at 971.
Hunk #9 FAILED at 983.
Hunk #10 FAILED at 1006.
Hunk #11 FAILED at 1094.
Hunk #12 FAILED at 1108.
Hunk #13 FAILED at 1123.
Hunk #14 FAILED at 1156.
12 out of 14 hunks FAILED -- saving rejects to file=20
sound/pci/hda/patch_analog.c.rej

Regards
Martin

P.S.: See [1] for patch_analog.c.rej

[1] http://pastebin.ca/1472677

--nextPart2539166.pmGTm3nvHa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpCQt4ACgkQVG/GfU56d2yt9ACZAadAq50jcMOmedgnIRQEeQc1
e0QAnR9gktAOOgl5jzUk9mylHloN1ZDx
=fmwI
-----END PGP SIGNATURE-----

--nextPart2539166.pmGTm3nvHa--

--===============8623666161652709269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8623666161652709269==--
