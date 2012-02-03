From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/19] ASoC: fsi: re-define fsi_is_play()
 and fsi_stream_is_play()
Date: Fri, 3 Feb 2012 11:46:17 +0000
Message-ID: <20120203114617.GF3151@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87obtgi9g9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0935655425906291599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 226C8103880
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 12:46:20 +0100 (CET)
In-Reply-To: <87obtgi9g9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============0935655425906291599==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 12:54:02AM -0800, Kuninori Morimoto wrote:

> +static int fsi_is_play(struct snd_pcm_substream *substream)
> +{
> +	return substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +}
> +

Oh, good you fixed that up later.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK8kCAAoJEBus8iNuMP3deKwP/1PQR+ncxQDISF3K8MSbcPbI
Sa+RWw5sGsgY1tb/pElZ04uInM6Pn9wYHY6kij0xjTyJDQrVni2mmGRHYik5VQP5
pq8mW3uKLZN4beze8M483bJ/vMefBiAJr11wZ9Q6U9a7sgRCiko/T+1iki2JSUYs
TG5KxsTAv75Dnt3Y8zefWPCgkTLHGpC9pZTrp1AbSwPCNH6akhFs5lJObBo7ZFJ2
y5vW3spG6E8/TsxasFVeXdxi5w57IObg6v08bpnQ+auT8AUh1sGlXL3Gdb/W/1Ju
YfCpiSz+t/m2ifVq3ZrCfpM9N/P2KnnMK7EXdNgfj9GTpLMCHkQbU2lnHbZavt0U
x25hDobhxzdOJ7xjg6qltrCsuGqO/6b7oNsKmFyhWP0tlkrKb7uxDTmH6nuBwbik
mMdrKuRLLcq8QSAoZbmhqExAaoRWvoIhUNolWWBIUUSVaEL0okN4dl0ZB/UuSVB9
iMUCWkmqtudWYkDCknSHKIGzPKn6rTSNftgGGOmhg9qZ9qklNjd0lzvrj3ahAc1u
xE0+TlDc8JjK5St5vASm/2AbAd5uIbhWtnBZZfT6y1TBqzLFy/o45vedRWiNDzHZ
t72BFla+AHLwIr0iMwPBo9A14PToCRx/vYBuNAkeoCL5olgewxfTmQbZ7szj8Pz4
czu12qU0nPaSyeSLp9yn
=zJ24
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--

--===============0935655425906291599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0935655425906291599==--
