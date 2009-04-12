From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Question about pxa2xx-ac97-lib.c
Date: Sun, 12 Apr 2009 17:53:35 +0100
Message-ID: <20090412165335.GA4295@sirena.org.uk>
References: <200904121647.39464.marek.vasut@gmail.com> <87ocv1akwu.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F0F471037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 18:53:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87ocv1akwu.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 12, 2009 at 06:36:49PM +0200, Robert Jarzmik wrote:

> I originaly thought we would change pxa_set_ac97_info(), to add a parameter
> which will be the platform data for the gpio.

Yes, this is the approach that should be adopted.  The platform data
should not change per board.

> IOW, have something like :
> void __init pxa_set_ac97_info(struct pxa2xx_ac97_platform_data *pdata)
> {
>         pxa_register_device(&pxa_device_ac97, ops);
> }

Note that we already have platform data for the PXA AC97 devices.

> The trouble is, I saw references to the platform data as pxa2xx_audio_ops_t*,
> mostly to suspend and resume a card. I've seen them in pxa2xx_ac97_do_suspend(),
> pxa2xx_ac97_do_resume().

> Mark, could you please have a glance at it, and tell us the right approach to
> have the struct pxa2xx_ac97_platform_data passed to pxa2xx-ac97 please ?

Those are platform data, currently the only mainline use I'm aware of is
for mainstone - it's been present since before the pxa2xx-ac97-lib was
introduced.

Looking at the code it appears we've broken mainstone, though
unfortunately my mainstone has some independant problem with resume so I
can't test but I'll make a patch merging the two structures on Monday.
