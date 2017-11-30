From: =?UTF-8?B?V3UtQ2hlbmcgTGkgKOadjuWLmeiqoCk=?= <wuchengli@google.com>
Subject: Re: [PATCH] ASoC: nau8825: set clear_irq when imm IRQ
	happened
Date: Thu, 30 Nov 2017 10:30:11 +0800
Message-ID: <CAOMLVLh8gWtoimHBe2Nh-yPY7Lp5BXsOvB_hsELEYZ1RShB6EQ@mail.gmail.com>
References: <1512007997-31704-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 502E5266E70
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 03:30:33 +0100 (CET)
Received: by mail-it0-f65.google.com with SMTP id d16so6680895itj.1
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 18:30:33 -0800 (PST)
In-Reply-To: <1512007997-31704-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, Cheng-yi Chiang <cychiang@google.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, AC30 WTLi <WTLI@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, Mac Chiang <mac.chiang@intel.com>, broonie@kernel.org, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <mhkuo@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

Can you combine this patch with "ASoC: nau8825: disable crosstalk by
default"? This should be a part of that patch.

On Thu, Nov 30, 2017 at 10:13 AM, John Hsu <KCHSU0@nuvoton.com> wrote:
> Although the crosstalk is disabled, it is better to set clear_irq
> properly when the impedance measurement interrupt happens.
> It can avoid that the driver clears other IRQs by accident
> if the active_irq has another IRQ events.
>
> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index d3c1a02..603cd72 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -1733,10 +1733,9 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
>                         nau8825->xtalk_event_mask = event_mask;
>                 }
>         } else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
> -               if (nau8825->xtalk_enable) {
> +               if (nau8825->xtalk_enable)
>                         schedule_work(&nau8825->xtalk_work);
> -                       clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
> -               }
> +               clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
>         } else if ((active_irq & NAU8825_JACK_INSERTION_IRQ_MASK) ==
>                 NAU8825_JACK_INSERTION_DETECTED) {
>                 /* One more step to check GPIO status directly. Thus, the
> --
> 2.6.4
>
