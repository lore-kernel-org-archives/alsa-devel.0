From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
	pxa2xx-ac97
Date: Thu, 23 Jul 2009 11:27:41 +0100
Message-ID: <20090723102741.GB6673@rakim.wolfsonmicro.main>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721223424.GA21147@oksana.dev.rtsoft.ru>
	<200907221301.04239.marek.vasut@gmail.com>
	<200907221302.40893.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C60011039DA
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 12:27:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907221302.40893.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Robert Jarzmik <robert.jarzmik@free.fr>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 01:02:40PM +0200, Marek Vasut wrote:

>  	struct snd_ac97_bus *ac97_bus;
>  	struct snd_ac97_template ac97_template;
>  	int ret;
> +	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
> +	int id = dev->id < 0 ? 0 : dev->id;
>  

dev here is the AC97 controller device - if there's more than one AC97
controller in the system they can each have the four child devices.  On
the other hand, I don't think any of the PXA processors have more than
one AC97 controller so it'll never actually have any impact.

I think the best thing for now is to either warn if anything except the
primary codec has platform data or change the platform data to have a
variable something like primary_audio_pdata.  The driver doesn't appear
to support secondary codecs anyway.
