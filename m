From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 10/12] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
Date: Wed, 13 Aug 2014 21:14:54 +0100
Message-ID: <20140813201454.GS17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2167860585679552118=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A803B2655BA
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:15:01 +0200 (CEST)
In-Reply-To: <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2167860585679552118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WLhOVZARQ311lNMq"
Content-Disposition: inline


--WLhOVZARQ311lNMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 03:16:01PM +0530, Subhransu S. Prusty wrote:

> +	pr_debug("%s: widget = %s\n", __func__, w->name);
> +	for (i = 0; i < w->num_kcontrols; i++) {
> +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> +			mc = (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
> +			val |= 1 << mc->shift;
> +		}
> +	}

All my concerns about this still stand - using something called
_get_value() to do something other than read the control value (which
this does - it uses it as a boolean then does something else to read the
value) which doesn't seem good.

--WLhOVZARQ311lNMq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68c7AAoJELSic+t+oim9ts4P/3kF9lFAnuDppYG73bx6C/SH
5UVq9oZWplEpuB96jQ2xq0f3qPTr/hmtBuMAWw9B9cr2vhta9lcBPYUa2ducBfLT
CP3Oh0ruL6D4aJRBebicbFRMBy33APAsRBc1yjB+qeOb6FRRx7ISDTku83yay4R+
vJ6Obbv767WB71fFY5h/ejZWfzfbhuYUlJlarAEkCGW3AfHQqzZPZWJqeSM+M5kF
vJBDwPMymjRHBJtDDXdGxOKaESk2bRRoxK8BscYtW2zwNxPC0vJ2RFBIN3mGoc35
5Xevl1yujLKdLSy1rJHLZTGfOQ2UW5wYsAExbZm7peIDFdcq7OsV94FG3EYcRFx9
56nqDbGTvU1Op7ZPgTErU5y67u49KLApz1KxkUjE0Ig1u6TSaE4croXlXGaDnX0G
Q650p/eyWF7h36hzdVIO6mVkNyeKbWpEZU+7Ov/pTCg1wgEigdlgXaZPXZC76Ix2
Fbg9pHV01RCEURE2uw3GXTBgqYwOuplnP0jDzwJ9eazwvuMfAZxK/rFbmyOX3n6C
96VGFXQlHTLN9aZbdFYHGASqmiTFKugdWTE8SQJhskAWE1nK+QLHbS7u+be0y3br
OmdHg488uYhVX1nU5OWcyDY5kxmV5u2rDniiG5S7/Z5E6NAk4+EV5NrR7G+wBJVB
2H63w0F079SEoF40MP0v
=hCOh
-----END PGP SIGNATURE-----

--WLhOVZARQ311lNMq--

--===============2167860585679552118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2167860585679552118==--
