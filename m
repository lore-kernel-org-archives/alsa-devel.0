From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: snd_soc_codec includes
	snd_soc_component
Date: Tue, 17 Sep 2013 13:26:32 +0100
Message-ID: <20130917122632.GZ21013@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87eh94xab2.wl%kuninori.morimoto.gx@renesas.com>
 <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9135695224535844618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DAFBC261675
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 14:26:38 +0200 (CEST)
In-Reply-To: <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9135695224535844618==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/1sb/HZzV9blKCG"
Content-Disposition: inline


--b/1sb/HZzV9blKCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2013 at 07:39:03PM -0700, Kuninori Morimoto wrote:
> Codec includes component by this patch,
> and component moved to upside of codec
> to avoid extra declaration.
> Codec dai will be registered via component
> by this patch.

Applied both, thanks.

--b/1sb/HZzV9blKCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOEp1AAoJELSic+t+oim97ocQAI2/lxlHKRnzf1+0/jPI+N3A
QKm7Rk8UAkbwTmbWXLdru+I9ml0JSlFBY0v+QiD9GBpESehvbhrKUTzQ0v4eSoxB
MO9gr2MBSUEZU1pXhh2UXQwCgbcAZtUXLJf+oC6Y7neYdhxgOM7HUXljAwwoQsle
VIx4VPDG3CHBiStW+T0RkLpgZLnnpZuqFsUYRMPqbNF5sjLP8bCoCB8l6qoIJzO+
NJEimBkMkdco1vJsInvYkaegbj6YB92pjGEZDazJt8WVDFD3zDNxLmdv9bxwGM1m
hDCS7/yYeoGE2AJ8Dy0xSubVkD7Sv9rSp/cc8CsQ2oXi/1MrlVMOHdMTmBEhxmIa
rJ9tjNSzSbMJM1q+1f9wQQLAoWrH8MXUrPSYSDIiFzph4tNkuvFERtDqOsuEqzbR
TgB4fwLav3TBJLB9K1nZGuicRTYws1z8uC0jKfD7iwtrNQ3XYiaW+iX2wEeSJtUZ
RWhr3EVDxJP1xcJVfSBXWkXHsza6YujTD0Pd0TBHwb/Ho5ccz553fTvf0sns1mEk
H8AVlvVoR5MmqSCQnsO+ZWLzhhed4LziSRUxcIY5malrekhgrfT9stFM6WD1VgWu
MM1EPZWfRDTKhuvfatZp3vYNhctRZm7voklyRn2AYx9dW+UXpPwSw/wp+efnCp/M
sqP9panxYgc58YE+P31N
=4B8f
-----END PGP SIGNATURE-----

--b/1sb/HZzV9blKCG--

--===============9135695224535844618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9135695224535844618==--
