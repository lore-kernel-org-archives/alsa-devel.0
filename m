From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 05/12] ASoC: Intel: mrfld: add bytes control
	for modules
Date: Wed, 13 Aug 2014 21:00:12 +0100
Message-ID: <20140813200012.GO17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7088540395404954600=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4AD0265593
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:00:21 +0200 (CEST)
In-Reply-To: <1407145563-1303-6-git-send-email-subhransu.s.prusty@intel.com>
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


--===============7088540395404954600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qrMIA5tEAw9UynaJ"
Content-Disposition: inline


--qrMIA5tEAw9UynaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 03:15:56PM +0530, Subhransu S. Prusty wrote:

> From: Vinod Koul <vinod.koul@intel.com>

> This patch add support for various modules like eq etc for mrfld DSP. All these
> modules will be exposed to usermode as bytes controls.

Indeed they are actually exposed by this code.

> +static inline void sst_fill_byte_control(char *param,
> +					 u8 ipc_msg, u8 block,
> +					 u8 task_id, u8 pipe_id,
> +					 u16 len, void *cmd_data)

Let the compiler figure out if this should be inline, this doesn't seem
something that should obviously be inline and isn't in a header.

> +	if (len > SST_MAX_BIN_BYTES - sizeof(*byte_data)) {
> +		WARN(1, "%s: command length too big (%u)", __func__, len); /* this happens only if code is wrong */
> +		len = SST_MAX_BIN_BYTES - sizeof(*byte_data);
> +	}

Coding style, 80 columns.  Since the only caller can return an error
code you could do that here too.

> +static int sst_fill_and_send_cmd_unlocked(struct sst_data *drv,
> +				 u8 ipc_msg, u8 block, u8 task_id, u8 pipe_id,
> +				 void *cmd_data, u16 len)
> +{
> +	sst_fill_byte_control(drv->byte_stream, ipc_msg, block, task_id, pipe_id,
> +			      len, cmd_data);
> +	return sst->ops->send_byte_stream(sst->dev,
> +			(struct snd_sst_bytes_v2 *)drv->byte_stream);
> +}

There's a lot of casting going on in this code.

> +static int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_info *uinfo)
> +{
> +	struct sst_algo_control *bc = (void *)kcontrol->private_value;
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> +	uinfo->count = bc->max;
> +
> +	/* allocate space to cache the algo parameters in the driver */
> +	if (bc->params == NULL) {
> +		bc->params = devm_kzalloc(component->dev, bc->max, GFP_KERNEL);
> +		if (bc->params == NULL)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}

I wouldn't expect an info call to be allocating anything - why is it
doing that?  It's not looking at the alocated data except to see if the
allocation succeeded.  What happens if someone manages to do a get or
set without having first done an info and why aren't we doing any
allocation on initialisation?

> +	case SST_ALGO_BYPASS:
> +		ucontrol->value.integer.value[0] = bc->bypass ? 1 : 0;
> +		pr_debug("%s: bypass  %d\n", __func__, bc->bypass);
> +		break;

Is bypass not a boolean value already, and shouldn't these just end up
with controls called something "Switch" - they look to be just directly
usable switches?

> +	default:
> +		pr_err("Invalid Input- algo type:%d\n", bc->type);

dev_err().

> +	switch (bc->type) {
> +	case SST_ALGO_PARAMS:
> +		if (bc->params)
> +			memcpy(bc->params, ucontrol->value.bytes.data, bc->max);
> +		break;

So if bc->params didn't get allocated somehow we just silently drop the
set?

> +	/*if pipe is enabled, need to send the algo params from here */
> +	if (bc->w && bc->w->power)
> +		sst_send_algo_cmd(drv, bc);

sst_send_algo_cmd() should be returning an eror code (it doesn't but the
functions it calls can).

I'm not seeing any code to restore these controls on power up here.

--qrMIA5tEAw9UynaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68PJAAoJELSic+t+oim9xMsP/RShExhTMXwb197keHSDwbqg
YEsDIPWFbzPYknEhKiXsEb8UZx3LJwBH0nfWliqyZ/OiCdloDAIKUIHryOowanY6
nEBLGp56qSaKiYvbJnutVuf+0i9jhrah5l49XO4E6+9/KEsbucG21DAhBp+aLzBi
5l7VyailW7QvR0BjwvC32jyveu5rrth1ikgVabTNsDdrpdjKpvq3LnEeggR8ghS/
MjIdK8/Lh2SiqtyJc0zrTTqF3BidFgbjQ/vyuz6U7Z2oy0CRnUd6Kmz6UMTksj1f
QJkjrUUIngT4tEQYmy5A9ru9STMje5xXRSH+GJlX8zGOkssLDXK+jy8ORKOhX1k8
0ruawewQ21PB6wDvYIJeaIIT3jPMucTrzmV6iQBszvHr6UcQRIemcHVQd6u5uFta
A26iz0mIwSQM98cwr2FnTc7YjtPAI+5Dq9Ux0hbF1xaZxkXs2s9WGH+itDNA041a
d3TzjL8KCbzndj6W1wyygglzQbfBh/u+oUyeVHL1I+axGhdE1JMftkICe99umrj2
OiW3sMoZjbRMTfXjS+0IF7cc9Y66JWWTQX6J7p+1TQGrPXMBvz0gX+4XzDS1L9hy
OxpHMq8MYZSGr2hPoMmZeln4qhhamDLl9GNZ/0sDclspKEoxVSUtg449QrRvmSn4
14HQe0WZ73w1DvRgTYMi
=K0xE
-----END PGP SIGNATURE-----

--qrMIA5tEAw9UynaJ--

--===============7088540395404954600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7088540395404954600==--
