From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: do not use devres on a
 foreign device
Date: Wed, 25 Sep 2013 10:01:07 -0300
Message-ID: <CAOMZO5A6Ffy7a29ZGYBawv3WigEg=Ur+dmQwvgg_x1YuObkcTA@mail.gmail.com>
References: <1380104168-29678-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f178.google.com (mail-ve0-f178.google.com
 [209.85.128.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 406B6261B2E
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 15:01:08 +0200 (CEST)
Received: by mail-ve0-f178.google.com with SMTP id jw12so4802578veb.9
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 06:01:07 -0700 (PDT)
In-Reply-To: <1380104168-29678-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 25, 2013 at 7:16 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Calling devm_clk_get with any device pointer other than our own confuses
> devres. Use clk_get instead. This avoids hitting the following warning in
> the imx-sgtl5000 error path:
>
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-517)
> platform sound.12: Driver imx-sgtl5000 requests probe deferral
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 75 at drivers/base/dd.c:272 driver_probe_device+0x194/0x218()
> Modules linked in: snd_soc_sgtl5000(+) snd_soc_imx_sgtl5000 coda snd_soc_imx_audmux imx_sdma snd_soc_fsl_spdif snd_soc_fsl_ssi
> CPU: 0 PID: 75 Comm: udevd Not tainted 3.11.0-rc6+ #4682
> Backtrace:
> [<80010bc4>] (dump_backtrace+0x0/0x10c) from [<80010d60>] (show_stack+0x18/0x1c)
>  r6:00000110 r5:00000009 r4:00000000 r3:00000000
> [<80010d48>] (show_stack+0x0/0x1c) from [<804f0764>] (dump_stack+0x20/0x28)
> [<804f0744>] (dump_stack+0x0/0x28) from [<8001a4a4>] (warn_slowpath_common+0x6c/0x8c)
> [<8001a438>] (warn_slowpath_common+0x0/0x8c) from [<8001a4e8>] (warn_slowpath_null+0x24/0x2c)
>  r8:7f032000 r7:7f02f93c r6:cf8eaa54 r5:cf8eaa20 r4:80728a0c
> [<8001a4c4>] (warn_slowpath_null+0x0/0x2c) from [<80286bdc>] (driver_probe_device+0x194/0x218)
> [<80286a48>] (driver_probe_device+0x0/0x218) from [<80286cf4>] (__driver_attach+0x94/0x98)
>  r7:00000000 r6:cf8eaa54 r5:7f02f93c r4:cf8eaa20
> [<80286c60>] (__driver_attach+0x0/0x98) from [<802851c8>] (bus_for_each_dev+0x5c/0x90)
>  r6:80286c60 r5:7f02f93c r4:00000000 r3:cf8ef03c
> [<8028516c>] (bus_for_each_dev+0x0/0x90) from [<80286654>] (driver_attach+0x24/0x28)
>  r6:806d0424 r5:cf16a580 r4:7f02f93c
> [<80286630>] (driver_attach+0x0/0x28) from [<802861e4>] (bus_add_driver+0xdc/0x234)
> [<80286108>] (bus_add_driver+0x0/0x234) from [<802871d4>] (driver_register+0x80/0x154)
>  r8:7f032000 r7:00000001 r6:7f02fa68 r5:7f02fa74 r4:7f02f93c
> [<80287154>] (driver_register+0x0/0x154) from [<8033c278>] (i2c_register_driver+0x34/0xbc)
> [<8033c244>] (i2c_register_driver+0x0/0xbc) from [<7f032018>] (sgtl5000_i2c_driver_init+0x18/0x24 [snd_soc_sgtl5000])
>  r5:7f02fa74 r4:cfb7ff48
> [<7f032000>] (sgtl5000_i2c_driver_init+0x0/0x24 [snd_soc_sgtl5000]) from [<80008738>] (do_one_initcall+0xf4/0x150)
> [<80008644>] (do_one_initcall+0x0/0x150) from [<80053f64>] (load_module+0x174c/0x1db4)
> [<80052818>] (load_module+0x0/0x1db4) from [<800546ac>] (SyS_init_module+0xe0/0xf4)
> [<800545cc>] (SyS_init_module+0x0/0xf4) from [<8000e540>] (ret_fast_syscall+0x0/0x30)
>  r6:00005b22 r5:00afed68 r4:00000000
> ---[ end trace b24c5c3bb145dbdd ]---
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
