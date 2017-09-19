From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v12 2/2] ASoC: rockchip: Use bus_type to
 distinguish rt5514 dsp from rt5514 codec
Date: Tue, 19 Sep 2017 13:46:13 +0100
Message-ID: <20170919124613.egvojfhq74vhyvuh@sirena.co.uk>
References: <20170919025439.7107-1-jeffy.chen@rock-chips.com>
 <20170919025439.7107-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4684761327279581854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C152266F0D
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 14:46:21 +0200 (CEST)
In-Reply-To: <20170919025439.7107-2-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>, dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4684761327279581854==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k5xry7gwnpen5pqo"
Content-Disposition: inline


--k5xry7gwnpen5pqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 19, 2017 at 10:54:39AM +0800, Jeffy Chen wrote:
> Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
> Use bus_type to distinguish rt5514 dsp from rt5514 codec.

This doens't apply against current code, please check and resend.

--k5xry7gwnpen5pqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnBEZQACgkQJNaLcl1U
h9BBwwf/cEUFYKeCMaCWIoQEo2IprqsR6YKOmNtig4au9FPjVg+sxXRoAdrqy/Kx
d7oCC7VOC+Vl3MblO1R7xhRWQFNugtVMZ1+Nf0JxQ3D/GVM12p2BIfIN+iR5N82g
5OjGo6sVsmqa36iX2VHqpzGeJYw9GVKbrNrC0x0SeP8qGSyXx4YsMlqqmIirsjpc
q2nM1wWHOVZs07x21CZsTacHMSQsazMqKtgaRlFQlIWkkO9QBMGQyWjIL/NKRnpD
ePxk4Epe/fxUiZoWtbqkeuIiXmyF8BIseeRIgptb1jhe5coi8hpEHbbxIWXyki0W
S95eBI5FkTxLUq/bHqhWSnbn2y2dGA==
=4g+E
-----END PGP SIGNATURE-----

--k5xry7gwnpen5pqo--

--===============4684761327279581854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4684761327279581854==--
