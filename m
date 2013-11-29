From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 11:05:49 +0000
Message-ID: <20131129110549.GQ27568@sirena.org.uk>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0006173608166093123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 78053265558
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 12:05:55 +0100 (CET)
In-Reply-To: <s5hsiufedxu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0006173608166093123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gblAvmLjk8yGG9If"
Content-Disposition: inline


--gblAvmLjk8yGG9If
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 10:48:29AM +0100, Takashi Iwai wrote:
> Jaroslav Kysela wrote:

> > I basically agree, but... I believe that these chunks can be divided to
> > the 512 limit using continuous indexes (kcontrol->count) and a simple
> > rule in the driver "write all to a DSP when the last control (index) is
> > touched" may be enough. No API extensions are required. The question is:
> > Do you rellay need 100+KB for coefficients? Do you expect to handle
> > these data in standard tools like alsactl?

It's certianly possible to do something like that while maintianing the
ABI, however if we were going to do that we'd probably want to extend
alsa-lib and tinyalsa to do this transparently and devise a naming
scheme for the controls to trigger that behaviour.  The main thing is
the API offered to users.

> Yeah, I suggested a similar workaround when the issue came up ago
> (IIRC, it was about WM codecs).  But it's certainly ugly, indeed.

No, that was originally for Qualcomm - they were wanting to download
megabytes of data.  There were some patches from Wolfson more recently
though they're for much smaller data sizes.

--gblAvmLjk8yGG9If
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmHUJAAoJELSic+t+oim9r78P/1OpEq1g0NnGBED07FdMtJJz
W7rHmQE9g1JelpjHEtIj5gAiRio1LaTidqhfKPjkMlf0JWfI/R6u8hpQifciVpLm
5uUoR1Dl1JpGnaznCk/KNkyqTzZQlxGh4FmwakZPVFPoq6ZtWx8QoXlYadOptdii
nsL8zkqcrQN879KCL2dJhP+Ecqhhm8raTVyrHtI6h6EPWZLPDUx7omm8tA2wDxhS
qdMUdyeJxL/VsNR1TTTULB33NXSwsfy+KkoFPnMDPEB1No1Jk2K/vJUIRf77V0Yc
Ayi3ON3U+NXNHhY/B/4FtQ8LCHi5H5QiqEdRFGWIEwUjCbDM0nbgW+/P7uPafXfE
2L5n6C+cODhpS38ir23+MsCMn7tH1y6vgD7zf1r99ZYCtfL/Il7wkqkROwPu1EQV
m3WRpqrAskSv/ghz+O5LpvFi+VqdRsvT1tePLvMwqpJMwJWYlCNgpDMRHwW5F4AQ
xQEX/LqhqhpU2FNKuzHpc/7NXpKm8pLHvD6lZIxLyXyOZszTKxYnq3xB0kjeR+s1
nIK8Jc3iE42YFPO62wZ4wGIPGpe5LF7BLgswZLXdOpbupzx+bUZvCG+ysTco4dim
jJ+nuG/FoiCYPgLS+X/kImzw9x2oU88BRHVgk7n6xHwC4WIzfGSPE6D+cx4Q701r
0+816A4P5ZzEH2s/Rsjd
=/1yP
-----END PGP SIGNATURE-----

--gblAvmLjk8yGG9If--

--===============0006173608166093123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0006173608166093123==--
