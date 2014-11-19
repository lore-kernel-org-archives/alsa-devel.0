From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: wm8960: Add shared_lrclk and capless
 to device tree
Date: Wed, 19 Nov 2014 10:59:51 -0200
Message-ID: <CAOMZO5DuJpEPALw60yC3kxEbdE_-fAbUG-3L+hZ+Oo1bd=0Kew@mail.gmail.com>
References: <1416400568-7512-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 65BFA2604FA
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 13:59:54 +0100 (CET)
Received: by mail-lb0-f172.google.com with SMTP id u10so434877lbd.17
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 04:59:52 -0800 (PST)
In-Reply-To: <1416400568-7512-1-git-send-email-b50113@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <b50113@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Xiubo Li <Li.Xiubo@freescale.com>, patches@opensource.wolfsonmicro.com, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 19, 2014 at 10:36 AM, Zidan Wang <b50113@freescale.com> wrote:
> wm8960 codec has a wm8960_data struct which has two fields shared_lrclk and capless.
> The wm8960_data is get from platform_data and it is reasonable to set it from device
> tree when platform_data is null.
> And when shared_lrclk is set, LRCM will be enabled. But the following software reset
> in wm8960_probe will reset it to the default state. So LRCM operation should after
> software reset.
>
> Signed-off-by: Zidan Wang <b50113@freescale.com>
> ---
>  sound/soc/codecs/wm8960.c | 49 ++++++++++++++++++++++++++++++-----------------

I think you could a add
Documentation/devicetree/bindings/sound/wm8960.txt in a separate patch
and document these properties there.
