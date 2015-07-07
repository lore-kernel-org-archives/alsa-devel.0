From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Move irq request to
	rt5645_probe
Date: Tue, 7 Jul 2015 13:55:55 +0100
Message-ID: <20150707125555.GH2887@sirena.org.uk>
References: <1435649441-1941-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6741267258967683995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30999265486
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 14:56:15 +0200 (CEST)
In-Reply-To: <1435649441-1941-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6741267258967683995==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2015 at 03:30:41PM +0800, Nicolas Boichat wrote:

> rt5645_jack_detect_work (the workqueue called by rt5645_irq),
> needs to access rt5645->codec. However, this field is only
> initialized in rt5645_probe. This can obviously lead to kernel
> panics.

> Fix that by moving the irq request from rt5645_i2c_probe to
> rt5645_probe. Also, fail if the IRQ cannot be requested, and move
> irq_free from rt5645_i2c_remove to rt5645_remove.

No, this is broken - we want to be requesting resources in the device
level probe since it integrates better with things like deferred
probing.  You need to fix the interrupt handler to cope without the
CODEC.

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVm8xaAAoJECTWi3JdVIfQq30H/iwHlNEx3Ruwli193dDEZoFL
kpjDPraBB9yFrYGsGZ5oWQcwRbkDaMCPgwAv9xhA46XZknblNcUYGcSjy79xgjvQ
2dd/BtUopurRIDZsaGvpmV2fyX3BeXrUx0pltB+Lzx9vlL7rtdcs0wgnZE8OmV9o
PG0ISqc2Es2Tzr3XxVVe8g0btu4KMPAGC52Oqix6ZjrgwBoLWs9iGTMDLwtnxPhg
dbeb7H4BHwZXEp5qeXoMcJSkHiBYd+bXi4EOj1r05k1Wxzgo/JOdk0qPO0UitsBj
YCKTJw1JQQltSh/TfPMsbLP9nG3hoFBquJLYQJlEeDfzCbQTFTyxwYyYuSZJK2g=
=2Lso
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--

--===============6741267258967683995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6741267258967683995==--
