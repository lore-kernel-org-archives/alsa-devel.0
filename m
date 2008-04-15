From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/3] soc - pxa2xx-ac97: Add missing
	clk_enable()
Date: Tue, 15 Apr 2008 19:32:39 +0800
Message-ID: <f17812d70804150432t1fd0e20cpedaba34b47eb807d@mail.gmail.com>
References: <20080414151128.GA23694@rakim.wolfsonmicro.main>
	<1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id D2AC324704
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 13:32:40 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2645761wag.8
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 04:32:39 -0700 (PDT)
In-Reply-To: <1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

It looks a bit confused between the commit message and the actual change.
My understanding would be the pxa{25x,27x} requires this change (adding
clk_enable), but pxa3xx does not require this. So actually the change is
addressing some issue on pxa{25x,27x}?

On Mon, Apr 14, 2008 at 11:12 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> For some reason this is not required on PXA3xx.
>
>  Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>  ---
>   sound/soc/pxa/pxa2xx-ac97.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
>  diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
>  index fe9c297..e173799 100644
>  --- a/sound/soc/pxa/pxa2xx-ac97.c
>  +++ b/sound/soc/pxa/pxa2xx-ac97.c
>  @@ -314,6 +314,7 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev)
>                 ac97_clk = NULL;
>                 goto err_irq;
>         }
>  +       clk_enable(ac97_clk);
>         return 0;
>
>   err_irq:
>  --
>  1.5.5
>
>



-- 
Cheers
- eric
