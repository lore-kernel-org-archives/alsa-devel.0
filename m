From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] S3C AUDIO: Add header to pass	platform
	data to device drivers.
Date: Fri, 6 Nov 2009 16:52:14 +0000
Message-ID: <20091106165214.GF4938@sirena.org.uk>
References: <1257384900-18308-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BD4424468
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 17:52:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257384900-18308-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 10:35:00AM +0900, Jassi Brar wrote:

> +/**
> + * struct s3c_audio_pdata - common platform data for audio device drivers
> + * @pdata: Pointer to protocol(I2S, PCM or AC97) specific platform data
> + * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
> + */
> +struct s3c_audio_pdata {
> +	void *pdata;
> +
> +	int (*cfg_gpio)(struct platform_device *);
> +};

I don't see much benefit in this structure with the pdata embedded in it
- you just end up with an additional layer of indirection in your
platform data if you need to add device specific stuff which is annoying
to specify in machine drivers.

I'd just embed the GPIO configuration callback in a driver-specific
platform data.
