From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: soc-core: add
	snd_soc_add_component()
Date: Thu, 28 Sep 2017 10:37:42 +0300
Message-ID: <CAEnQRZD=ZtdYT_SHDp6R=j2Q8ShkXoJvnUQLc2p=CYPL_ewiuQ@mail.gmail.com>
References: <87k20jvh00.wl%kuninori.morimoto.gx@renesas.com>
 <87h8vnvgxk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B0456266AE1
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 09:37:43 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id i131so675247wma.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 00:37:43 -0700 (PDT)
In-Reply-To: <87h8vnvgxk.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

Minor comment inline

On Thu, Sep 28, 2017 at 2:59 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> ALSA SoC platform/codec will be replaced to component soon.
> But, some function exist in "platform" doesn't exist in "component".
> Current soc-core has snd_soc_register_component(), but
> doesn't have snd_soc_add_component() like snd_soc_add_platform().
> This patch adds it.
>

<snip>

> +int snd_soc_register_component(struct device *dev,
> +                       const struct snd_soc_component_driver *component_driver,
> +                       struct snd_soc_dai_driver *dai_drv,
> +                       int num_dai)
> +{
> +       struct snd_soc_component *component;
> +
> +       component = kzalloc(sizeof(*component), GFP_KERNEL);
> +       if (!component) {
> +               dev_err(dev, "ASoC: Failed to allocate memory\n");
> +               return -ENOMEM;

No need to print an error message if kzalloc fails. The core will print it.

> +       }
> +
> +       return snd_soc_add_component(dev, component, component_driver,
> +                                    dai_drv, num_dai);
> +}
>  EXPORT_SYMBOL_GPL(snd_soc_register_component);


thanks,
Daniel.
