From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V2] Sound: sgtl5000 Allow codec clock
	frequency to be set.
Date: Fri, 22 Mar 2013 09:08:41 -0500
Message-ID: <CAOZdJXWi2pph-=vQg+FAty+yVVk9fJBU6rxYOf0J-J2f=Lwgxw@mail.gmail.com>
References: <20130322093344.20605.49509.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id C75FF26519A
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 15:08:45 +0100 (CET)
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by muin.pair.com (Postfix) with ESMTPSA id 0E6A58FC30
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 10:08:42 -0400 (EDT)
Received: by mail-la0-f41.google.com with SMTP id fo12so7371717lab.28
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 07:08:41 -0700 (PDT)
In-Reply-To: <20130322093344.20605.49509.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2013 at 4:33 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 424347e..71ce1f6 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -128,18 +128,30 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>                 goto fail;
>         }
>
> +       ret = of_property_read_u32(codec_np, "clock-frequency",
> +                                       &data->clk_frequency);

I just noticed that you assign 'ret' here, but you never check the
value.  So I think you should either:

1) Check the value of 'ret'
2) Remove the "ret = "
