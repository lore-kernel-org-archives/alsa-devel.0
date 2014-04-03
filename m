From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register
	mux
Date: Thu, 3 Apr 2014 10:40:16 +0100
Message-ID: <20140403094016.GQ14763@sirena.org.uk>
References: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
 <533D1B65.3030405@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1945713042122436749=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF8AB26556C
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 11:40:43 +0200 (CEST)
In-Reply-To: <533D1B65.3030405@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, swarren@wwwdotorg.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1945713042122436749==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FmdPcZLZZW6lDAYm"
Content-Disposition: inline


--FmdPcZLZZW6lDAYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 10:27:17AM +0200, Lars-Peter Clausen wrote:
> On 04/03/2014 05:11 AM, Arun Shamanna Lakshmi wrote:

> >+enum snd_soc_enum_type {
> >+	SND_SOC_ENUM_NONE = 0,

> I'm not sure if NONE is the right term. Maybe BINARY is better.

Yes, it's definitely not none.

--FmdPcZLZZW6lDAYm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPSx9AAoJELSic+t+oim9yRIQAJZVoxnGGYZbJf30PHwLCyfi
FPgD0T6dOwQMTvXLYS/KM+vzKLGybOehspU1op1JnNPZEMCQZ1P2mGg/A8sZyGuy
YN7GwACLNRKR6G7q+nkoniQM5epqWgUmlDOeGV4rwkyQrN21YYFyl3zCtL767y3p
3toXyTaqhidMrcS5dyXzAse7evDSYxCRxvV/BVPQ+ZKTiZ04JwT+psWI4ywnjhWL
Bz2Cfw5NIqbq+uBEXisLb+SXJtsXVhL3EJa+w9EFFZu14ZIt6AeBUMuuB7A57S/R
AbVJ5NG7O7+j8h2zCJEJPLH7NdmvzkzZPRYf8iGePm3RZMnmZrVFXMFr6yWlsD6J
WiVcIJAMzXhFUqLWDX4mkvt6hTQKi4d4FQd0N7H4VjnrkbUj9JRU9rCImI807ePd
rZ725JiaSLOZdveL5ku+EBDEulE2saHPzd3ZM01dn/b5pAmHJO13HOQ4hRwjv20H
RdnTzGFMFxGGaJxNYzEdzj2Fj2Y5/3v4JnwVCXvAQ/CpUnaduam//0M2FT6pwDn3
K54VvRb7afrWy/btvGO6aqw3aPw+4GHDEQyo+J0bXhklb6qTWi9bzOyM/9sCYAkJ
Exx7sCL+/BQDjMcYtOKOR7UXHa4PVKmTNCqpHQM9gVXFceY4RZ3M3hoW8dRZs+MJ
T951ZJSIeZZuer2IVKhZ
=x3WF
-----END PGP SIGNATURE-----

--FmdPcZLZZW6lDAYm--

--===============1945713042122436749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1945713042122436749==--
