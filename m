From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH RESEND] ASoC: Remove impossible case from wm8994_hw_params
Date: Tue, 11 Oct 2011 18:00:55 +0800
Message-ID: <CAF+7xWnuApJfdnpj4yajfYepw8syEdeH_wHOL6wmprPv_MAZmg@mail.gmail.com>
References: <1317857999.6291.3.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317857999.6291.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/10/6 Axel Lin <axel.lin@gmail.com>:
> We set hw_params callback for wm8994_aif3_dai_ops to wm8994_aif3_hw_params.
> Thus no need to check wm8994-aif3 in wm8994_hw_params.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
hi Mark,
Seems this patch is missed. This resend should be appliable to current code.

Thanks,
Axel
