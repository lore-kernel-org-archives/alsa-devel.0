From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add master clock handling
 for rt5640
Date: Wed, 24 Feb 2016 12:32:59 +0900
Message-ID: <20160224033259.GL18327@sirena.org.uk>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
 <56CC719C.1090901@linux.intel.com> <2199435.lA9iTvxnKV@phil>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5994723335747866069=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D082606A9
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 04:33:24 +0100 (CET)
In-Reply-To: <2199435.lA9iTvxnKV@phil>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5994723335747866069==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sUeeoP6xcRoKhsB+"
Content-Disposition: inline


--sUeeoP6xcRoKhsB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2016 at 12:08:31AM +0100, Heiko Stuebner wrote:
> Am Dienstag, 23. Februar 2016, 08:50:04 schrieb Pierre-Louis Bossart:

> > This patch assumes that the information on mclk comes from DeviceTree.
> > The mclk may also be enabled/disabled in the machine driver with an
> > explicit transition to use an internal clock when the codec is not used.
> > I hope this patch doesn't preclude such usages or there will be a
> > conflict with the patches we are about to upstream for Baytrail/cht
> > devices.

> As you can see, the clock property itself is optional and the clk_get bel=
ow=20
> acts accordingly of also continuing if the clock is not present.
> So it won't affect any users doing it otherwise.

That said we really do need x86 to transition to use the clock API in
order to integrate with external devices, where the machine driver does
manage clocks we want that to move to being done using the clock API
rather than custom APIs.

--sUeeoP6xcRoKhsB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWzSRrAAoJECTWi3JdVIfQbv8H/3oqQbWebeAQzP6byQrUktJ+
c4ET+PMv/zGNQB56z59nPVoCq8f3f2pNwpjVZisyfx9b5X3nS0pAGklD0bMoVQ6w
zioasc1imvrIhsOpgdUGN7pITmvrXDVpCClofdYLV2XPHL9Oyile9fVvGLESI7hm
KT8b5AtgiatEO/QuzyE/rHCHfs+VW/gPiurV0rMviQSi8vaUm/iA9DDqI2CsXHZG
WbWymCyLEdbm9ms4+3J+5aoHK3/nbKCcowF/JvCTKOz4uuzeJfJKQX7k5lq0CrRL
zy6lzI62g9/BEYVz6P6U0VrPIIP+/YQH1jCK5zmYOpJdhpexJ6NkGCoEsgjUsEo=
=SGcL
-----END PGP SIGNATURE-----

--sUeeoP6xcRoKhsB+--

--===============5994723335747866069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5994723335747866069==--
