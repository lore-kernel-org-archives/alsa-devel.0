From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise
 PCM from MSP probe rather than as a device
Date: Thu, 20 Sep 2012 11:03:34 +0200
Message-ID: <505ADBE6.6080509@stericsson.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog102.obsmtp.com (eu1sys200aog102.obsmtp.com
 [207.126.144.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 4269A2652AE
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 11:04:11 +0200 (CEST)
In-Reply-To: <20120919133343.GH25694@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> Hi Ola,

> 
> As requested:
> 
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Tue Jul 31 14:06:19 2012 +0100
> 
>     ASoC: Ux500: Initialise PCM from MSP probe rather than as a device
>     
>     The PCM is a pseudo-device. It doesn't have any of it's own registers
>     or hardware. It rather acts as a layer of abstraction for DMA
>     transfers. Hence, instead of classifying it as a device in its own
>     right, we call the initialisation from the MSP driver.
>     
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
> index 31c4d26..9707f4a 100644
> --- a/sound/soc/ux500/mop500.c
> +++ b/sound/soc/ux500/mop500.c
> @@ -32,7 +32,7 @@ struct snd_soc_dai_link mop500_dai_links[] = {
>  		.stream_name = "ab8500_0",
>  		.cpu_dai_name = "ux500-msp-i2s.1",
>  		.codec_dai_name = "ab8500-codec-dai.0",
> -		.platform_name = "ux500-pcm.0",
> +		.platform_name = "ux500-msp-i2s.1",
>  		.codec_name = "ab8500-codec.0",
>  		.init = mop500_ab8500_machine_init,
>  		.ops = mop500_ab8500_ops,
> @@ -42,7 +42,7 @@ struct snd_soc_dai_link mop500_dai_links[] = {
>  		.stream_name = "ab8500_1",
>  		.cpu_dai_name = "ux500-msp-i2s.3",
>  		.codec_dai_name = "ab8500-codec-dai.1",
> -		.platform_name = "ux500-pcm.0",
> +		.platform_name = "ux500-msp-i2s.3",
>  		.codec_name = "ab8500-codec.0",
>  		.init = NULL,
>  		.ops = mop500_ab8500_ops,
> diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c

>
> Lee Jones - Sept. 19, 2012, 12:29 p.m.
> On Thu, Aug 23, 2012 at 01:59:04PM +0100, Mark Brown wrote:
> > On Thu, Aug 23, 2012 at 01:20:03PM +0100, Lee Jones wrote:
> > > > I say I don't understand the motivation for this change.  All the modern
> > > > DT bindings are perfectly happy handling this without an explicit shim
> > > > in the device tree to bodge things for Linux, adding them in seems like
> > > > it'd be a retrograde step.  What benefit do you believe this brings?
> >
> > > How do the all the other DT:ed audio drivers handle the PCM then? More
> > > importantly, how would you like to see it handled? Ola has NACKed this
> > > patch and explained why:
> >
> > They instantiate the PCM driver dynamically from the DAI when it's
> > probed which is pretty much what you're patch is doing.
>
> Can we have some closure on this patch please, as it's blocking the
> patch-set? I'm fairly sure the patch is doing the correct thing, as
> seconded by Mark.

I still don't like this. It is the dai_link-struct that bothers me. We have
"ux500-msp-i2s.1" as name of the platform AND the cpu_dai. The MSP I2S-block is
not the platform and it is certainly not both platform and cpu-DAI at the same time.
Mark: Did you have a solution for this? Couldn't we just put NULL on the
platform_name instead?
