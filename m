From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Added the condition for the
	channels_min of cpu_dai
Date: Tue, 30 Apr 2013 19:42:26 +0100
Message-ID: <20130430184226.GG26160@sirena.org.uk>
References: <CANXQt8bj5ZB9aSd5jNC34TYeg4SnGz9h00JJQBS0vHQdEW5LRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3323054824303630544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C2C2650A9
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2013 20:42:31 +0200 (CEST)
In-Reply-To: <CANXQt8bj5ZB9aSd5jNC34TYeg4SnGz9h00JJQBS0vHQdEW5LRA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: JongHo Kim <furmuwon@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3323054824303630544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2013 at 03:31:16PM +0900, JongHo Kim wrote:
> Only playback device, the pcm substream for capture does not need to be
> generated. If codec dai driver has both playback.channels_min and
> capture.channels_min, and cpu dai driver has only playback.channels_min,
> soc_new_pcm() will make the pcm substream for capture although
> DataIN is not connected.
> So added the condition for the channels_min of cpu_dai in soc_new_pcm().

This doesn't appear to apply against current -next, can you please check
and resend?

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgBCPAAoJELSic+t+oim9KdEP/A1dHle9TOJbnqX0sC1zK4Sd
jcPWlKKnCXPQTa3AvpH+iggn3oubcvnRL209gsCdehfLXOupYm8BCfKQR7UWo0sp
nZYV4prcwd+p+2T79pwx8X5aa2x8+vqXwsGMBtg8j5oQgtpF8kFhsOgGkRLerq8a
cFPY241BcTAnmeKeY6DU3gkEHqKotLjkiP7pXv5ByyIw70P78i73W1tXJs2yyiok
tX0aKVaIhwblCOuEEuEPCokVSXUMXv2qtr7HMRsv0GYyVoU16dk3e7JkIpW/y5GQ
aVptBhOBFitHQjlU/RyCuvXTYpvgTN7Zducm6S5n+bcE+lBGmPgJp77xhAF66oLd
RPMQcN0zQMDNEtdGcM9EkUoJKP5Xcz4A5fodZXNNRFdqc9kNKeaERyYgZnyghtDL
TCZW59PFeMghlgeCEPkYgpHiGCePaSNG2UC+8xXJ2rUvDjQyft9D+0HTz8LVBILV
qc6NP2ZCVb2KXUI6HDwdCXzxVqjjfDLcljGbfzuM6MPXtKiczlq4jJDLHq+SeYq1
TcPefOAchBnz/9XWbHFnxJ7qH/vAoe7hDxddoz92kDr/wdU5opnAml9e1hAuZmmQ
13xac/TagoDahuvKr1A25a+ddyUlHQVjW4Ce04Pyg4FjvHV/YeTU8GNoGpeOsQ8t
9dB4LmDGW6Rd/c3rfoPr
=Wqga
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--

--===============3323054824303630544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3323054824303630544==--
