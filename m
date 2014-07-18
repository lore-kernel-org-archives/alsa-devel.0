From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/13] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Fri, 18 Jul 2014 13:19:20 +0100
Message-ID: <20140718121920.GO17528@sirena.org.uk>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
 <1404967497-22537-12-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7784482642005245349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2858F2655F3
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 14:19:38 +0200 (CEST)
In-Reply-To: <1404967497-22537-12-git-send-email-subhransu.s.prusty@intel.com>
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


--===============7784482642005245349==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8YDLdOu/DaKXZo9W"
Content-Disposition: inline


--8YDLdOu/DaKXZo9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 10:14:55AM +0530, Subhransu S. Prusty wrote:

> +	pr_debug("%s: widget =3D %s\n", __func__, w->name);
> +	for (i =3D 0; i < w->num_kcontrols; i++) {
> +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> +			mc =3D (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
> +			val |=3D 1 << mc->shift;
> +		}
> +	}

So, this is the usage of dapm_kcontrol_get_value() (quite a way away
=66rom the patch exporting it!).  The usage here looks *very* strange.
We're calling the function but treating the result as a boolean and
manually decoding the DAPM data structures in order to get the control
shift...  that's odd to say the least.

> +	SST_FILL_DESTINATION(2, cmd.output_id,
> +			     ids->location_id, SST_DEFAULT_MODULE_ID);
> +	cmd.nb_inputs =3D	fill_swm_input(&cmd.input[0], val);

So what we're doing here is parsing the controls to get which inputs are
enabled...  it's not altogether clear to me that we shouldn't be doing
this at control update time.  Presumably we'll also need to be sending
these messages when the controls are updated to account for changes that
happen while streams are active.

--8YDLdOu/DaKXZo9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyRDFAAoJELSic+t+oim9AEkP/jxXTgyLbUB4FWmZWKhKouQM
Jvzq4e8mkVoZBshw010rrQZMtYpaLqc59TpfsK3jm+mYjsOCu8G/E/avzgkNP1M0
cwLSZ8eYMISDktFFr6yCDa+ESfgKPKw9fAeRkYfkxwGm+/VxpHzfwv9q0YHq2sUK
9Ww412XcBGi4Mt53dYBSsGc31C+OUI/sHxVjgIhddqbM02qtZMo+7XmlM9Y7MX2G
gsitpchTsDOBi03akW2XumUFpGPO+iuIvr7j+AIv2lCZovulcx1KMgZvQfy8jGgi
+w/w7w5My0vFUevByoTJAy0DeCLm6xhrkYis5ZpDdxBBnHieQpv8aGeN49cyo4Zu
yRtw5h0eMRhb+3ki7DpixfGrPceiDPBVbRHJh14HPzdFAEnEdJ07It12WtL/sclo
Xvl7HH0KwCmB1q/zAkw0lBtwESkdivwldD6gsCui/u+YmsgOMe9Wva8+TJ+gTymz
vv6a1wuwgxjZ4AXsutqjSvvGk2gsAqHpgKpe3s/VY0eAQ9iuJb23gB3L4oloqyR4
kLvAmvj83bNpHnNT3vIsSBO7ZcFxVPG4Ymj3PkhL+qeFQmt/OL0NSQ8AqLPt0aoS
mTvKSbaPX98iJhLDMOmhx/nh2u31yVaD3WhguiGbiE6hZBRH8PTy92ddMW2zEZ1j
tjmfO5Z+iY0Vz4n1CDbg
=bipZ
-----END PGP SIGNATURE-----

--8YDLdOu/DaKXZo9W--

--===============7784482642005245349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7784482642005245349==--
