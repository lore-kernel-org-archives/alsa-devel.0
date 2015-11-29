From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: using params_width function
 to simplify code
Date: Sun, 29 Nov 2015 09:35:39 -0500
Message-ID: <CAOZdJXXxFXMjw5HZK9QuLgtEV-kAVresmOCB+efiQbQtp0hoaQ@mail.gmail.com>
References: <c305d87967734ad68067cca39c9e61c35dacf3b7.1448350220.git.zidan.wang@freescale.com>
 <61c4bd3dd82c40b59d1d2570a400321027ae6abc.1448350220.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 71F83265351
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2015 15:35:41 +0100 (CET)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by muin.pair.com (Postfix) with ESMTPSA id E7CDFF186D
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2015 09:35:39 -0500 (EST)
Received: by ioir85 with SMTP id r85so150305548ioi.1
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2015 06:35:39 -0800 (PST)
In-Reply-To: <61c4bd3dd82c40b59d1d2570a400321027ae6abc.1448350220.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 2:32 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> using params_width function to simplify code.
>
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 2 +-
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  sound/soc/fsl/fsl_sai.c  | 2 +-
>  sound/soc/fsl/fsl_ssi.c  | 3 +--

 Acked-by: Timur Tabi <timur@tabi.org>
