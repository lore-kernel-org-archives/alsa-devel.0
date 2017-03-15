From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: sun8i-codec: Update mixer to use
 SOC_DAPM_DOUBLE" to the asoc tree
Date: Wed, 15 Mar 2017 13:43:23 +0000
Message-ID: <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
 <E1clbY9-0000DH-LY@finisterre>
 <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5360590623768876407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5511F266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 14:44:14 +0100 (CET)
In-Reply-To: <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5360590623768876407==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n2uvbpnnrncu25wb"
Content-Disposition: inline


--n2uvbpnnrncu25wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2017 at 12:31:22PM +0800, Chen-Yu Tsai wrote:
> On Wed, Mar 8, 2017 at 9:22 PM, Mark Brown <broonie@kernel.org> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> This patch changes the mixer controls exposed to user space.

> This driver was just introduced in 4.11-rc1. Would it make sense to
> merge these cleanup patches as fixes for 4.11, so we don't affect
> userspace across kernel releases?

It would but it doesn't pick over cleanly, it looks like it depends on
some of the other changes.

--n2uvbpnnrncu25wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljJRPsACgkQJNaLcl1U
h9Dj/wf/SNU2hHs4DgTS+ihcsCYQZJe/qr7Q1z2HfrembKBZDasroMYh41IrKigQ
/qOT8TVZDNNwONty6k53PVQfOba85BoVtHzgyBr4STtRGAGwNo60NlHS9SYsbLJp
wT5rt7lC57mSN3Zb8SYq5NAX9gu4sHVZmjajp6FYbhunVHFCVCcMVmi0Es9qmdGL
ZA7fcm6Eu2swtX9gzny1BYZjKW2fMuFhtj5KaJUookc/SRqtek5vQAmV5sByayw2
TAXpzsV2bdseEBBHKVn4eVqeuRc7kac/eCSUzheXQz0Kq1twHVH+O0fl9BJFkW7W
CWEw9l4duWBKscI6UsFp8CGAcdYUog==
=WuMp
-----END PGP SIGNATURE-----

--n2uvbpnnrncu25wb--

--===============5360590623768876407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5360590623768876407==--
