From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 9/9] ASoC: add audio-graph-card support
Date: Mon, 20 Mar 2017 15:32:24 -0500
Message-ID: <CAL_JsqJFNnBUDN4AjseZN4zWh1dH30c1ay=0sYAnY3-6td0LSg@mail.gmail.com>
References: <8760jdivfm.wl%kuninori.morimoto.gx@renesas.com>
 <87shmhhghc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9E12668F6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 21:32:51 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id AA6B120386
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 20:32:48 +0000 (UTC)
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
 [209.85.161.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF38C20361
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 20:32:45 +0000 (UTC)
Received: by mail-yw0-f177.google.com with SMTP id o4so98108987ywd.3
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 13:32:45 -0700 (PDT)
In-Reply-To: <87shmhhghc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2017 at 12:54 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> OF-graph base DT binding are used on V4L2, and ALSA SoC is using
> different style of DT today. Now ALSA SoC supports simple-card driver
> for generic/simple sound card.
> In the future, V4L2 / ALSA will support HDMI, and then, DT bindings
> between V4L2 / ALSA should be merged.
> This patch adds new Audio Graph Card which is OF-graph base of
> simple-card
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
>
>  - use "label"
>  - use "dai-format"
>  - don't use prefix
>
>  sound/soc/generic/Kconfig            |   8 +
>  sound/soc/generic/Makefile           |   2 +
>  sound/soc/generic/audio-graph-card.c | 301 +++++++++++++++++++++++++++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 sound/soc/generic/audio-graph-card.c
>
> diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
> index d023959..121a48e 100644
> --- a/sound/soc/generic/Kconfig
> +++ b/sound/soc/generic/Kconfig
> @@ -14,3 +14,11 @@ config SND_SIMPLE_SCU_CARD
>         help
>           This option enables generic simple SCU sound card support.
>           It supports DPCM of multi CPU single Codec system.
> +
> +config SND_AUDIO_GRAPH_CARD
> +       tristate "ASoC Audio Graph sound card support"
> +       depends on OF
> +       select SND_SIMPLE_CARD_UTILS
> +       help
> +         This option enables generic simple simple sound card support
> +         with OF-graph DT bindings.
> diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
> index ee750f3..670068f 100644
> --- a/sound/soc/generic/Makefile
> +++ b/sound/soc/generic/Makefile
> @@ -1,7 +1,9 @@
>  snd-soc-simple-card-utils-objs := simple-card-utils.o
>  snd-soc-simple-card-objs       := simple-card.o
>  snd-soc-simple-scu-card-objs   := simple-scu-card.o
> +snd-soc-audio-graph-card-objs  := audio-graph-card.o
>
>  obj-$(CONFIG_SND_SIMPLE_CARD_UTILS)    += snd-soc-simple-card-utils.o
>  obj-$(CONFIG_SND_SIMPLE_CARD)          += snd-soc-simple-card.o
>  obj-$(CONFIG_SND_SIMPLE_SCU_CARD)      += snd-soc-simple-scu-card.o
> +obj-$(CONFIG_SND_AUDIO_GRAPH_CARD)     += snd-soc-audio-graph-card.o
> diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
> new file mode 100644
> index 0000000..07afdfa
> --- /dev/null
> +++ b/sound/soc/generic/audio-graph-card.c
> @@ -0,0 +1,301 @@
> +/*
> + * ASoC audio graph sound card support
> + *
> + * Copyright (C) 2016 Renesas Solutions Corp.
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * based on ${LINUX}/sound/soc/generic/simple-card.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <sound/jack.h>
> +#include <sound/simple_card_utils.h>
> +
> +struct graph_card_data {
> +       struct snd_soc_card snd_card;
> +       struct graph_dai_props {
> +               struct asoc_simple_dai cpu_dai;
> +               struct asoc_simple_dai codec_dai;
> +       } *dai_props;
> +       struct snd_soc_dai_link *dai_link;
> +};
> +
> +#define graph_priv_to_dev(priv) ((priv)->snd_card.dev)
> +#define graph_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
> +#define graph_priv_to_props(priv, i) ((priv)->dai_props + (i))
> +
> +static int asoc_graph_card_startup(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct graph_card_data *priv =  snd_soc_card_get_drvdata(rtd->card);
> +       struct graph_dai_props *dai_props =
> +               graph_priv_to_props(priv, rtd->num);
> +       int ret;
> +
> +       ret = clk_prepare_enable(dai_props->cpu_dai.clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(dai_props->codec_dai.clk);
> +       if (ret)
> +               clk_disable_unprepare(dai_props->cpu_dai.clk);
> +
> +       return ret;
> +}
> +
> +static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct graph_card_data *priv =  snd_soc_card_get_drvdata(rtd->card);
> +       struct graph_dai_props *dai_props =
> +               graph_priv_to_props(priv, rtd->num);
> +
> +       clk_disable_unprepare(dai_props->cpu_dai.clk);
> +
> +       clk_disable_unprepare(dai_props->codec_dai.clk);
> +}
> +
> +static struct snd_soc_ops asoc_graph_card_ops = {
> +       .startup = asoc_graph_card_startup,
> +       .shutdown = asoc_graph_card_shutdown,
> +};
> +
> +static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct graph_card_data *priv =  snd_soc_card_get_drvdata(rtd->card);
> +       struct snd_soc_dai *codec = rtd->codec_dai;
> +       struct snd_soc_dai *cpu = rtd->cpu_dai;
> +       struct graph_dai_props *dai_props =
> +               graph_priv_to_props(priv, rtd->num);
> +       int ret;
> +
> +       ret = asoc_simple_card_init_dai(codec, &dai_props->codec_dai);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = asoc_simple_card_init_dai(cpu, &dai_props->cpu_dai);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
> +                                       struct graph_card_data *priv,
> +                                       int idx)
> +{
> +       struct device *dev = graph_priv_to_dev(priv);
> +       struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, idx);
> +       struct graph_dai_props *dai_props = graph_priv_to_props(priv, idx);
> +       struct asoc_simple_dai *cpu_dai = &dai_props->cpu_dai;
> +       struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
> +       struct device_node *cpu_ep    = of_get_next_child(cpu_port, NULL);
> +       struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
> +       struct device_node *rcpu_ep = of_graph_get_remote_endpoint(codec_ep);
> +       int ret;
> +
> +       if (rcpu_ep != cpu_ep) {
> +               dev_err(dev, "remote-endpoint missmatch (%s/%s/%s)\n",
> +                       cpu_ep->name, codec_ep->name, rcpu_ep->name);
> +               return -EINVAL;
> +       }

We should have this check in dtc rather than the kernel.

> +
> +       ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
> +                                           NULL, &dai_link->dai_fmt);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       /*
> +        * we need to consider "mclk-fs" around here
> +        * see simple-card
> +        */
> +
> +       ret = asoc_simple_card_parse_graph_cpu(cpu_ep, dai_link);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = asoc_simple_card_parse_graph_codec(codec_ep, dai_link);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = snd_soc_of_parse_tdm_slot(cpu_ep,
> +                                       &cpu_dai->tx_slot_mask,
> +                                       &cpu_dai->rx_slot_mask,
> +                                       &cpu_dai->slots,
> +                                       &cpu_dai->slot_width);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = snd_soc_of_parse_tdm_slot(codec_ep,
> +                                       &codec_dai->tx_slot_mask,
> +                                       &codec_dai->rx_slot_mask,
> +                                       &codec_dai->slots,
> +                                       &codec_dai->slot_width);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = asoc_simple_card_parse_clk_cpu(dev, cpu_ep, dai_link, cpu_dai);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = asoc_simple_card_parse_clk_codec(dev, codec_ep, dai_link, codec_dai);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = asoc_simple_card_canonicalize_dailink(dai_link);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       ret = asoc_simple_card_set_dailink_name(dev, dai_link,
> +                                               "%s-%s",
> +                                               dai_link->cpu_dai_name,
> +                                               dai_link->codec_dai_name);
> +       if (ret < 0)
> +               goto dai_link_of_err;
> +
> +       dai_link->ops = &asoc_graph_card_ops;
> +       dai_link->init = asoc_graph_card_dai_init;
> +
> +       dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
> +       dev_dbg(dev, "\tformat : %04x\n", dai_link->dai_fmt);
> +       dev_dbg(dev, "\tcpu : %s / %d\n",
> +               dai_link->cpu_dai_name,
> +               dai_props->cpu_dai.sysclk);
> +       dev_dbg(dev, "\tcodec : %s / %d\n",
> +               dai_link->codec_dai_name,
> +               dai_props->codec_dai.sysclk);
> +
> +       asoc_simple_card_canonicalize_cpu(dai_link,
> +                                         priv->snd_card.num_links == 1);
> +
> +dai_link_of_err:
> +       of_node_put(codec_ep);
> +
> +       return ret;
> +}
> +
> +static int asoc_graph_card_parse_of(struct device *dev,
> +                                    struct graph_card_data *priv)
> +{
> +       struct device_node *node = dev->of_node;
> +       struct snd_soc_card *card = &priv->snd_card;
> +       struct device_node *np;
> +       int idx = 0;
> +       int ret;
> +
> +       /*
> +        * we need to consider "widgets", "routing", "mclk-fs" around here
> +        * see simple-card
> +        */
> +
> +       while ((np = of_parse_phandle(node, "dais", idx))) {

of_for_each_phandle

> +               ret = asoc_graph_card_dai_link_of(np, priv, idx++);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return asoc_simple_card_parse_card_name(card, NULL);
> +}
> +
> +static int asoc_graph_get_dais_count(struct device *dev)
> +{
> +       struct device_node *node = dev->of_node;
> +       int count = 0;
> +
> +       if (of_get_property(node, "dais", NULL)) {
> +               while (of_parse_phandle(node, "dais", count))

of_for_each_phandle

> +                       count++;
> +       } else {
> +               count = 1;

This should be an error or 0, right?

> +       }
> +
> +       return count;
> +}
> +
> +static int asoc_graph_card_probe(struct platform_device *pdev)
> +{
> +       struct graph_card_data *priv;
> +       struct snd_soc_dai_link *dai_link;
> +       struct graph_dai_props *dai_props;
> +       struct device *dev = &pdev->dev;
> +       int num, ret;
> +
> +       /* Allocate the private data and the DAI link array */
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       num = asoc_graph_get_dais_count(dev);
> +
> +       dai_props = devm_kzalloc(dev, sizeof(*dai_props) * num, GFP_KERNEL);
> +       dai_link  = devm_kzalloc(dev, sizeof(*dai_link)  * num, GFP_KERNEL);
> +       if (!dai_props || !dai_link)
> +               return -ENOMEM;
> +
> +       priv->dai_props                 = dai_props;
> +       priv->dai_link                  = dai_link;
> +
> +       /* Init snd_soc_card */
> +       priv->snd_card.owner            = THIS_MODULE;
> +       priv->snd_card.dev              = dev;
> +       priv->snd_card.dai_link         = dai_link;
> +       priv->snd_card.num_links        = num;
> +
> +       ret = asoc_graph_card_parse_of(dev, priv);
> +       if (ret < 0) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "parse error %d\n", ret);
> +               goto err;
> +       }
> +
> +       snd_soc_card_set_drvdata(&priv->snd_card, priv);
> +
> +       ret = devm_snd_soc_register_card(dev, &priv->snd_card);
> +       if (ret >= 0)
> +               return ret;
> +err:
> +       asoc_simple_card_clean_reference(&priv->snd_card);
> +
> +       return ret;
> +}
> +
> +static int asoc_graph_card_remove(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card = platform_get_drvdata(pdev);
> +       struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
> +
> +       return asoc_simple_card_clean_reference(&priv->snd_card);
> +}
> +
> +static const struct of_device_id asoc_graph_of_match[] = {
> +       { .compatible = "audio-graph-card", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, asoc_graph_of_match);
> +
> +static struct platform_driver asoc_graph_card = {
> +       .driver = {
> +               .name = "asoc-audio-graph-card",
> +               .of_match_table = asoc_graph_of_match,
> +       },
> +       .probe = asoc_graph_card_probe,
> +       .remove = asoc_graph_card_remove,
> +};
> +module_platform_driver(asoc_graph_card);
> +
> +MODULE_ALIAS("platform:asoc-audio-graph-card");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ASoC Audio Graph Sound Card");
> +MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
> --
> 1.9.1
>
