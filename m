From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 5/9] ASoC: hdac_hdmi: Fix to wait for D3
 before powering off codec
Date: Sat, 20 Feb 2016 00:56:40 +0900
Message-ID: <20160219155640.GU18327@sirena.org.uk>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455725047-7303-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2257481000485801442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B68D3266DD5
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:30:06 +0100 (CET)
In-Reply-To: <1455725047-7303-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2257481000485801442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6wUvnnXCCq76soZt"
Content-Disposition: inline


--6wUvnnXCCq76soZt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 17, 2016 at 09:34:03PM +0530, Subhransu S. Prusty wrote:

> +		/* Wait till power state is set to D3 */
> +		timeout = jiffies + msecs_to_jiffies(1000);
> +		while(!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)

Please follow the kernel coding style - space after the while.

--6wUvnnXCCq76soZt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxzs3AAoJECTWi3JdVIfQalwH/AgxXdHcQa7Abx/URpZOnHjr
o1qlTdnL7bHRQ0YGdSfQG89YG5664l2p7jFIoOvZ1xlLqPOPAmAJnuGNNpWdrRTv
clwrZPjxU9C6IdUhS97YjKP4MGxQ2zGGoYLrp1TTpIX9nnDljt7XvrLhIiCScecp
sTcZjO6zMP4338wtFXS5IaB2Nk6DygNkntu4p0lpdDSKEpuxT0dVO2ogVoHFiuwV
fcGbi4WtihWIzkUkAIYQX8yJz0SSPTedvmI9LoHua5a8LSomFzhqNwBGldiBgSk9
KGMki7ITiAyibEt9HKvNndoo9pyKuApR6Na81Ac72OnPYtF54ZnY+1XKIJ9vZBo=
=2w4A
-----END PGP SIGNATURE-----

--6wUvnnXCCq76soZt--

--===============2257481000485801442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2257481000485801442==--
