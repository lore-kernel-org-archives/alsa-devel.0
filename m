From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.9
Date: Thu, 7 Mar 2013 15:43:20 +0800
Message-ID: <20130307074318.GG22554@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1876166298273853312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 354992615FA
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 08:43:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1876166298273853312==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.9-rc1

for you to fetch changes up to f73c06dc2cbf1ddf1c92f05f9843f923c8c69529:

  Merge remote-tracking branch 'asoc/fix/wm8960' into tmp (2013-03-07 14:29:43 +0800)

----------------------------------------------------------------

ASoC: Updates for v3.9

A few driver fixes, none of them terribly dramatic.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: wm8350: Use jiffies rather than msecs in schedule_delayed_work()

Charles Keepax (2):
      ASoC: wm5102: Correct OUT2 volume and switch names
      ASoC: wm5110: Correct OUT2/3 volume and switch names

Mark Brown (7):
      ASoC: wm8960: Correct register 0 and 1 defaults
      ASoC: wm8960: Fix ADC power bits
      ASoC: wm5102: Apply a SYSCLK patch for later revs
      Merge remote-tracking branch 'asoc/fix/arizona' into tmp
      Merge remote-tracking branch 'asoc/fix/tegra' into tmp
      Merge remote-tracking branch 'asoc/fix/wm8350' into tmp
      Merge remote-tracking branch 'asoc/fix/wm8960' into tmp

Stephen Warren (1):
      ASoC: tegra: fix I2S bit count mask

 sound/soc/codecs/wm5102.c     |   15 +++++++++++++--
 sound/soc/codecs/wm5110.c     |   16 ++++++++--------
 sound/soc/codecs/wm8350.c     |    4 ++--
 sound/soc/codecs/wm8960.c     |    8 ++++----
 sound/soc/tegra/tegra20_i2s.h |    2 +-
 sound/soc/tegra/tegra30_i2s.h |    2 +-
 6 files changed, 29 insertions(+), 18 deletions(-)

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROEUOAAoJELSic+t+oim9PcUQAIIF7llq4sqh1v2uNUiafTUT
E3vnlrpny7Rpkdxsy4ixYDjQQDk3eq25c1lVtlKqz7jsjxRtdFFtVxUKaJ5lizMa
nOtNgPiQy8FHYuVOXcfGbZXFttBykpuIVHysLlcKcwa460fNjBZXZHAjAloPWY47
vbrFk75vpgxuXrrOSQPbHYc2DqdE8mIO3FAYAbYmK5LLLnUc/ArxUpDmAzyvH9w4
0Bg/gavT+wHP6TK4Ql13TmlqwGT8lnTJ6N7pGGN3OZVqVyc11RihaaBhLCfgTaw/
ZX7SGg6kcK7mUSnbuAioLlIkCOxh7XoUHOilHuRBnkb/+Y8MneAuJ6p7Y3tUbPIk
aH+Ftd9zABhTVXWkoZrwgkBS/gBppjWwh+306O3/fRagd9P+gn7BjSrIZEb8cBsZ
haYGBul6oYZPx8fU3rGKfFlXslZkOgGZqgUYbwVVG1kK1d//VCyfILp1CQz+yLGU
ZL/6iIcjqtzk5cJHBjb0lT2CkTL+CxsFPVoJngXK7lZBi5CumgWp7mYs3MBMACYd
TlAH08EivFDfoTYgJLEJEljvWmUQ5/0P3jitcmiqlcAj4jcNAOtuesXAnlFsjAO2
1DRCgFctqDPjgZCwo7+xHaohpVk5XDTVc9tmYEDrVsVWHm6FZg3Op8teybly5Fh6
jlYaa2L4eRLjbIvpsmKR
=CDR+
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--

--===============1876166298273853312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1876166298273853312==--
