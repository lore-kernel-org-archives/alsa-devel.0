From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: Intel: Skylake: Add FE and BE
 hw_params handling
Date: Fri, 14 Aug 2015 22:53:10 +0100
Message-ID: <20150814215310.GV10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0876678330010338104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6C912664CB
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:35 +0200 (CEST)
In-Reply-To: <1438976184-6160-5-git-send-email-subhransu.s.prusty@intel.com>
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


--===============0876678330010338104==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpBPog2+b3WGyJY6"
Content-Disposition: inline


--lpBPog2+b3WGyJY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 08, 2015 at 01:06:19AM +0530, Subhransu S. Prusty wrote:

> +	/*
> +	 * 16 bit is 16 bit container whereas 24 bit is in 32 bit container so
> +	 * update bit depth accordingly
> +	 */
> +	if (format->valid_bit_depth == SKL_DEPTH_16BIT)
> +		format->bit_depth = format->valid_bit_depth;
> +	else if (format->valid_bit_depth == SKL_DEPTH_24BIT)
> +		format->bit_depth = SKL_DEPTH_32BIT;
> +

What if the depth is neither 16 bit nor 24 bit?  Shouldn't this just be
a simple override for the 24 bit case?

> +/*
> + * Fill the BE gateway parameters
> + * The BE gateway expects a blob of parameters which are kept in the ACPI
> + * NHLT blob, so query the blob for interface type (i2s/pdm) and instance.
> + * The port cna have multiple settings so pick based on the PCM
> + * parameters
> + */
> +static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
> +		struct skl_module_cfg *mconfig, struct skl_pipe_params *params)
> +{
> +	struct skl_pipe *pipe = mconfig->pipe;
> +	struct nhlt_specific_cfg *cfg;
> +	struct skl *skl = get_skl_ctx(dai->dev);
> +	int link_type = skl_tplg_be_link_type(mconfig->dev_type);
> +
> +	memcpy(pipe->p_params, params, sizeof(*params));
> +
> +	/* update the blob based on virtual bus_id*/
> +	cfg = (struct nhlt_specific_cfg *) skl_get_ep_blob(skl,
> +			mconfig->vbus_id, link_type, params->s_fmt,
> +			params->ch, params->s_freq, params->stream);

I don't seem to have slk_get_ep_blob() but hopefully it's returning a
void * in which case why do we need to cast it?  In any case it needs to
be defined in mainline before this can be applied :(

> +	if (cfg) {
> +		mconfig->formats_config.caps_size = cfg->size;
> +		memcpy(mconfig->formats_config.caps, &cfg->caps, cfg->size);
> +	} else {
> +		dev_dbg(dai->dev, "Blob is NULL");
> +		return -EINVAL;
> +	}

This seems like a more serious problem than something we just dev_dbg()
about?

> +static int skl_tplg_be_set_params(struct snd_soc_dai *dai,
> +					struct snd_soc_dapm_widget *w,
> +					struct skl_pipe_params *params)
> +{
> +	if (!w->power) {
> +		dev_dbg(dai->dev, "set params for widget=%s\n", w->name);
> +		return skl_tplg_be_fill_pipe_params(dai, w->priv, params);
> +	}
> +
> +	return -EINVAL;

Shouldn't that be -EBUSY?  The normal idiom would be to check to see if
we were busy and error out rather than writing it as only configuing if
not busy (which looks like an error case now).

> +	list_for_each_entry(p, &w->sources, list_sink) {
> +		if (p->connect && is_skl_dsp_widget_type(p->source) &&
> +						 p->source->priv) {
> +			ret = skl_tplg_be_set_params(dai, p->source, params);
> +
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret = skl_tplg_be_set_src_pipe_params(dai, p->source,
> +									 params);
> +		}

These two cases appear to be identical apart from ignoring the error in
the else case...

> +	}
> +
> +	return ret;

...unless it happens to be the last entry in the list in which case we
pay attention.

> +static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
> +	struct snd_soc_dapm_widget *w, struct skl_pipe_params *params)
> +{
> +	struct snd_soc_dapm_path *p = NULL;
> +	int ret = 0;
> +
> +	dev_dbg(dai->dev, "widget name=%s\n", w->name);
> +
> +	list_for_each_entry(p, &w->sinks, list_source) {
> +		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
> +						p->sink->priv) {
> +			ret = skl_tplg_be_set_params(dai, p->sink, params);
> +
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret = skl_tplg_be_set_sink_pipe_params(dai, p->sink,
> +									 params);
> +		}
> +	}

There's some more common code here and the same patterns as above...  :/

> +	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		w = dai->playback_widget;
> +
> +		dev_dbg(dai->dev, "Stream name=%s\n", w->name);
> +		return skl_tplg_be_set_src_pipe_params(dai, w, params);
> +	}
> +
> +	if (params->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		w = dai->capture_widget;
> +
> +		dev_dbg(dai->dev, "Stream name=%s\n", w->name);
> +		return skl_tplg_be_set_sink_pipe_params(dai, w, params);
> +	}

Normally that'd be written as an if/else, and the only difference
between the two cases here is which widget we pick...

--lpBPog2+b3WGyJY6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzmNFAAoJECTWi3JdVIfQ5uwH/2MwJL5bnxoVh+uZDX8IN45I
aPo76VxCDm5xaGQxIUUcCQcTmMAXWZJoI/0gQQyDDRo+kS/Kl1lA7uWB7WR2hHlz
eDT/rjdepKIrO8vU53xAJvITF+YrlV09K0cNSVayQKhhJfGzULRQw7oYB8hTzqp/
Q+In2YnYMaaMYDTTEvmsW2jV1iSy2z5mv63RSO9DuigWVX8xNjRvyLGFqVnhh/+0
RugPn4F7e0ZUdg7PRQLSoxmr3xZB6VMSnnYIuD955tK2t6d2WMqZFzszqyHRhgwa
fFV68nIrg9usygA4TbXu/OyRKOGZIMIbaS/azG5mNlNMZKQ05ABE7h6S9JfzbwE=
=CQeF
-----END PGP SIGNATURE-----

--lpBPog2+b3WGyJY6--

--===============0876678330010338104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0876678330010338104==--
