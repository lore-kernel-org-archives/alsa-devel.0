From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Increase
 SND_SOC_TPLG_NUM_TEXTS to 32
Date: Fri, 20 Jul 2018 15:46:25 +0100
Message-ID: <20180720144625.GJ10784@sirena.org.uk>
References: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
 <20180720123820.GG10784@sirena.org.uk>
 <cc342153-28fd-85bf-acab-a695882af115@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0042207258175806149=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A62E1267749
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 16:46:35 +0200 (CEST)
In-Reply-To: <cc342153-28fd-85bf-acab-a695882af115@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, pardha.saradhi.kesapragada@intel.com, cezary.rojewski@intel.com, Puneeth Prabhu <puneethx.prabhu@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, gustaw.lewandowski@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0042207258175806149==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7AwgMNpd3VkAVXjS"
Content-Disposition: inline


--7AwgMNpd3VkAVXjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 08:58:07AM -0500, Pierre-Louis Bossart wrote:

> Agree with Mark on both points (de-duplication needed and backwards
> compatibility). If we are going to respin a new version, there are a couple
> of known limitations we may want to fix as well, such as the limitation to 8
> channels and others I will remember once I've had more coffee.

Actually it looks like the duplication isn't a thing, I can't see the
definition the patch was intended to modify in upstream.

--7AwgMNpd3VkAVXjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR9cAACgkQJNaLcl1U
h9CMmAf/UVyi8FE2DXic8reNOYefSHMP1c6zQZk70Fi39Ansxk+WX7LyuTC+xss0
utnMf0tBlo11AUMbFBgq5obLgwhwWkH7m3eyHTFfFAIiG90j7+BpgyXsoK6o1zLW
LovBckT7B8Rycq0n6Xogy2araF6pWhTl7fXsygIoqMGlm6T8HUcXihQnIxAdoKLu
ipxGNtbBaaqNc0yJYHDI6bfS0BaO6xN87/3gjDgENLtTwM+ojjkeaT6HRtcIFwRX
I3jugq+acy8CeFyDgG6dvWEhT8PP0ZIQ/+pOIxCD/02X5tjCfjs5owV47SXAzhZ9
gMkh+Q0Q5Ye0jtULTVIZxy7TSxEmuw==
=wKo1
-----END PGP SIGNATURE-----

--7AwgMNpd3VkAVXjS--

--===============0042207258175806149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0042207258175806149==--
