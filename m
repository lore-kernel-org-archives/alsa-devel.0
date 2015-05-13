From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC suspend resume question
Date: Wed, 13 May 2015 12:48:26 +0100
Message-ID: <20150513114826.GN3066@sirena.org.uk>
References: <CAOV7ByJ+R1df0HgCB-w5zW9re5rE8abNFw5_of8ZRobcdiMP5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0545855950047037483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 412B9266042
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 14:18:26 +0200 (CEST)
In-Reply-To: <CAOV7ByJ+R1df0HgCB-w5zW9re5rE8abNFw5_of8ZRobcdiMP5Q@mail.gmail.com>
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
Cc: Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0545855950047037483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O6uyWUGY5J97yCxj"
Content-Disposition: inline


--O6uyWUGY5J97yCxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 07:08:13PM -0700, Ben Zhang wrote:

> I have a question about the design of ASoC suspend/resume path. Who
> should call snd_soc_suspend() and snd_soc_resume()?

> They are part of the soc-audio driver's dev_pm_ops, but some ASoC
> platform drivers also calls them. For example,

> hsw_pcm_prepare() in sound/soc/intel/haswell/sst-haswell-pcm.c
> sst_soc_prepare() in sound/soc/intel/atom/sst-mfld-platform-pcm.c

The machine driver needs to ensure that they are called.  If it has
nothing specific it needs to do it can just provide them as ops
directly, or it can call them from within its own suspend and resume
calls.  No new systems should be using the soc-audio device.

--O6uyWUGY5J97yCxj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzoJAAoJECTWi3JdVIfQLnAH/39tfiaIcYaPSlEr7UVxPJpt
mtUYK5MlkSVdW1b0J/4RZq6gCnpIcRc/fxw7zf3fFsIbvFM3AW+pXF0cihGPkzGr
FZPMlj7QwBSPo9FBLQQFB7c399gpS+XOwrMZAO197bTY8SpqG1UwLzeu4AonqgfK
574J8ykYVAMGfw80EsvzE1wK0la6yk0WOitIQx9/Elkk1TPf9I7W3Xnhhn5KxSQ3
J6CRjrX64lY16ggnTWdgLq3YXFVdIPVafhUCuE/2tA2wnWfFJ7f0DQU7CnZZo/7w
5YZ0pQJVHE2WDr64G7AVIm20YVvC0o7D+hBGq7B9qRHrOVoHDNtfHX5xUW8oMoA=
=ih3q
-----END PGP SIGNATURE-----

--O6uyWUGY5J97yCxj--

--===============0545855950047037483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0545855950047037483==--
