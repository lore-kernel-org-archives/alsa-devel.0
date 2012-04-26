From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: dpcm: Add debugFS support for
	DPCM
Date: Thu, 26 Apr 2012 17:44:54 +0100
Message-ID: <20120426164454.GM3207@opensource.wolfsonmicro.com>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
	<1335352373-5237-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3419613013456720311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D559110BB94
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:44:56 +0200 (CEST)
In-Reply-To: <1335352373-5237-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3419613013456720311==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Content-Disposition: inline


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2012 at 12:12:50PM +0100, Liam Girdwood wrote:

I've queued this to apply this but a few nits I noticed:

> +#ifdef CONFIG_DEBUG_FS
> +	dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
> +			fe->debugfs_dpcm_root, &dpcm->state);
> +#endif

I have to say that this being writable seems rather scary...  any great
need for that?

> +static int dpcm_state_open_file(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +	return 0;
> +}

This is simple_open() - could just remove this and use simple_open() in
the ops.

> +	if (fe->cpu_dai->driver->capture.channels_min)
> +		offset += dpcm_show_state(fe, SNDRV_PCM_STREAM_CAPTURE,
> +					buf + offset, out_count - offset);
> +
> +        ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
> +
> +        kfree(buf);
> +
> +        return ret;

Suspect there's some spaces being used for indentation here...

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmXt+AAoJEBus8iNuMP3dPP8QAIe/Z1N+UqhtOT7Qea9CpjOp
vP2WnBKYB7b95kaM+amVZYbJG1wfMXlPa46GvUR+xerW+x9YayC+WSjPGVx2TDPj
9AQf/J8NkywcpEyJMBYxnwI4gKBneGTBJA/UphgbdbB0t5wKm2TpGj9JxgQe1AEE
XVMrpNaVx6B9+h2VmLBFBaP5nqFicT68BtzCGzYwpxRHYaEiXgScRMHw73sw9LG1
7FInROP44G4l/zcUBGWDDTTi1a54Cvlk81GAAUJNiFiaoOczxX+JZTCGlHmmdMt9
rfBMdbvxGjJJKk1UIDBgPxvFTFlm2qmbTVkGpylB1XAA59jbbBOMQmah8Zb8vO4j
8GjkipsiebgOIQcoIuY5LFyoDE1LN4uB7jgvHBLnInatYAb9x3syZuBrZvQY2xjc
4v2A7qpq5pZyz/qj4R6TuxAjuOBn/X5+Bi2je56VEq4T+1hhBLm8H1gAel02VSgV
xeZ+4TGjU74UCE12LDyC+BiL0USHMWuOfht9s1fMc5SNKkRGW6L3Sgz5jdxheXJP
qj1pagUf/56okS3lraf6GPN4Ihld+oKv7VNra7kkK5cz0EhKNVWACxNl2RTl8dbd
pSPbbABEhmKJPsXjrEEi2xnT4UrkrJbKTWo0omjROhlI1jLgj9uFB1qkp8vxx+c3
KnKXaxWxWwAsCsTnhCjV
=A5Zg
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--

--===============3419613013456720311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3419613013456720311==--
