From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Mon, 31 Mar 2014 21:23:52 +0200
Message-ID: <20140331192349.GA3431@mithrandir>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1215946825782685827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED442651F3
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 21:23:52 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id d7so1242630bkh.14
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 12:23:51 -0700 (PDT)
In-Reply-To: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1215946825782685827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 12:38:16PM -0600, Stephen Warren wrote:
[...]
> diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
[...]
> +static const struct of_device_id alc5632_of_match[] = {
> +	{ .compatible = "realtek,alc5632", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, alc5632_of_match);

Doesn't this need #ifdef protection to prevent warnings about this being
unused for !OF?

Thierry

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOcDEAAoJEN0jrNd/PrOh5mgP/jbuzWJJDELbwgyjVmjKpqsz
xjPv14kSRvNo7XH8ee14COcVu8fDmDQYOaISNLdR/QJPnfsnDLB5+X3wVRTmBC8N
jleoNTlOJm0Oa3WWCD2bp3ai5VRAPoyvCjTXLDhO4pwC4AmXG82cAYsp/krWz0xp
Ncp9AtUyZli/0qsRMaLemhSevha/WSG39preFRZj36EbwM+3fzOVcbfYULjCvyyO
9v6FuE+IJVXgN8vD9b9bOkRt3BQL5D0KFw1inK0IshhyD5ybHdvajSIoKJzNWwLZ
QBTu0LqANQwSRdSKudjg0gX9cT1kmjlBDBY8CoyasMMvwkg2T+wFxdH8ECoy7qWg
MSD1JLa1X7SNqaoYMTJ+k2jUOqz1jKz9TgDJ6SthXX9HKhOS/bu/VpwyLTs+0a4y
oKBkw3NyPjd6VYtNCwfSujy0CtpHCTKi6ZMUc/UTGYqEEfTuveOU2DhlNWL4GGkN
joIvGYXmAWa65A1Q8cV2TarqtmHl0GVQTVWfOibBXFWJq5wEW/+AtB2FgDP8zv88
IvH+d+4nfyTZI1mu3jHoQ4a1Q3UjrfYxQy7cMfXJLxYiv6F91sFPNLPm09wH30H/
6QcUCZ93LJA4AyHqm7cMAqgnTBIxQ0M5p2kvf/JQdMg4AeGm02qp9CCUF3f0ODzn
acKSbmsVv6XXTiAI/kPI
=8SGS
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============1215946825782685827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1215946825782685827==--
