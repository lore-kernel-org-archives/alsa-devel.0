From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Wed, 15 Apr 2009 17:59:01 +0200
Message-ID: <1239811141.6981.7.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
	<1239715639.22047.0.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
	<s5h63h60zwf.wl%tiwai@suse.de> <1239810002.6981.2.camel@johannes.local>
	<s5hk55lzzdh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0127070784745180624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id C7E51244C3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 17:59:32 +0200 (CEST)
In-Reply-To: <s5hk55lzzdh.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0127070784745180624==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pACAUpFtFV5dmFz0u5g9"


--=-pACAUpFtFV5dmFz0u5g9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 17:54 +0200, Takashi Iwai wrote:

> > Yes, this helps, thanks. Mind you, if I play music with mplayer _while_
> > hibernating, I get a horrible buzzing when waking up and mplayer says:
> >=20
> > [AO_ALSA] alsa-lib: pcm_hw.c:727:(snd_pcm_hw_resume)
> > SNDRV_PCM_IOCTL_RESUME failed: Function not implemented
>=20
> This is actually no fatal error.  It appears because libao sets
> its own error logger.  But...
>=20
> > Needed to kill mplayer but the channels control is remembered properly.
>=20
> ... Necessity of kill sounds like a bug in either libao or else.

mplayer just hung there, while hda-intel was buzzing away... not very
nice, but I agree it's quite probably not a kernel bug.

> Anyway, I'll add the patch to the next pull request.

Alright, thanks.

johannes

--=-pACAUpFtFV5dmFz0u5g9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5gRCAAoJEKVg1VMiehFYhRAP/1hgXujbrmrusO7M5xej3mt0
FuUqjBSPz3RRp9G2WwZivjI50u4oK9zBxuzJcuIR/mq5dwi3uQacgjYoC8/v1uFz
x9UXbHaa8X+QLh70q2Dc1b/2rtLkRJ/9XfxCQAoShFRKgcecRyQvWbkT2Ud7lqy6
dObaq+zrbhMYJubLSFmPMQfSdAvs1midPDa4NSiNlhBW/9j4pKjvSFpGOxRxFzZz
lIJZwpWom1Jban4lwYNsWf84TKLiHPDpxXHGDYl5pKMdfYS4a5ITKpiNRk+sHVOc
EHySje8eR6IpwTLLC2LK2HHjUZcPr3cMUYrMv9yAlr1GgDnOXQT/9e9akDBJzFHF
rP5N4879tCfwrz96BsxGSVVMM+bC3ANLKUqLGTrim8dXKU6ifMT7MQujvaWE9zpC
dFqerrdAUWNwjq34UTS4E46Cto+NhCDFeaql9F/mw0re41F+ZTkdftxasn7hYAMS
1WnBsO4x0QHYhVEx4fCZ9JfmaxMqxQGtmtYW84lKQwDe+EuUoeAKljmNcyhcRU4Z
tNDu5uTcMsfYHyvUdLcI+c51sE1hgP9TCZ6cJOpkW4x+LOSF/ztZF+GoSPM1fBjJ
CjXL8UngLDlodkLmVmxBr2MB3tnuSVSsH99w3QtBBNUuJ3g2pHuTM4UCXipxlvvr
Khru8XrHu2tU7PKee2rg
=d3Qw
-----END PGP SIGNATURE-----

--=-pACAUpFtFV5dmFz0u5g9--


--===============0127070784745180624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0127070784745180624==--
