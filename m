From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/11] ASoC: dapm: Remove platform field
 from widget and dapm context struct
Date: Sat, 21 Jun 2014 21:36:28 +0100
Message-ID: <20140621203628.GF22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5274714120311830799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 317C6265104
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:36:44 +0200 (CEST)
In-Reply-To: <1402935191-18398-12-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5274714120311830799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:11PM +0200, Lars-Peter Clausen wrote:
> The platform field in the snd_soc_dapm_widget and snd_soc_dapm_context structs
> is now unused can be removed. New code that wants to get the platform for a
> widget or dapm context should use snd_soc_dapm_to_platform(w->dapm) or
> snd_soc_dapm_to_platform(dapm).

Applied, thanks.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpezJAAoJELSic+t+oim9PQAP/i5UxYghehTCU/ZXwM9fBgGZ
NfxrCql2WprWST1E6B8ZcIdz4PJYF8PPgWpnnUwrkGfjILHtmfsJZ9FIKH84t4dQ
BONwo32k8y1GPfQwWqwFjKodHl7qWRz9Sq9jrvmFW2Av1xkhmDvJcICq+oHmdPdN
JlleLv2xUDv7NBQNoYbfzKuO9TxIglydzOgzxy2eErHJIR/Kz8H5kS4JOUW5ZkOk
JQfPOFZDvdF3docTI0n/hNNB5RUXPx0m3mZ0bUeazTdZReMgT2TVHHuJcyOjqO27
/btBeSo72L22de31VsnNtAPpsmQb/rR6PDKhK16pXZC5wUJfzOyY0vfMzMQtXRrt
wH1dSbupgTknYhk2MP+S+YP5KwTdhBzWfAfqkMpkWHIClqigSp9yl33+So/BgrwM
u5Lb0MFJyQtPZE7v6NorxQKTC3UPKx44I0fH9pUJrDasvOl1kuqbrStNyrfX5olq
SMygFji8Tn20wLs7lh0+bXze6krgIuv2FjdsnA/xg30zr9QRUHfrEEnnK58p4Uh8
gXuP5yZupHxkMRuMSimMM/0QY/dZQ2TS8kWhuESl+6mFefvBqRbLjKjCN70tB4qN
ne4ZAtaUrN2hbf1jXvA3+ZGt53mgW7F9PPqwEEyKmvi5DH+jL8LdDt1K5eW0Lyg3
xQlim8J5mzw5oeW7Yi/h
=kcSf
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

--===============5274714120311830799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5274714120311830799==--
