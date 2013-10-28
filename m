From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
Date: Mon, 28 Oct 2013 16:32:15 +0800
Message-ID: <CAGsJ_4xHHD9XqLMdepUgRL7_X5Xg3_AQ2K83pbCxiFhV8cX4zg@mail.gmail.com>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
 <526E08D1.4040009@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 062B826164D
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 09:32:36 +0100 (CET)
Received: by mail-pd0-f180.google.com with SMTP id p10so6683018pdj.25
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 01:32:35 -0700 (PDT)
In-Reply-To: <526E08D1.4040009@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Mark Brown <broonie@kernel.org>, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2013/10/28 Lars-Peter Clausen <lars@metafoo.de>:
> On 10/27/2013 11:37 PM, Barry Song wrote:
>> +struct snd_soc_dai_ops sirfsoc_i2s_dai_ops = {
>
> static const
>
> Building your driver with sparse (`make C=2 ...`) will tell you these things.
>
>> +     .startup        = sirf_i2s_startup,
>> +     .shutdown       = sirf_i2s_shutdown,
>> +     .trigger        = sirf_i2s_trigger,
>> +     .hw_params      = sirf_i2s_hw_params,
>> +     .set_fmt        = sirf_i2s_set_dai_fmt,
>> +     .set_clkdiv     = sirf_i2s_set_clkdiv,
>> +};
>> +
> [...]
>> +
>> +static int sirf_i2s_probe(struct platform_device *pdev)
>> +{
>> +     struct sirf_i2s *si2s;
>> +     u32 rx_dma_ch, tx_dma_ch;
>> +     int ret;
>> +     struct resource mem_res;
>> +
>> +     si2s = devm_kzalloc(&pdev->dev, sizeof(struct sirf_i2s),
>> +                     GFP_KERNEL);
>> +     if (!si2s)
>> +             return -ENOMEM;
>> +
>> +     si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
>> +                     0, NULL, 0);
>> +     if (IS_ERR(si2s->sirf_pcm_pdev))
>> +             return PTR_ERR(si2s->sirf_pcm_pdev);
>> +
>> +     platform_set_drvdata(pdev, si2s);
>> +
>> +     spin_lock_init(&si2s->lock);
>> +
>> +     ret = of_property_read_u32(pdev->dev.of_node,
>> +                     "sirf,i2s-dma-rx-channel", &rx_dma_ch);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
>> +             return ret;
>> +     }
>> +     ret = of_property_read_u32(pdev->dev.of_node,
>> +                     "sirf,i2s-dma-tx-channel", &tx_dma_ch);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "Unable to USP0 tx dma channel\n");
>> +             return ret;
>> +     }
>> +
>> +     dma_data[0].filter_data = (void *)tx_dma_ch;
>> +     dma_data[1].filter_data = (void *)rx_dma_ch;
>
> This should be using the standard DMA OF bindings. This combind with the
> recent changes to the generic dmaengine PCM driver, which added support for
> querying certain parameters (like max period length) from the dmaengine
> driver, will allow you to completely remove your custom PCM code. You'd
> basically just need to call "snd_dmaengine_pcm_register(&pdev->dev, NULL)"
> here in the I2S driver.
>
> This will require some changes to your dmaengine driver though. You need to
> implement the of_xlate callback for the generic DMA bindings and the
> device_slave_caps API for being able to query the capabilities from the driver.

i am really happy to have that as for clock, gpio, pinctrl, all of
them we have the binding.
here the problem is we can't implement this in this driver as there
are still many drivers depending on the sirf-dma changes.

so our point is keeping the things as is here. and we have another
patchset of dt binding for sirf-dma and all drivers depending sirf-dma
driver.

-barry
