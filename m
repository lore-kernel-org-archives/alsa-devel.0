From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rockchip: fix a misjudgement by return
Date: Wed, 26 Aug 2015 11:48:19 +0100
Message-ID: <20150826104819.GO12878@sirena.org.uk>
References: <1440559244-17634-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zBPbvmIlJjvpbu6L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440559244-17634-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zBPbvmIlJjvpbu6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2015 at 11:20:44AM +0800, Xing Zheng wrote:
> Being careless, judge the return value of snd_soc_card_jack_new
> is opposite, so it should be fixed.

This patch has been applied already.  If any changes are required to
already applied patches please send incremental patches against current
code.

--zBPbvmIlJjvpbu6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3ZlyAAoJECTWi3JdVIfQiLMH/jLj7Msvqqqi2s7gpGDTuFax
kNAkQ26s129Q9MbpDcjgYZ+QBpYYAhAl+W823bSzGq9R1E273DwlEodXZvL3FUo8
X8ddoIX3V9UfhUiMtHR6WfivxqGoP6/6wEQZnF18LmjYT9K2hJsvpEFdIKyos25q
EWVXFSEfZGFX+0Jr+2GB9v0lPWo+TnDtOjOsql4dzQjPv1zZu1TcvxdPcs0OrPjg
0GVoG29VO9UI98on7XX+HQg79KyUR498XAgGtxMZZAW1AETVruNsVZhCDeAa1Qw6
VIn30NKiE5BcQEL/0p/CKGVkDUumy799IpwUTC1jTxzVmxve5D2ZePbECvWsem4=
=+pcx
-----END PGP SIGNATURE-----

--zBPbvmIlJjvpbu6L--
