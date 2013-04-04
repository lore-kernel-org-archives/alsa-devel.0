From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v5 1/2] ALSA: ASoC: davinci-mcasp: don't
 configure AFSX direction in DIT mode
Date: Thu, 4 Apr 2013 12:49:32 +0200
Message-ID: <CAGm1_kuVfwFKfUZkPTLyjza4FcpegJqxH=fCKUhPykJKMXp48g@mail.gmail.com>
References: <1362663483-5886-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 74FE6265E9B
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 12:49:53 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id j10so1402383bkw.32
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 03:49:53 -0700 (PDT)
In-Reply-To: <1362663483-5886-1-git-send-email-yegorslists@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: tiwai@suse.de, Yegor Yefremov <yegorslists@googlemail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 7, 2013 at 2:38 PM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> AFSX won't be used in DIT mode. The related pins are AHCLKX and
> the data pins.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Daniel Mack <zonque@gmail.com>
> ---
> v5: add Daniel's Tested-by
> v4: change subjuct to include "ALSA: ASoC: "
>
>  sound/soc/davinci/davinci-mcasp.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 9321e5c..90a9b99 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -772,9 +772,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
>  /* S/PDIF */
>  static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
>  {
> -       /* Set the PDIR for Serialiser as output */
> -       mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AFSX);
> -
>         /* TXMASK for 24 bits */
>         mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
>
> --
> 1.7.7
>

Mark, could you please take a look at this patch and queue for 3.10?

Thanks.

Yegor
