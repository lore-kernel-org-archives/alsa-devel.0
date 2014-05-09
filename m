From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Fri, 9 May 2014 12:34:10 -0300
Message-ID: <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
 <20140509150034.GH2870@dragon> <536CF16F.8010807@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id B1A00261A5A
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 17:34:11 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id lg15so5396459vcb.21
 for <alsa-devel@alsa-project.org>; Fri, 09 May 2014 08:34:10 -0700 (PDT)
In-Reply-To: <536CF16F.8010807@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 9, 2014 at 12:17 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> The changes in the patch should mostly be transparent. But what changed is
> how error reporting is handled. If there is a error reading/writing a
> register in the kcontrol callbacks that error is passed on to userspace
> whereas previously it was silently ignored.
>
> There is also the possibility that there is a bug somewhere in the patch
> causing this.
>
> Does the board otherwise work fine?
>
> I actually have the board here, if you tell me which devictree/defconfig I
> can use with an upstream kernel I can give things a try.

make imx_v6_v7_defconfig
make imx6q-sabresd.dtb

Thanks
