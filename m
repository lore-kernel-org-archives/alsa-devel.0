From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
Date: Sun, 27 Oct 2013 22:41:56 -0500
Message-ID: <CAOZdJXUW5u5Zh561-FHGHfW-fK20L_EeBcdBtSeanWqTfkmndQ@mail.gmail.com>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ADED2608C7
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 04:41:58 +0100 (CET)
Received: from mail-ve0-f177.google.com (mail-ve0-f177.google.com
 [209.85.128.177])
 by muin.pair.com (Postfix) with ESMTPSA id 973F78FC3F
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2013 23:41:56 -0400 (EDT)
Received: by mail-ve0-f177.google.com with SMTP id oz11so4549411veb.22
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2013 20:41:56 -0700 (PDT)
In-Reply-To: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, broonie@kernel.org, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 27, 2013 at 5:37 PM, Barry Song <21cnbao@gmail.com> wrote:
> +       si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
> +                       0, NULL, 0);
> +       if (IS_ERR(si2s->sirf_pcm_pdev))
> +               return PTR_ERR(si2s->sirf_pcm_pdev);
> +
> +       platform_set_drvdata(pdev, si2s);
> +
> +       spin_lock_init(&si2s->lock);
> +
> +       ret = of_property_read_u32(pdev->dev.of_node,
> +                       "sirf,i2s-dma-rx-channel", &rx_dma_ch);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
> +               return ret;
> +       }

Shouldn't you also call platform_device_unregister() before the 'return' here?
