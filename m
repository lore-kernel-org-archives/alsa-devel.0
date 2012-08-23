From: George Stefan <stefan.george87@gmail.com>
Subject: Re: SAIF configuration on imx28
Date: Thu, 23 Aug 2012 09:41:30 +0300
Message-ID: <CAACwSTKkNFw9kC54VJ8en+tWpO9vpnHsszfyDtufWDeWhZCY5Q@mail.gmail.com>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
 <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
 <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
 <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
 <CAOMZO5BGiU7J6W8TSybe8ELqnfLD=SYf9c_uVz6ppb4E2MOnzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 42239265277
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 08:41:31 +0200 (CEST)
Received: by eaa13 with SMTP id 13so78122eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 23:41:31 -0700 (PDT)
In-Reply-To: <CAOMZO5BGiU7J6W8TSybe8ELqnfLD=SYf9c_uVz6ppb4E2MOnzw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

2012/8/23 Fabio Estevam <festevam@gmail.com>

> On Wed, Aug 22, 2012 at 5:25 AM, George Stefan
> <stefan.george87@gmail.com> wrote:
>
> > aplay -l
> >
> > **** List of PLAYBACK Hardware Devices ****
> >
> > card 0: mxsevk [mxs-evk], device 0: cinterion pcm cinterion-0 []
> >
> >   Subdevices: 1/1
> >
> >   Subdevice #0: subdevice #0
> >
> >
> > ~ # arecord -l
> > **** List of CAPTURE Hardware Devices ****
> > card 0: mxsevk [mxs-evk], device 0: cinterion pcm cinterion-0 []
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
>
> Shouldn't this register as pcm cinterion-1 instead?
>
> On mx28evk we have:
>
> root@freescale ~$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
> and we register it as:
>
> static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>         {
>                 .name           = "HiFi Tx",
>                 .stream_name    = "HiFi Playback",
>                 .codec_dai_name = "sgtl5000",
>                 .codec_name     = "sgtl5000.0-000a",
>                 .cpu_dai_name   = "mxs-saif.0",
>                 .platform_name  = "mxs-saif.0",
>                 .ops            = &mxs_sgtl5000_hifi_ops,
>         }, {
>                 .name           = "HiFi Rx",
>                 .stream_name    = "HiFi Capture",
>                 .codec_dai_name = "sgtl5000",
>                 .codec_name     = "sgtl5000.0-000a",
>                 .cpu_dai_name   = "mxs-saif.1",
>                 .platform_name  = "mxs-saif.1",
>                 .ops            = &mxs_sgtl5000_hifi_ops,
>         },
> };
>
> Regards,
>
> Fabio Estevam
>
Hello!
Yes, thats true. I think there is another problem with the receiving of the
clock
from the modem part!

/*set a default freq of 128Hz to cinterion*/
// clk_set_rate(clk, 1280000); /* its slave...it should take the clock from
master */
clk_enable(clk);
/*set the saif clk mux, saif0/saif1 both use saif0 clk*/
__raw_writel(BF_DIGCTL_CTRL_SAIF_CLKMUX_SEL(0x0),               \
IO_ADDRESS(DIGCTL_PHYS_ADDR) + HW_DIGCTL_CTRL);

Using this configuration i am not able to receive IRQs from DMA and i think
the reason
is that SAIF is not receiving the CLK.
What do you think?
Thanks,
George.
