From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Allow 4 channel recording on
	AIF1
Date: Wed, 30 Sep 2015 20:03:08 +0100
Message-ID: <20150930190308.GY15635@sirena.org.uk>
References: <1443472357-12150-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5025388219265735236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7990F266415
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:03:15 +0200 (CEST)
In-Reply-To: <1443472357-12150-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5025388219265735236==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MTFjS3R2zZZVGaSB"
Content-Disposition: inline


--MTFjS3R2zZZVGaSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2015 at 01:32:37PM -0700, Ben Zhang wrote:
> The codec supports 4 channel recording with TDM on AIF1.
> This patch modifies the DAI capability to allow it.

Is there no code change needed to configure for the number of channels
being used?  I can't see any current handling of that, nor anything that
looks like non-stereo handling in the DAPM graph.

--MTFjS3R2zZZVGaSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDDHrAAoJECTWi3JdVIfQJzkH/0q0Y+qtNG9pk+TKzrGyumkj
yYM0DZlFjJpXKXnkeTOKIXeVqrzpkVY1zXj4Qh6XvdLbPpTPS6nMgLd6BKL59SpB
PtnY88AMEdBNVxEjLXzD59BqAgGSUuE2PiENMVMnxZ13BUQzTHdJ1FkOBshRL6uG
hToo7mYRu+e5YRtftx8xUfe0nAAbLgKjGyjyy2x5lNUrRP2Qjhxaxpn4kxu36UMQ
UIOigd7sr5RH47DlYRNqyGK18gqpmEdyNEZPRkUoWBmJUPzR+TFl21Ph3AO1GQY3
TKN7SkE3Y7xAdNXBfhzpX/ESEvR/gZejsFWSNGv7+ippJP4RIVOcgeqKDAlqSG4=
=4eaa
-----END PGP SIGNATURE-----

--MTFjS3R2zZZVGaSB--

--===============5025388219265735236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5025388219265735236==--
