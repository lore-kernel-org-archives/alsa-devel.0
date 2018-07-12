From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
Date: Thu, 12 Jul 2018 17:17:28 +0100
Message-ID: <20180712161728.GH10369@sirena.org.uk>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
 <s5hsh4o8nq1.wl-tiwai@suse.de>
 <0f437d5d-5857-a608-8d8f-345c832a0ee1@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2139243672711043273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA911267715
 for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2018 18:17:32 +0200 (CEST)
In-Reply-To: <0f437d5d-5857-a608-8d8f-345c832a0ee1@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2139243672711043273==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 10:54:05AM -0500, Pierre-Louis Bossart wrote:
> On 7/12/18 10:42 AM, Takashi Iwai wrote:

> > It's basically similar as the hotplug like USB, so I thought it would
> > work as is.

> Such transitions would probably not break userspace but they result from an
> explicit user action. The DSP going off and back is less clear, you might
> want the system to wait before triggering re-routing to different outputs,
> etc.

> Again I wasn't trying to push back but rather ask what the side effects of
> this patch might be for userspace.

For userspace it's just another reason why a card might hotplug, it
doesn't make much difference - this doesn't add hotplugging of the DSP,
it just supports components getting removed like we used to.  If someone
decides to start randomly rebooting their DSP that's probably going to
be disruptive no matter what.

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHfxcACgkQJNaLcl1U
h9Bw+AgAhT8K4srl7HkIx2mBtvLuCjm0LISYc8fMwQvNLJJpvgSw1a3/+XsVKrP/
jiCaOTnFAN7Nll4pgFqpGjj68DnkNsbteheJgSjdzDqT9ySbE64bAkcAN7VyQZjo
3v05gsMQySzB5MSqZMxZ3SzDC+LFjgOuM09QwkBY+DRDJZyeoMLofLRU/LKKeglW
rHS+/qusiDrQuq09yhNXpXXtMJDiEH5h0n4XaMIgJ/EMRudOOTJPDt4eT6TkyEF7
x1AHxcLs3gAt9fmkuxMQZaONAhI+i9I4g3aQrUJxYQtcpw49+r9xg0tPIQRNQJoU
kJdeN57fxLeAkxv7vn/o0xNRBMfRaw==
=JfnE
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--

--===============2139243672711043273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2139243672711043273==--
