From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Wed, 3 Jun 2009 15:18:19 +0200
Message-ID: <20090603131819.GQ26148@buzzloop.caiaq.de>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C846103804
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 15:18:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 08:33:42PM +0800, Eric Miao wrote:
> Make the pxa I2S configuration generic, add support for Left_J, add
> support for variable frame width like 32fs, 48fs, 64fs and 96fs
> 
> Signed-off-by: Paul Shen <bshen9@marvell.com>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 +++---
>  sound/soc/pxa/pxa-ssp.c                   |   62 ++++++++++++++--------------
>  sound/soc/pxa/pxa-ssp.h                   |    9 ++++
>  3 files changed, 47 insertions(+), 38 deletions(-)

Ok, I tried that code on my board and this is what I had to change
there:

The tdm time slot configuration needs to be set again in my board support
code just like in your example: snd_soc_set_tdm_slot(cpu_dai, 3, 2). And
the PXA_SSP_DIV_SCR value needed to be doubled from 4 to 8.

With that changes, LRCLK is 44100Hz when configured to 44100Hz. But the
bitclk is not 64fs anymore but 32fs only (1.41Mhz). Is there any
implementation details I miss? What does your codec clock config look
like?

Another small thing:

  CC      sound/soc/pxa/pxa-ssp.o
  sound/soc/pxa/pxa-ssp.c:186: warning: 'ssp_get_scr' defined but not used
 
Daniel
