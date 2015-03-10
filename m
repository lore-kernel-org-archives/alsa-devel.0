From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: Intel: add kcontrol to
 enable/disable sound effect module waves
Date: Tue, 10 Mar 2015 20:37:30 +0000
Message-ID: <20150310203730.GN28806@sirena.org.uk>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
 <1425955287-29661-4-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4677588338248122051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F312605A2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 21:37:36 +0100 (CET)
In-Reply-To: <1425955287-29661-4-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4677588338248122051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8EQYc9s3Q1iGemBq"
Content-Disposition: inline


--8EQYc9s3Q1iGemBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2015 at 10:41:23AM +0800, han.lu@intel.com wrote:

> +static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
> +	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
> +	struct sst_hsw *hsw = pdata->hsw;
> +	int ret = 0;
> +	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
> +	bool switch_on = (bool)ucontrol->value.integer.value[0];
> +
> +	if (sst_hsw_is_module_loaded(hsw, id)) {
> +		if (switch_on == sst_hsw_is_module_active(hsw, id))
> +			return 0;
> +
> +		/* ipc is valid only when module is loaded */
> +		if (switch_on)
> +			ret = sst_hsw_module_enable(hsw, id, 0);
> +		else
> +			ret = sst_hsw_module_disable(hsw, id, 0);
> +	}

I'm not clear how this setting is saved when the module is not in RAM on
the DSP.  If the module enable/disable calls do that that's fine but I'd
expect the function to return an error if the module isn't loaded (or
better yet for the control not to be made visible to userspace at all) -
we shouldn't be silently ignoring what the user is setting.

--8EQYc9s3Q1iGemBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1YJAAoJECTWi3JdVIfQmDoH/08LeZel/b8UUG0lyf7jZivg
NQnAslVss2Jq7+EnCjbVANQM7AWeOzG8te/Dh/YNv/0GpRv3W0zhnM/stxKlGuQz
+eh4rumgcRDnk1MvKSsHCBPCBTVd+tgwDfSK++CGKPdwyEhreM+29vQ+B0s+DNkJ
Iepx/A29skTcQaM7RFQs0gE3WuJIQKfBEXf/4FvE9NxSkLjIemETK51hr9z5c5/X
X7/LowMAI8XnJFFN0W5pN6OefsmPt5ZzyHFBBtJk1vel3UJqLyBHWDS7HynCOyFa
6ZvGsm7QYlhbIE97okra0FFlvcz04pqTjadN0qIBduLdP1duBkjsaWtRnzeAl4s=
=/FKy
-----END PGP SIGNATURE-----

--8EQYc9s3Q1iGemBq--

--===============4677588338248122051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4677588338248122051==--
