From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC updates for v4.2
Date: Tue, 23 Jun 2015 11:14:51 +0100
Message-ID: <20150623101451.GY14071@sirena.org.uk>
References: <20150622092616.GN14071@sirena.org.uk>
 <s5hmvzs6p4v.wl-tiwai@suse.de>
 <20150622103034.GQ14071@sirena.org.uk>
 <s5hfv5k6l65.wl-tiwai@suse.de>
 <20150622135729.GR14071@sirena.org.uk>
 <s5h1th37s13.wl-tiwai@suse.de>
 <1435045502.14283.5.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3759124833265514303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E784D2654D7
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 12:15:01 +0200 (CEST)
In-Reply-To: <1435045502.14283.5.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3759124833265514303==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kx4ftX6R+7MpDimS"
Content-Disposition: inline


--kx4ftX6R+7MpDimS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2015 at 03:45:02PM +0800, Koro Chen wrote:

> So I think maybe it should be modified like this?

>  static int mtk_afe_pcm_dev_remove(struct platform_device *pdev)
>  {
>         pm_runtime_disable(&pdev->dev);
> +       if (!pm_runtime_status_suspended(&pdev->dev))
> +               mtk_afe_runtime_suspend(&pdev->dev);
>         snd_soc_unregister_component(&pdev->dev);
>         snd_soc_unregister_platform(&pdev->dev);
>         return 0;

Yes.

> It can fix both build warning and unbalanced calls of suspend/resume.
> Should I send a patch for this?

Yes, please.

--kx4ftX6R+7MpDimS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViTGbAAoJECTWi3JdVIfQ7TgH/0CLS7Oila3oh9Dx0ixEOCe+
/sfrNdIk/XUuCtX4jtg3SjAMsAU7/c/zSP8S9WOntLHMMflwWQFWG9VXEEvVeZR2
E9e1KWc9H3vzjIO9zmkiGm7bHuuOQxvjwbWAGe3m/XVBX0rnZFvHoaq/JvEjUp0g
fiAfPSczNstEd/m2lC932m3xtcDspbvyIV1NeYcd+W5t59FLOzNPZwm+90Mqiciq
9zLLb/hGus7eomqhbBYvSNv9tdAJplLJOEHKxqkRI2bqSgKi5Rv22gukNOOQxjVz
6W/04jZxOMqsFDA+PAqeQjcflcjwf6N9Ah2H4h0KM8q3aZKB3s1RFcIJbphOVxc=
=Kdip
-----END PGP SIGNATURE-----

--kx4ftX6R+7MpDimS--

--===============3759124833265514303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3759124833265514303==--
