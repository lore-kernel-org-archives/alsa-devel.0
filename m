From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-compress: Send correct stream
 event for capture start
Date: Fri, 17 May 2013 21:20:08 +0100
Message-ID: <20130517202008.GP1627@sirena.org.uk>
References: <1368806306-5520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6944121286614395027=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AC999261683
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 22:20:16 +0200 (CEST)
In-Reply-To: <1368806306-5520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6944121286614395027==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9b3biUB1f7FHqGn"
Content-Disposition: inline


--f9b3biUB1f7FHqGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2013 at 04:58:26PM +0100, Charles Keepax wrote:

> Sorry little bug I missed due to some integration bugs in our
> setup here. Again this applies onto Takashi's sound for-next
> branch.

Now the merge window is done this matters less.

> +	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
> +		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
> +					SND_SOC_DAPM_STREAM_START);
> +	} else {
> +		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
> +					SND_SOC_DAPM_STREAM_START);
> +	}

Coding style: no braces for single line if clauses unless there's a good
reason.

--f9b3biUB1f7FHqGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRlpDxAAoJELSic+t+oim9ysMP+wdXxnd9SNsWcd8PSjYzaR4U
lNPwwnXbXvzHz2Pt/AK0163HILm2y8DVS1ls1jjDbpvahXKT30+Xz/+2VOq3kRP8
3Zaq8ol1TEpit8c3bZLyoL0XUNBX+2o5Ez7YJ0MKUKfov3UGmwfbSDhpjXJryuVA
HYO3TNSS62wjFK1LtwC+Od9VWgeeCCzGef5eLtR1KTJJwQbDUToDEaj79WzKStnO
mFjw/wHKH8Mt+C/FCzvnHq5KSXdSiBGFLoL0prbc2p2k58rrhe+uLpq0givTKcGm
Ki5FtoilmP3eNMNlH3LH6SwY70/asDSzrpRUlKR2cyy3ibxURswlXNIndw2SVhL7
uYE0YueuHKxbiQvkwsAB37kQgsO0oyLBeyQQoL1nGVOEtvEWCMg+LwOxj6zM8HSH
fdP+H2na7/Y6Xkk//GYkRsKmrv7Z/RanDHGc8LivPK21BJ6/+lXlwJF83wIel/7+
qoGUSdux2s7ymLAwSkNg0ZI54+WZOKXGOHgoVKThxMtje6Ufu5FUdcqgwFG91Xmh
oryWcRM0Ee4hvwPZgBPkAQUm25IwUJ1XyYN4q+4b7J/xf3fVS4pRaC6YU5YPlB0c
THQRRVXes4K8oqJGEXoXZE1x2FpTSJA/ubrg5XvwlUI6Mh1TyR5FXE24tBiDkDE7
VbJV5ck/Yo/PR7m2/0IL
=7KDZ
-----END PGP SIGNATURE-----

--f9b3biUB1f7FHqGn--

--===============6944121286614395027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6944121286614395027==--
