From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 7/9] sound:asoc: Add support for SPEAr
 ASoC machine driver.
Date: Sat, 23 Jun 2012 12:01:13 +0100
Message-ID: <20120623110113.GU4037@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<6eb72cea276e7dc191713cff9e4a0ce8ed6b2faf.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8277189525950055108=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42D7B24674
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2012 13:01:15 +0200 (CEST)
In-Reply-To: <6eb72cea276e7dc191713cff9e4a0ce8ed6b2faf.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============8277189525950055108==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F1UMmCLUB5xxGl5w"
Content-Disposition: inline


--F1UMmCLUB5xxGl5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 03:54:55PM +0530, Rajeev Kumar wrote:

> +	/* set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +			SND_SOC_DAIFMT_CBS_CFM);

You can se this in the dai_link structure rather than having to set it
in hw_params() every time.

> +static struct platform_driver spear_evb_driver = {
> +       .driver = {
> +               .name = "spear-evb",
> +               .owner = THIS_MODULE,
> +               .pm = &snd_soc_pm_ops,
> +       },
> +       .probe = spear_evb_probe,
> +       .remove = __devexit_p(spear_evb_remove),
> +};

I'd expect to see an of_match_table in the device too given that you're
parsing OF compatible data.  Given how simple this is I wonder if you
can instead add DT support to the simple-card driver which Morimoto-san
recently contributed rather than adding a new driver?

> +MODULE_ALIAS("platform:spear evb");

This won't match against anything in the driver.

--F1UMmCLUB5xxGl5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5aHxAAoJEBus8iNuMP3dIDYQAIn4f5GPR5xid5QepUItnQb7
cU+5UVH8chVIyRibC11S7eJFSM3KttaJeVfxhAFhESAwTtiNrUow/13W3tSKqqMo
j0F70ev5pvHOmWjSAH2fJsAMkHbdGeIBpyShOt1uzFpy/UGtIklm4EcWkI+ZTHc5
+B6XZ8QYFrCS5W3Owa0lh7eQlfmRQmrFuWibUrwracNug50g3l7dho4nr9cwSr4q
FN3EHNtDFa/HWMO6hj793nc33APm5cJd9NXXTnjOxS2mp3CEwYUKkoqm3P67Zi4r
NXfzESqeQ7hmviYffBDHNctCcXzZ1IWo/2BFHD5u5PD6siWre6QRtlqBXb1ACSXL
brXoxE4ql2JF9eqSfA1Pi17hkKsWFGQ4P/nQfSxkN+4YJwnDUey8j/3sRJJ8boj7
0ebbCjz1TAV2o+GdcSVKQx16BbZuB1nhQVnK1E65cDKhm/6PiUNDfiqscz4YT/GE
2/NMXPoVl+LbJrUnOUVdqA8y4eLcjuwBTHJrS5Uau8EKeOV3LN9cVHXgusiVZ6b8
uGfK3iofMmc5vU9jKa/n5XFqEdoHE58vrbPgrXvMa6PP4Kb/F8K9mfwUTRyYQHwF
AR6nsfmua9j5A1kKIrOBmA2Yc2qOQsaBx3kdirbyldX881AWSDOCdySFK1Z3tmme
w/y82eXPq29neSZUbBC9
=hDHA
-----END PGP SIGNATURE-----

--F1UMmCLUB5xxGl5w--

--===============8277189525950055108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8277189525950055108==--
