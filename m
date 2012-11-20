From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Forward: [PATCH 030/493] ASoC: max98088: remove
 use of __devexit_p
Date: Tue, 20 Nov 2012 15:25:52 +0900
Message-ID: <20121120062550.GE10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-30-git-send-email-wfp5p@virginia.edu>
 <s5hfw44re0g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2306585316570267689=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EB93265005
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 07:26:01 +0100 (CET)
In-Reply-To: <s5hfw44re0g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: Takashi Iwai <tiwai@suse.de>, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2306585316570267689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 07:21:03AM +0100, Takashi Iwai wrote:
> In case you didn't receive it...

> Date: Mon, 19 Nov 2012 13:19:39 -0500
> From: Bill Pemberton <wfp5p@virginia.edu>
> To: gregkh@linuxfoundation.org
> Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
>  alsa-devel@alsa-project.org
> Subject: [PATCH 030/493] ASoC: max98088: remove use of __devexit_p
> X-Mailer: git-send-email 1.8.0
>=20
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed, remove it.
>=20

Applied, but only because Takashi forwarded it to me.  Like I said in
reply to your other postings *AWALYS* send patches to maintainers.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqyJXAAoJELSic+t+oim9JpYQAIoSkDfzIcAypIo54dm9zTZ7
yzMAw6fFAKqOJZi4+4cT/ESDAsIqwo4K0z2HpNhqCvywTJ6Jb+FqeABE1ZTeESqp
wdFxJ8ptoFYE3OgAjxeGVrRA+umm3nwV6sbuYHx5fHiojwdQDFUdoKMreVnuMe9y
LOaifTfbfRIKlcT2DKsFaduXAGmtomK0952XAEupBVKmOk5kf59aGiwY0Jq2kMw8
BgemMFIf95xvLpE7/sj01rCKgteAlgBXZn1BYR1nW0DWjjip4yTmXmNh/xUxXbT4
qGUh4jXFP6SaPCdQ6baQibB6H3jmg5b+XAH39sJUFcWdhnLCq2VY3+xyg3SyGOei
3pMsARUH6HKLhf3QuEh9wZJlg25WsfMSo5mOtMRr/maLvlVXO4VQytUM70cdi+q6
vXTJtVIV1T38q9frRs6szk3G0aW4XtTQGefz9V6yxnvOMSi7j/3w5GZO2saWr95z
aO5K2juWAICoNXc9mPbIdMqHKB+5/X1rgzZMwNb/g9RE0Np6i5ifYvBcg+pgf3zz
0TMThYox1zbSZIHO/nj6/0tPu3ernhbCvDSUmOK/TVJcov9mz28ywKgdwRTYvhi+
JAnXrbm+n9oxPsG2A5Rn401E/bXlSbWMicccEg9eo3maWJ/9SAhoaos1PssD/cvo
EP1ryG1vNShCmt9046Cw
=PEGu
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--===============2306585316570267689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2306585316570267689==--
