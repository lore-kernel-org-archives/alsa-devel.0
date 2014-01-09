From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Set default slot number for
 common cases
Date: Thu, 9 Jan 2014 08:24:24 -0200
Message-ID: <CAOMZO5C8hGYehqJ6WFUKye8wENuAejT-YXggeYy7V+DQ2_OMHg@mail.gmail.com>
References: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f174.google.com (mail-ve0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FF32265281
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 11:24:25 +0100 (CET)
Received: by mail-ve0-f174.google.com with SMTP id pa12so2245501veb.33
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 02:24:24 -0800 (PST)
In-Reply-To: <1389260514-11365-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 9, 2014 at 7:41 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
> For those platforms using DAI master mode like I2S, it's better to pre-set
> a default slot number so that there's no need for these common cases to set
> the slot number from its machine driver any more.
>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 94dedcb..57ab45b 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -711,6 +711,16 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
>         if (ssi_private->imx_ac97)
>                 fsl_ssi_setup_ac97(ssi_private);
>
> +       /* Set a default slot number so that there is no need for those common
> +        * cases like I2S mode to call the extra set_tdm_slot() any more.
> +        */

Incorrect style for multi-line comment.

Regards,

Fabio Estevam
