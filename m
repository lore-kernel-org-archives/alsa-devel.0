From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio	support.
Date: Mon, 8 Jun 2009 10:25:22 +0100
Message-ID: <20090608092521.GA7858@sirena.org.uk>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	<1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B23F1103810
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 11:25:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 07, 2009 at 08:39:01PM +0200, Manuel Lauss wrote:
> Replaces the sample Alchemy PSC AC97 machine code with a DB1200 machine
> driver with AC97 and I2S support.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

If this is going to go in during the merge window I'm happy for it to go
in via the MIPS tree but otherwise I'd much rather it goes via ASoC in
case API changes cause merge issues.  I don't know what you prefer,
Ralf?

We could also split the MIPS and ASoC parts into separate patches if
that helps.

> +/* it sucks that the ASoC headers are not under include/ */
> +#include "../codecs/ac97.h"
> +#include "../codecs/wm8731.h"

This is because they're internal to ASoC - having them out of include
should set off big red warning flags for something outside ASoC is
looking at them.  If there are things that should be referenced outside
ASoC they should be in a separate header in include/sound like the
WM9081 platform data.

> +static int db1200_ac97_init(struct snd_soc_codec *codec)
> +{
> +	snd_soc_dapm_sync(codec);
> +	return 0;
> +}

This could be removed but it does no harm.

> +/*-------------------------  COMMON PART  ---------------------------*/
> +
> +static struct resource psc1_res[] = {
> +	[0] = {
> +		.start	= CPHYSADDR(PSC1_BASE_ADDR),
> +		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
> +		.flags	= IORESOURCE_MEM,

If you conver the I2S driver to use the standard device probing model
this could all me moved into the architecture code rather than placed in
machine drivers.
