From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 18:37:19 +0000
Message-ID: <2bf70c96-1ecc-50b5-b936-7372c4b23276@linaro.org>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
 [209.85.128.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E42B267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 19:37:22 +0100 (CET)
Received: by mail-wr0-f180.google.com with SMTP id m5so17220787wrg.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:37:22 -0800 (PST)
In-Reply-To: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 19/02/18 18:49, Fabio Estevam wrote:
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
> 
> Any ideas?

I hit something similar while testing some of the qcom sound card.

This patch fixed the issue for me:

 
https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=v4.16-rc1-dsp-audio-v3&id=b91fa95c38912dd8a9f56ebdb9b59449252798ef

Its basically to do with nested device tree nodes, the device name seems 
to exceed the NAME_SIZE of 32 bytes.


thanks,
srini
> 
> Thanks
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
