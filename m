From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH] ASoC: sprd: Fix modular build
Date: Wed, 3 Apr 2019 13:17:32 +0800
Message-ID: <CAMz4kuK1v_x=YttDn_T=XR7Edbg6yTHX3d=bKg4CAidVSxv4NA@mail.gmail.com>
References: <20190403045654.26957-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3092AF8071D
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 07:17:45 +0200 (CEST)
Received: by mail-ot1-x342.google.com with SMTP id f10so6655222otb.6
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2019 22:17:45 -0700 (PDT)
In-Reply-To: <20190403045654.26957-1-broonie@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, 3 Apr 2019 at 12:57, Mark Brown <broonie@kernel.org> wrote:
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/sprd/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sprd/Makefile b/sound/soc/sprd/Makefile
> index fa1d5476b8da..e6c2606da8e2 100644
> --- a/sound/soc/sprd/Makefile
> +++ b/sound/soc/sprd/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Spreadtrum Audio Support
>
> -obj-$(CONFIG_SND_SOC_SPRD)     += sprd-pcm-dma.o sprd-pcm-compress.o
> +snd-soc-sprd-platform-objs := sprd-pcm-dma.o sprd-pcm-compress.o
> +
> +obj-$(CONFIG_SND_SOC_SPRD) += snd-soc-sprd-platform.o
> --

Thanks for your help. It can fix the issue.
Tested-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
