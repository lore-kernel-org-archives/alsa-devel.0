From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH] alsa: lx6464es - support index module
	parameter
Date: Thu, 11 Jun 2009 10:43:48 +0200
Message-ID: <4A30C3C4.2060601@klingt.org>
References: <20090610234154.28ba1585@thinkpad> <s5hprdbvb1s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6719032035169505866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 671B6103802
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 10:44:07 +0200 (CEST)
In-Reply-To: <s5hprdbvb1s.wl%tiwai@suse.de>
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6719032035169505866==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig899D4C7BA151AAD6AFABAD70"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig899D4C7BA151AAD6AFABAD70
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> At Wed, 10 Jun 2009 23:41:54 +0200,
> Tim Blechmann wrote:
>> trivial patch to put the device to a specific index
>>
>> Signed-off-by: Tim Blechmann <tim@klingt.org>
>> ---
>>  sound/pci/lx6464es/lx6464es.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464=
es.c
>> index 870bfc5..dd0f12b 100644
>> --- a/sound/pci/lx6464es/lx6464es.c
>> +++ b/sound/pci/lx6464es/lx6464es.c
>> @@ -43,6 +43,9 @@ static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;=

>>  static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;
>>  static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
>> =20
>> +module_param_array(index, int, NULL, 0444);
>> +MODULE_PARM_DESC(index, "Index value for Digigram LX6464ES interface.=
");
>=20
> Please define the similar things for id and enable options.

oh, i wasn't aware of these parameters, just give me a second ...

--=20
tim@klingt.org
http://tim.klingt.org

Your mind will answer most questions if you learn to relax and wait
for the answer.
  William S. Burroughs


--------------enig899D4C7BA151AAD6AFABAD70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoww8QACgkQdL+4qsZfVsuwKQCfSoxswc0o4/1N7Tfej+qTIo7M
pGgAoIy2UarsxQrU1tRoQ5pQ+HPTWFil
=Ygpm
-----END PGP SIGNATURE-----

--------------enig899D4C7BA151AAD6AFABAD70--

--===============6719032035169505866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6719032035169505866==--
