From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] sound: soc: core: no need to check
 return value of debugfs_create functions
Date: Fri, 14 Jun 2019 16:34:05 +0100
Message-ID: <20190614153405.GD5316@sirena.org.uk>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-5-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0326700869374457899=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A15DCF80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 17:34:08 +0200 (CEST)
In-Reply-To: <20190614094756.2965-5-gregkh@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0326700869374457899==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YgGp9RfepglW4nsE"
Content-Disposition: inline


--YgGp9RfepglW4nsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2019 at 11:47:56AM +0200, Greg Kroah-Hartman wrote:

> Note, the soc-pcm "state" file has now moved to a subdirectory, as it is
> only a good idea to save the dentries for debugfs directories, not
> individual files, as the individual file debugfs functions are changing
> to not return a dentry.

It'd be better to split this out into a separate change for ease of
review.

> -	d = debugfs_create_file(w->name, 0444,
> -				dapm->debugfs_dapm, w,
> -				&dapm_widget_power_fops);
> -	if (!d)
> -		dev_warn(w->dapm->dev,
> -			"ASoC: Failed to create %s debugfs file\n",
> -			w->name);
> +	debugfs_create_file(w->name, 0444, dapm->debugfs_dapm, w,
> +			    &dapm_widget_power_fops);

The majority of this is removing error prints rather than code that
actively does something different.  If this was like kmalloc() where the
API is itself reported errors then this wouldn't be an issue but unless
I'm missing something debugfs fails silently so this means that if
something goes wrong it's going to be harder for the user to figure out
where the debugfs files they wanted to check went to.  I'm guessing you
don't want to add error prints in debugfs itself so I'd rather they
stayed here.

Yes, the error check is looking for NULL not an error pointer - it was
correct when written but I see that the debugfs API changed earlier this
year to return error pointers so we ought to fix that up.

--YgGp9RfepglW4nsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0DvmkACgkQJNaLcl1U
h9C10Af/WWWQ0hXp7Kjf67OffaL0vmLFaq46sMjEYEyBCtiv7o+GusnMCNhRIlEG
4+tQgsu7wbGxclJaerAzGCzlaBAvjS9yCYbqrFZJzSETGZ0VaKjrw7MlepYUPB94
CBkKwCHoFTQpRm/b36BJd8hV5o8uhTlsf/gpbUFXJjPjH/20UWVCmi7Gonh8rTBU
L1It2817gidMIhiFg4Hc86WUGGK+JGM3ekyTvXd5zQix9tx1fmsiqmJs9Pr9s09F
HEnX9c4xmQLVtXNQOgD72KI7zCIrcAsTtcZd09rl+qOIN1DzCuEDemtqKN2/r8c6
7IQIKP/GluG2A/b9VhRgrXb41zS3Cw==
=ATS+
-----END PGP SIGNATURE-----

--YgGp9RfepglW4nsE--

--===============0326700869374457899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0326700869374457899==--
