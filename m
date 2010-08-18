From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: Routing irq throw a gpio using the wm9713
Date: Wed, 18 Aug 2010 12:35:09 +0200
Message-ID: <4C6BB75D.4010406@gandalf.sssup.it>
References: <4BFBF44F.1010000@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.tre.it (mail.tre.it [62.13.171.46])
	by alsa0.perex.cz (Postfix) with ESMTP id C19C6244C7
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 12:35:14 +0200 (CEST)
In-Reply-To: <4BFBF44F.1010000@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark

Sorry for the silly question but I have tried to route the gpio to the 
irq line
on wm9713 without success. Can you comment the below code?

Michael Trimarchi wrote:
> Hi all,
>
> I'm trying to rise an irq using irq2 of the wm9713 so I have configured
> the codec like this:
>
> #define GPIO2 (1 << 2)
> #define GPIO6 (1 << 6)
>
> /* Enable Interrupt Output enable on GPIO02 */
> reg = codec->read(codec, AC97_MISC_AFE);
> codec->write(codec, AC97_MISC_AFE, reg & ~GPIO02);
>
> reg = codec->read(codec, AC97_GPIO_CFG);
> codec->write(codec, AC97_GPIO_CFG, reg & ~GPIO02);
>
> reg = codec->read(codec, AC97_GPIO_STICKY);
> codec->write(codec, AC97_GPIO_STICKY, reg | GPIO06);
>
> reg = codec->read(codec, AC97_GPIO_WAKEUP);
> codec->write(codec, AC97_GPIO_WAKEUP, reg | GPIO06);
>
>
> Then create a soc-jack on a gpio that is wired with the gpio6
> of the codec.
>
> I don't received any interrupt
>
> Michael Trimarchi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
Regards Michael
