From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Intel: Add Haswell and Broadwell
 PCM platform driver
Date: Fri, 21 Feb 2014 14:16:03 +0900
Message-ID: <20140221051603.GC25940@sirena.org.uk>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-3-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2624956703236202406=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 64AF926172B
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 06:16:16 +0100 (CET)
In-Reply-To: <1392932927-9725-3-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2624956703236202406==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 09:48:44PM +0000, Liam Girdwood wrote:

Applied, thanks.  Again a few comments below.

> +/* simple volume table */
> +static const u32 volume_map[] = {
> +	HSW_VOLUME_MAX >> 30,

Interesting one here.  On the one hand we always say to present the
hardware features as directly as possible to the application layer.  On
the other hand I'd not be surprised if some userspaces failed to deal
constructively with a full 31 bits of linearly mapped volume control
(but I'm not sure how common they are and really they ought to be
fixed).  Anyway, not a problem more just a comment.

> +	if (!pcm_data->stream) {
> +		pcm_data->volume[0] =
> +			hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
> +		pcm_data->volume[1] =
> +			hsw_mixer_to_ipc(ucontrol->value.integer.value[1]);
> +		mutex_unlock(&pcm_data->mutex);
> +		return 0;
> +	}

It looks like we only record the volume when the stream is idle.  What
happens if the user changes the volume while it's idle, starts playing,
changes again then stops playing?  It's possible I missed the bit where
it gets saved but I did look.

> +	if (!pcm_data->stream) {
> +		ucontrol->value.integer.value[0] =
> +			hsw_ipc_to_mixer(pcm_data->volume[0]);
> +		ucontrol->value.integer.value[1] =
> +			hsw_ipc_to_mixer(pcm_data->volume[1]);
> +		mutex_unlock(&pcm_data->mutex);
> +		return 0;
> +	}
> +
> +	sst_hsw_stream_get_volume(hsw, pcm_data->stream, 0, 0, &volume);
> +	ucontrol->value.integer.value[0] = hsw_ipc_to_mixer(volume);
> +	sst_hsw_stream_get_volume(hsw, pcm_data->stream, 0, 1, &volume);
> +	ucontrol->value.integer.value[1] = hsw_ipc_to_mixer(volume);
> +	mutex_unlock(&pcm_data->mutex);

Can the DSP adjust its own volume autonomously?

> +static int create_adsp_page_table(struct hsw_priv_data *pdata,
> +	struct snd_soc_pcm_runtime *rtd,
> +	unsigned char *dma_area, size_t size, int pcm, int stream)

No helper for this?

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBuEQAAoJELSic+t+oim9rGQP/1/qfiL+m9FJfmcEcfmJ11Hq
qncomZDK9wNA/7NZgxJz5CUyJpH8+DxY88JHf8w2fqb8XoSLLJzhZ7aTKnkG6DHr
zRnJyLoFsC+SinH7Pwuru9fzmx168yYmqkB0xVGEoLi9vfbc1n8H3EM1fs1zLcMu
WEKjne/FoBFdndlzXRmWuBxm/ew9yhlEd2CedUmets0YQoYdrnlptxTwLkbT/sSN
+NJI54hfNTe3tmu4THsg2zGoVfx0wcUF+P+sOZZOXIceJnLGYG6ar6HjOUOXidb2
+wImkm2R4sT0hucNQIfVoUuWHNc2g9dgbrpziESFt/W/3RAZ6x5ekCwJ04shjOOh
hoQURs+VQnJwsMDxfW8e4vSojPlYhmCSKV3rBxWF9XjX1qlFNeoxhY3Rt450JHNO
HsbDmoPF4ubRtLN5wHzBa1eWu+1ltJhLTGWArwd1GAisYpgf/DllTWJhdPMbNvi2
2556IxKZNecVx9KVdgOc816GKSsdKof5WS34asmXjUvo+A37Y911VM5bFjPRPYcz
7Pahh38NOz8+txdMgaQop6JK5dWGHy5J8h3sOHq29AOb3oL/3LGpXpeicZ65RgZx
WK2eSc2465QdbnuTcEM02B+adxJc8LUj0pal1z9YBOfTgs7B8v4qJu3BZHR3WoYy
IHjp8YjIloHC1RhKFnxL
=L8ZN
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

--===============2624956703236202406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2624956703236202406==--
