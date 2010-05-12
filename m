From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 6/6] kirkwood: Add audio support to openrd
 client platforms
Date: Wed, 12 May 2010 11:26:27 +0100
Message-ID: <20100512102627.GG4330@rakim.wolfsonmicro.main>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.776313041@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1240224333
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 12:26:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100511162602.776313041@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 06:23:48PM +0200, apatard@mandriva.com wrote:

> +	adapter = i2c_get_adapter(0);
> +	if (!adapter)
> +		return -ENODEV;
> +
> +	cs42l51_client = i2c_new_device(i2c_get_adapter(0), i2c_board_info);
> +	i2c_put_adapter(adapter);
> +	if (!cs42l51_client)
> +		return -ENODEV;

This should be in the arch/arm code.  There's no reason to dynamically
add this at runtime.

> +	ret = platform_device_add_resources(openrd_client_snd_device,
> +					kirkwood_audio_resources,
> +					ARRAY_SIZE(kirkwood_audio_resources));
> +	if (ret) {
> +		printk(KERN_ERR "%s: Failed to add ressources\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = platform_device_add(openrd_client_snd_device);
> +	if (ret) {
> +		printk(KERN_ERR "%s: platform_device_add failed\n", __func__);
> +		platform_device_put(openrd_client_snd_device);
> +	}

As I said when reviewing the CPU drivers these should be part of the
setup of the I2S device in arch/arm.
