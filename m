From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] [RFC]intel_hdmi_audio: interface	module
Date: Mon, 22 Nov 2010 13:58:12 +0000
Message-ID: <20101122135812.GD15156@sirena.org.uk>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<1290433186-31628-2-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D6AA11039FB
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:58:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290433186-31628-2-git-send-email-ramesh.babu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramesh.babu@intel.com
Cc: alsa-devel@alsa-project.org, Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 07:09:43PM +0530, ramesh.babu@intel.com wrote:

> +/**
> + * snd_intelhad_dev_free - to free alsa card instance
> + *
> + * @device: pointer to device
> + *
> + * This function is called when the hdmi cable is un plugged
> + */
> +static int snd_intelhad_dev_free(struct snd_device *device)
> +{
> +	struct snd_intelhad *intelhaddata;
> +
> +	BUG_ON(!device);
> +	pr_debug("had: snd_intelhad_dev_free called\n");
> +	intelhaddata = device->device_data;
> +	return 0;
> +}

This function doesn't appear to do anything like what either the
description or name would suggest?  I'd expect to see some deallocation
going on...

> +/**
> + * had_hot_plug - to create sound card instance for HDMI audio playabck
> + *
> + *
> + * This function is called when the hdmi cable is plugged in. This function
> + * creates and registers the sound card with ALSA
> + */
> +static int had_hot_plug(void)
> +{

It would seem more natural for the HDMI device to be created and
instatiated via the normal Linux device model - when a HDMI connection
is detected the thing doing the detection creates and registers a new
device of some kind which the driver core then binds to a separate
driver.
