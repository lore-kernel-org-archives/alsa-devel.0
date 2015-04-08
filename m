From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Wed, 8 Apr 2015 17:35:50 -0300
Message-ID: <CAOMZO5AxT9dgE=QaH18FUYD5CbMvn67XpMo4dH6T0v9Qen-RRg@mail.gmail.com>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
 <55258272.2010205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 189462605AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 22:35:51 +0200 (CEST)
Received: by laat2 with SMTP id t2so67934328laa.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 13:35:50 -0700 (PDT)
In-Reply-To: <55258272.2010205@metafoo.de>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 8, 2015 at 4:33 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> Does the card name contain a '/' like in 'S/PDIF'?

Yes, it does. I also tried to change it like this:

--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -37,8 +37,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
                goto end;
        }

-       data->dai.name = "S/PDIF PCM";
-       data->dai.stream_name = "S/PDIF PCM";
+       data->dai.name = "SPDIF PCM";
+       data->dai.stream_name = "SPDIF PCM";
        data->dai.codec_dai_name = "snd-soc-dummy-dai";
        data->dai.codec_name = "snd-soc-dummy";
        data->dai.cpu_of_node = spdif_np;

,but I still get the warning.

Thanks,

Fabio Estevam
