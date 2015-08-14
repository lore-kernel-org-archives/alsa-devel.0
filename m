From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Fri, 14 Aug 2015 23:03:13 +0100
Message-ID: <20150814220313.GW10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5779219254373563621=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C60A82665C8
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:28 +0200 (CEST)
In-Reply-To: <1438976184-6160-6-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5779219254373563621==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CwrkNGGfsJuCXYE3"
Content-Disposition: inline


--CwrkNGGfsJuCXYE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 08, 2015 at 01:06:20AM +0530, Subhransu S. Prusty wrote:

> +	struct skl_pipeline  *ppl;

> +	pipe  = devm_kzalloc(dev, sizeof(*pipe), GFP_KERNEL);

There's lots of random spaces in this code so far and some further down
too.

> +	struct skl_dfw_module *dfw_config = (struct skl_dfw_module *) tplg_w->priv.data;
> +
> +	skl_tplg_dump_widget_info(bus->dev, dfw_config, tplg_w);

Consider implementing debugfs for this...

> +/* This will be read from topology manifest, currently defined here */
> +#define SKL_MAX_MCPS 30000000
> +#define SKL_FW_MAX_MEM 1000000

Oh dear, this sounds like we need another ABI update to add these
manifests?

> +	dev_dbg(bus->dev, "In%s req firmware topology bin\n",  __func__);

Those "In%s" are going to come out as the function name prefixed with
In.  What's that for?  It's just going to make the logs harder to read
as far as I can tell :(

> +	const struct firmware *fw;

> +	ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
> +	if (fw == NULL) {
> +		dev_err(bus->dev, "config firmware request failed with %d\n", ret);
> +		return ret;
> +	}

We're ignoring the return value (which is what we should be paying
attention to here) and checking to see if fw is NULL but fw wasn't
initialized :(

> +	/* Index is for each config load */
> +	ret = snd_soc_tplg_component_load(&platform->component, &skl_tplg_ops, fw, 0);

Which index?

--CwrkNGGfsJuCXYE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzmWgAAoJECTWi3JdVIfQ1K4H/3H7o4q3Dygei3Ab++lBDFli
mktU22VgVIQtDXKBHTe/Tkc9P2CeYY8Db2xP5ZdFGbmWDe/6DTzJJN43JDJ3jscD
PLmetvg7pzymRKTt3s2msn4ocNikFZy1te4EvI29HnQCNNe7zYCICGWjvzf3YPVo
3/zPJbp1pEaWJR7v002vlBXXRb1GEJMlhOqpo/PRp8GSuC6tcdrZuX/MLqLPI9M9
DPGur9SnqmK+29Iu3QP/ZrQasZmigIQaovbMhV9j7ibJS9eg6vX4zIQM1MDi3FEr
Sg1S/yLJ3tFTSfJj75VhU7vH0Q1DPJfKO0jGhr+ZWKuP1BP8cRn5QgVo9/iRtBA=
=qf3m
-----END PGP SIGNATURE-----

--CwrkNGGfsJuCXYE3--

--===============5779219254373563621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5779219254373563621==--
