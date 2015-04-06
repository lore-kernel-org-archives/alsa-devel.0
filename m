From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 3/3] ALSA: hda - add soc hda bus wrapper
Date: Mon, 6 Apr 2015 18:08:04 +0100
Message-ID: <20150406170804.GQ6023@sirena.org.uk>
References: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
 <1427968651-7821-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3921069198167726864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7096926043C
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 19:08:12 +0200 (CEST)
In-Reply-To: <1427968651-7821-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, pathes.audio@intel.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3921069198167726864==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8so8ZvRz607RvwFp"
Content-Disposition: inline


--8so8ZvRz607RvwFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2015 at 03:27:31PM +0530, Vinod Koul wrote:

> index 000000000000..09ef831b8513
> --- /dev/null
> +++ b/sound/soc/hda/Kconfig
> @@ -0,0 +1,4 @@
> +config SND_SOC_HDA_BUS
> +	tristate "SoC HDA bus wrapper"
> +	help
> +	 This adds support the SOC HDA Bus wrapper

ASoC (in both places please).

> +void snd_soc_hdac_device_put(struct snd_soc_hdac_device *pdev)
> +{
> +	if (pdev)
> +		put_device(&pdev->hdac.dev);
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_hdac_device_put);
> +
> +/**
> + * snd_soc_hdac_device_add_data - add platform-specific data to a hda device
> + * @pdev: hda device allocated by platform_device_alloc to add resources to
> + * @data: hda specific data for this hda device
> + * @size: size of platform specific data
> + *
> + */
> +int snd_soc_hdac_device_add_data(struct snd_soc_hdac_device *pdev,
> +	const void *data, size_t size)
> +{
> +	void *d = NULL;
> +
> +	if (data) {
> +		d = kmemdup(data, size, GFP_KERNEL);
> +		if (!d)
> +			return -ENOMEM;
> +	}
> +
> +	kfree(pdev->hdac.dev.platform_data);
> +	pdev->hdac.dev.platform_data = d;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_hdac_device_add_data);

I didn't notice the put function cleaning this up?

> +/**
> + * hda_device_unregister - unregister a hda device
> + * @pdev: hda device we're unregistering
> + *
> + * Unregistration is done in 2 steps. First we release all resources
> + * and remove it from the subsystem, then we drop reference count by
> + * calling hda_device_put().
> + */
> +void snd_soc_hdac_device_unregister(struct snd_soc_hdac_device *pdev)
> +{
> +	snd_hdac_device_exit(&pdev->hdac);
> +	snd_hdac_device_unregister(&pdev->hdac);
> +	snd_soc_hdac_device_put(pdev);
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_hdac_device_unregister);

Takashi queried bits of this too...  I have to say I don't entirely
understand how this device management is supposed to work and the lack
of any users in the current series isn't giving me anything to refer to
here, perhaps it's all obvious given them but I don't have them just
now.  A lot of this looks like it's boilerplate which should be
duplicating something device modelish and there certainly seem to be
some things with object lifetimes that need paying attention to.

All the commit message says is "create asoc wrppers on top of hdac", can
we have more words please?

--8so8ZvRz607RvwFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIr1zAAoJECTWi3JdVIfQFaUH/jdXq6lz9bGwT40SwYMINSlC
gfl8KKyOp9SIPN5ca0XJe8TNO9Y1QU9JZnxQW09BGQP3aKCU03SDRXqME6IQxTsl
AZglfhfRoZTyD7R3qglWU3oJz496z6kLIxOLZvsxh8GgtWppO2RQvY/Ox8Cv3eXV
tKoI6KxITC31DLWX6rfgTJi6a6S7JfQyKZ0WvrQf1LOfPtqDtIgMF4xaCoMp0X/7
HO1cG5sIdlkcOES3NXx3nKCsItogJg9HuffVDGS3nxrt3UGajU74swqlta3qXbWS
mM0f8LRL9CbXWOUMKrGrGcI7r8AdsbwfltBFr3liTikS4Z+xFufhfs/C2ID8OuY=
=YieG
-----END PGP SIGNATURE-----

--8so8ZvRz607RvwFp--

--===============3921069198167726864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3921069198167726864==--
