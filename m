From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8804: fix error handling code
Date: Mon, 11 Oct 2010 13:00:15 +0100
Message-ID: <20101011120014.GJ9231@rakim.wolfsonmicro.main>
References: <1286731745-18169-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61388103937
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 14:00:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286731745-18169-1-git-send-email-segooon@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 10, 2010 at 09:29:04PM +0400, Vasiliy Kulikov wrote:
> kzalloc() returns NULL on error, not ERR_PTR().
> Also wm8804_modinit() didn't called i2c_del_driver() if
> spi_register_driver() failed.
> 
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>

Please try to follow Documentation/SubmittingPatches - in particular,
you should always split unrelated changes into separate patches.  In
this case your I2C and kzalloc() changes have nothing to do with each
other and so should be in separate patches, and the kzalloc() changes
were already applied from a patch by someone else.  For the registration
changes...

> @@ -804,6 +804,7 @@ static int __init wm8804_modinit(void)
>  	if (ret) {
>  		printk(KERN_ERR "Failed to register wm8804 I2C driver: %d\n",
>  		       ret);
> +		goto err;
>  	}
>  #endif
>  #if defined(CONFIG_SPI_MASTER)

...it's not clear to me that this change is an improvement - it'll make
the driver more fragile in the face of errors, I don't see a benefit in
refusing to register the variant for one bus if the other fails?
