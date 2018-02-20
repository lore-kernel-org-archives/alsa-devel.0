From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 11:18:22 -0300
Message-ID: <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EB8B267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 15:18:23 +0100 (CET)
Received: by mail-oi0-f42.google.com with SMTP id c12so2743911oic.7
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 06:18:23 -0800 (PST)
In-Reply-To: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
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

On Mon, Feb 19, 2018 at 3:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> On linux-next I see the following errors on imx6 wandboard:
>
> [    3.040897] fsl-ssi-dai 2028000.ssi: ASoC: Failed to create
> component debugfs directory
> [    3.065722] fsl-spdif-dai 2004000.spdif: ASoC: Failed to create
> component debugfs directory
>
> I haven't started debugging this yet and not sure if this is something
> fsl driver specific.

This is not fsl sound specific as I see the same warnings in
kernelci.org boot logs with other SoCs.

The failures happens because we are trying to create debugfs twice:

[    2.122894] mmc1: new SDIO card at address 0001
[    2.150560] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    2.160601] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    2.326140] [drm] Cannot find any crtc or sizes
[    2.538048] ******** component name is 2028000.ssi
[    2.542911] fsl-ssi-dai 2028000.ssi: ASoC: Succeeded in creating
component debugfs directory
[    2.551513] ******** component name is sgtl5000.1-000a
[    2.556761] sgtl5000 1-000a: ASoC: Succeeded in creating component
debugfs directory
[    2.580521] ******** component name is 2028000.ssi
[    2.585552] fsl-ssi-dai 2028000.ssi: ASoC: Failed to create
component debugfs directory
[    2.601344] imx-sgtl5000 sound: sgtl5000 <-> 2028000.ssi mapping ok
[    2.620625] ******** component name is 2004000.spdif
[    2.625867] fsl-spdif-dai 2004000.spdif: ASoC: Succeeded in
creating component debugfs directory
[    2.634754] ******** component name is 2004000.spdif
[    2.639850] fsl-spdif-dai 2004000.spdif: ASoC: Failed to create
component debugfs directory
[    2.652127] imx-spdif sound-spdif: snd-soc-dummy-dai <->
2004000.spdif mapping ok

Any ideas why this second debugfs registration is being attempted?
