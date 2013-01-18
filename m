From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm_adsp: Set ADSP1 clock rate to
 match sys clock
Date: Fri, 18 Jan 2013 15:17:13 +0900
Message-ID: <20130118061711.GB4960@opensource.wolfsonmicro.com>
References: <1358428307-30196-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75D7326501C
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 07:17:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1358428307-30196-1-git-send-email-crattray@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2013 at 01:11:46PM +0000, Chris Rattray wrote:

>  #define ADSP1_CONTROL_30                  0x24
>  #define ADSP1_CONTROL_31                  0x26
>  
> +#define ADSP1_CLOCKING 38

> +/*
> + * ADSP1 Control 31
> + */
> +#define ADSP1_CLK_SEL_MASK                0x0007  /* CLK_SEL_ENA */
> +#define ADSP1_CLK_SEL_SHIFT                    0  /* CLK_SEL_ENA */
> +#define ADSP1_CLK_SEL_WIDTH                    3  /* CLK_SEL_ENA */

You just called this ADSP1_CLOCKING above, using a different style to
the other register #defines too (and of course there's already one for
the helpfully named ADSP1 Control 31...).
