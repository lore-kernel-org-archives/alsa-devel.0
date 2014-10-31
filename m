From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/14] ASoC: wm9712: Cleanup printk usage
Date: Fri, 31 Oct 2014 17:32:29 +0000
Message-ID: <20141031173229.GK18557@sirena.org.uk>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
 <1414699271-22797-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8114378771415748776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A5226148A
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:33:05 +0100 (CET)
In-Reply-To: <1414699271-22797-9-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8114378771415748776==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YF/0G2n1m4k2mZ5L"
Content-Disposition: inline


--YF/0G2n1m4k2mZ5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 09:01:05PM +0100, Lars-Peter Clausen wrote:
> Use dev_err() instead of printk(KERN_ERR. This is common practice and makes
> it easy to find out which device generated the message. While we are at it
> also align the error messages with the other AC'97 drivers.

Applied, thanks.

--YF/0G2n1m4k2mZ5L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU8esAAoJECTWi3JdVIfQm9MH/0sjhl0GNcM/CgPXQm44UEx8
1EHH2vrXIvw35iYKaOJsMmIAPWpULHF7IdvUp68tcrhA+PNtgpPfYYTb9U9eoYkz
oQKi5S5HRdJSdpLsEHlyJ12F0tBTrK/Ojw3/MLqzePnz9S+aGaNnZ8YBhn+LvkbE
Ou45Gz0IuYPELKZWAXfuA3DWSClWBU9DkNf5HJZdcP+A1U2U0pRD87FLm8QcIh/M
8RZERsNz4hCksf1tgnV1jy5JrPaNfQLRQ9uGfzVmq2dYzcOJCM7AXabv8/9WAwf2
X8bggzQlOjkSnN1bSkNfzlB7QTahMCAps6KLBH4F9LL4vWDkUhPwfof9DtCRwWg=
=5vNM
-----END PGP SIGNATURE-----

--YF/0G2n1m4k2mZ5L--

--===============8114378771415748776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8114378771415748776==--
