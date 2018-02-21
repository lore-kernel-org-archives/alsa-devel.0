From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Wed, 21 Feb 2018 10:43:27 -0300
Message-ID: <CAOMZO5DZ0W5q6OAvrRWv+8GNbWn5ttLk3q035H=4fLton-1mgg@mail.gmail.com>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
 <5b591fd8-d4d5-27bb-0850-a376da20d7f3@metafoo.de>
 <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
 <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
 <CAOMZO5CA99p+2DYrbWQnLzh5Lj8syX4j18V8R8WPV2KDZz-DVQ@mail.gmail.com>
 <20180221130241.GI8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FCC267530
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 14:43:29 +0100 (CET)
Received: by mail-oi0-f53.google.com with SMTP id 24so1129302oij.3
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 05:43:29 -0800 (PST)
In-Reply-To: <20180221130241.GI8334@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Feb 21, 2018 at 10:02 AM, Mark Brown <broonie@kernel.org> wrote:

> It's a legit warning - we shouldn't really be creating two components
> for the same device.  However this is a bit of a corner case as it's the
> dmaengine platform driver which is kind of a virtual device, it's not
> really the device that we use with DMA that's being represented but
> rather the link between that and the DMA controller.
>
> Does the below patch (completely untested) help here?  It adds a prefix
> to the name for deduplication.
>
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index d53786498b61..d5a6eea64036 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -431,6 +431,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>         if (!pcm)
>                 return -ENOMEM;
>
> +       pcm->platform.component.name_prefix = "dma";

Had to change it to pcm->component.name_prefix = "dma"; but still see
the warnings.

Here are the suggested change plus some additional debug lines:

--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -303,6 +303,8 @@ static void soc_init_component_debugfs(struct
snd_soc_component *component)
        if (!component->card->debugfs_card_root)
                return;

+       pr_err("************** component name is %s\n", component->name);
+
        if (component->debugfs_prefix) {
                char *name;

@@ -318,6 +320,12 @@ static void soc_init_component_debugfs(struct
snd_soc_component *component)
                                component->card->debugfs_card_root);
        }

+       if (component->debugfs_root) {
+               dev_warn(component->dev,
+                       "ASoC: Succeded to create component debugfs
directory\n");
+               return;
+       }
+
        if (!component->debugfs_root) {
                dev_warn(component->dev,
                        "ASoC: Failed to create component debugfs directory\n");
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c
b/sound/soc/soc-generic-dmaengine-pcm.c
index c07d5c7..16995dd 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -442,6 +442,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
        if (!pcm)
                return -ENOMEM;

+       pcm->component.name_prefix = "dma";
        pcm->config = config;
        pcm->flags = flags;

and the log looks like this:

[    2.062294] sgtl5000 1-000a: sgtl5000 revision 0x11
[    2.069367] sgtl5000 1-000a: Using internal LDO instead of VDDD:
check ER1 erratum
[    2.113827] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    2.123954] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    2.326451] [drm] Cannot find any crtc or sizes
[    2.501744] ************** component name is 2028000.ssi
[    2.507217] fsl-ssi-dai 2028000.ssi: ASoC: Succeded to create
component debugfs directory
[    2.515429] ************** component name is sgtl5000.1-000a
[    2.521194] sgtl5000 1-000a: ASoC: Succeded to create component
debugfs directory
[    2.544264] ************** component name is 2028000.ssi
[    2.549879] fsl-ssi-dai 2028000.ssi: ASoC: Failed to create
component debugfs directory
[    2.565605] imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
[    2.584074] ************** component name is 2004000.spdif
[    2.589721] fsl-spdif-dai 2004000.spdif: ASoC: Succeded to create
component debugfs directory
[    2.598437] ************** component name is 2004000.spdif
[    2.603978] fsl-spdif-dai 2004000.spdif: ASoC: Failed to create
component debugfs directory
[    2.616340] imx-spdif sound-spdif: snd-soc-dummy-dai <->
2004000.spdif mapping ok

Looks like the 'dma' prefix did not take effect, as we are still
trying to register the same name twice.

Thanks
