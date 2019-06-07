From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 000/146] ASoC: modern dai_link style
	support
Date: Fri, 7 Jun 2019 10:21:55 -0300
Message-ID: <CAOMZO5A=zi_6OtjwWXJcbHn+AKz3SvmKgQrSemd6qWjAePuqXQ@mail.gmail.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77EF6F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 15:22:02 +0200 (CEST)
Received: by mail-lf1-x143.google.com with SMTP id a9so1600744lff.7
 for <alsa-devel@alsa-project.org>; Fri, 07 Jun 2019 06:22:02 -0700 (PDT)
In-Reply-To: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori-san and Mark,

On Thu, Jun 6, 2019 at 1:08 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Mark
>
> These are v2 for modern dai_link style support patches.
> [001/146] adds missing modern dai_link style for CPU.
> and others are switch to modern style from legacy style.
> Last patch removes legacy style.
>
> These are based on mark/for-5.3 + linus/master
>
> I added posted Tested-by at ateml mikroe-proto,
> and Signed-off-by Pierre-Louis for some Intel patches,
> and new patch for new Intel bytcht_cx2072x

We are seeing kernel crash in today's linux-next and it looks like it
is related to this series:
https://storage.kernelci.org/next/master/next-20190607/arm/imx_v6_v7_defconfig/gcc-8/lab-pengutronix/boot-imx53-qsrb.html

I haven't investigated yet, but just wanted to let you know.

Thanks
