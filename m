From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix build with CONFIG_SLEEP
	enabled.
Date: Tue, 4 Nov 2014 15:13:45 +0000
Message-ID: <20141104151345.GR3815@sirena.org.uk>
References: <1415107665-17460-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4289706561776349880=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AC8026056A
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 16:15:11 +0100 (CET)
In-Reply-To: <1415107665-17460-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4289706561776349880==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vk2EvGhio7iZz8DU"
Content-Disposition: inline


--vk2EvGhio7iZz8DU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 01:27:45PM +0000, Liam Girdwood wrote:
> Fix the following build error when CONFIG_SLEEP is enabled and CONFIG_RUNTIME
> is disabled. The BDW ADSP sleep PM functionality depends on the runtime pm
> calls for context save/restore.

Applied, thanks.

--vk2EvGhio7iZz8DU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWO0oAAoJECTWi3JdVIfQPfQH/j1ykORoaAkEmJHR+yw/CEYu
WOpLAI7d3LBs526xnTrI1QPDOKlg40xT4y3iCoCiq3ICAzXjfPSFOIiV+XG7ROfH
dZEsvLrmFstb8yZUvrdwOuOodM1tKsmIpOZwuwvVidvD6HRgu9pCjit2KwT92j5v
o5TMUSTeju61kFpk+stDSeVnH9behJzUBcWWInIpukC5znicL7ZTIhOi3pM12+F7
F1Ep8f9+JzIP5gyuKeH5dGOfXVkQTMwN215IzFP2RFxCrfcQs3jtNFvIrIIPfRKY
uV8a9bDaKnNDS4kl460Tx8f/6eAcXqRxl0LPQcoPsdoS3v5a49crB2vwCfsf370=
=fZzd
-----END PGP SIGNATURE-----

--vk2EvGhio7iZz8DU--

--===============4289706561776349880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4289706561776349880==--
