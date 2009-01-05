From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Add AC'97 driver for AT91SAM9263ek atmel
	board.
Date: Mon, 5 Jan 2009 17:39:19 +0000
Message-ID: <20090105173918.GD29853@sirena.org.uk>
References: <48E3A42C.6090202@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DC461037FD
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 18:39:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <48E3A42C.6090202@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 01, 2008 at 06:24:12PM +0200, Sedji Gaouaou wrote:

> Add AC'97 driver for AT91SAM9263ek atmel board.
> The driver includes the playback and the capture.

Could this be written so that it'd also work with the AT32 CPUs?  It
certainly has some similarities to the out of tree AC97 driver in the
AVR32 kernels.

> +static void snd_at91_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> +				 unsigned short val)
> +{
> +	do {
> +		if (ac97c_readl(chip, COSR) & AT91C_AC97C_TXRDY) {
> +			ac97c_writel(chip, COTHR, word);
> +			return;
> +		}
> +		udelay(1);
> +	} while (--timeout);

Using udelay() might get rather expensive if you end up with a lot of
AC97 register access going on.  It's not common for plain audio stuff
but there are AC97 codecs with additional functionality such as
touchscreen interfaces which do a lot more register I/O.  A similar
issue affected the AVR32 driver, I've no idea if it was fixed there (I
know there was code to fix it, but I don't know if it was merged).

> +#define ac97c_writel(chip, reg, val)			\
> +	writel((val), (chip)->regs + AC97C_##reg)
> +
> +#define ac97c_readl(chip, reg)				\
> +	readl((chip)->regs + AC97C_##reg)

There's a bit of a namespacing issue here - might be better to give them
a more at91-specific name.  It'd also be nicer to use inline functions
rather than macros.
