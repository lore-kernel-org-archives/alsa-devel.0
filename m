From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - Preliminary support for Xonar Xense
 (resubmitAdded support for Xonar Xense. Only speaker out and mic in
 working.
Date: Mon, 29 Jul 2013 21:58:33 +0200
Message-ID: <51F6C969.7050504@ladisch.de>
References: <1375119909-24454-1-git-send-email-madeallup.gen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1375119909-24454-1-git-send-email-madeallup.gen@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian Dawes <madeallup.gen@gmail.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ian Dawes wrote:
>
> Signed-off-by: Ian Dawes <madeallup.gen@gmail.com>

The commit message was squashed into the subject line.  There's probably
an empty line missing between them.

> +++ b/sound/pci/oxygen/xonar_pcm179x.c
> +static void xonar_xense_init(struct oxygen *chip)
> +{
> +	struct xonar_pcm179x *data = chip->model_data;
> +
> +	data->generic.ext_power_reg = OXYGEN_GPI_DATA;
> +	data->generic.ext_power_int_reg = OXYGEN_GPI_INTERRUPT_MASK;
> +	data->generic.ext_power_bit = GPI_EXT_POWER;
> +	xonar_init_ext_power(chip);
> +	xonar_st_init(chip);
> +}

How much of this is guesswork?  :-)

Shouldn't you rather use xonar_stx_init(), which does not try to
configure the nonexistent CS2000 chip?

> +	case 0x8428:
> +		chip->model = model_xonar_st;
> +		chip->model.shortname = "Xonar Xense";
> +		chip->model.chip = "AV100";
> +		chip->model.init = xonar_xense_init;
> +		chip->model.dac_channels_pcm = 8;
> +		chip->model.dac_channels_mixer = 8;

When only two channels work, why declaring more?


Regards,
Clemens
