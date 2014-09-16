From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Tue, 16 Sep 2014 12:30:53 -0700
Message-ID: <20140916193053.GD7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8787942737688329710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E187D261AFF
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 21:31:01 +0200 (CEST)
In-Reply-To: <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8787942737688329710==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMMtlwleeRJSevFd"
Content-Disposition: inline


--NMMtlwleeRJSevFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 03:11:28PM +0530, Subhransu S. Prusty wrote:

> +	mutex_lock(&drv->lock);
> +	map = is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
> +
> +	val = 1 << ctl_no;
> +	mux = ucontrol->value.enumerated.item[0];
> +	if (mux > e->max - 1) {
> +		mutex_unlock(&drv->lock);
> +		return -EINVAL;
> +	}

This is still in parameter validation so we don't need to have the lock
yet at all.

> +	/*first clear all registers of this bit*/
> +	for (i = 0; i < e->max; i++)
> +		map[i] &= ~val;
> +
> +	if (mux == 0) /*kctl set to 'none'*/
> +		return 0;

This is returning with the lock still held AFAICT.  I'm a bit surprised
that we don't need to interact with the hardware if we've disabled
everything, shouldn't this have some effect on the hardware?

Also the coding style thing with the comments again.

> +static void sst_find_and_send_pipe_algo(struct sst_data *drv,
> +					const char *pipe, struct sst_ids *ids)
> +{
> +	struct sst_algo_control *bc;
> +	struct sst_module *algo = NULL;
> +
> +	dev_dbg(&drv->pdev->dev, "Enter: widget=%s\n", pipe);
> +
> +	list_for_each_entry(algo, &ids->algo_list, node) {
> +		bc = (void *)algo->kctl->private_value;
> +
> +		dev_dbg(&drv->pdev->dev, "Found algo control name=%s pipe=%s\n",
> +				algo->kctl->id.name, pipe);
> +		sst_send_algo_cmd(drv, bc);
> +	}
> +}

I'm not seeing any handling if we failed to find anything here.

> +	[SST_IP_MEDIA2]		= SST_SWM_IN_MEDIA2,
> +	[SST_IP_MEDIA3]		= SST_SWM_IN_MEDIA3,
> +};
> +static void sst_set_pipe_gain(struct sst_ids *ids,

Coding style - no blank line.  This is quite common in this patch and
something that's been an issue in previous versions of this series too.

> +	if (enable)
> +		sst->ops->power(sst->dev, true);
> +
> +	mutex_lock(&drv->lock);
> +	if (enable)
> +		timer_usage++;
> +	else
> +		timer_usage--;

This seems a bit strange.  We're doing the enable outside the lock, then
taking the lock, then doing some refcounting outside the lock.

> +	mutex_unlock(&drv->lock);
> +
> +	if (!enable)
> +		sst->ops->power(sst->dev, false);

Same thing here.  How does the power management work here, it doesn't
seem joined up?  I'd really like to see some comments explaining what's
going on with this stuff.

> +static bool is_sst_dapm_widget(struct snd_soc_dapm_widget *w)
> +{
> +	if ((w->id == snd_soc_dapm_pga) ||
> +	    (w->id == snd_soc_dapm_aif_in) ||
> +	    (w->id == snd_soc_dapm_aif_out) ||
> +	    (w->id == snd_soc_dapm_input) ||
> +	    (w->id == snd_soc_dapm_output) ||
> +	    (w->id == snd_soc_dapm_mixer))
> +		return true;
> +	else
> +		return false;
> +}

Use a switch statement please.

--NMMtlwleeRJSevFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGI/sAAoJECTWi3JdVIfQbCoH/28Hc7mn1dd5zXSZcP82Fp5z
LzuhwRbvMjFbJmOn0ca/bCbqqhVOvRdZgF5XgIVM0aS/czqK2lgg8OrkbG0qTR/i
a7zn5QSDKTe21nxeeVmcu36AENwus+HLXYZqBewu7PfPLMAWZRxqQbLOTcEkyfTP
iDFMQyIA06NFYYaxEDeYdZtNPIR8nxzs5AVWuemSunIUXMWdPFVcvFrlrFhh+PVh
QJm+V1W5AEuTQkhrX7V2uUwAGOKFS9ZOvomguBAjCGCAOEj8wkAYrVaP7jNEpPXK
brFrpIlZzRCveu0Q5yZVMsqqtqTsTuSu7DAiaQYjgEmEQKnESzsBU0EjdoosQ88=
=Xosh
-----END PGP SIGNATURE-----

--NMMtlwleeRJSevFd--

--===============8787942737688329710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8787942737688329710==--
