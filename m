From: Chemsi Mehdi <chmsmehdi@gmail.com>
Subject: Re: Alsa Soc details
Date: Tue, 19 Jul 2016 10:02:00 +0200
Message-ID: <CAHkWnPa4Tjxsu=pcqKJXH_+rTVBrb0KPFtMpv+J6rsFkLwJPZQ@mail.gmail.com>
References: <CAHkWnPb+3P6P6qFOVcy=hh6z-v8Ry4FLZnP8qYrZkik10Et3aA@mail.gmail.com>
 <20160719035449.GB9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B90172657B1
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 10:02:01 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id u25so502704qtb.3
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 01:02:01 -0700 (PDT)
In-Reply-To: <20160719035449.GB9681@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Great thanks Vinod for your reactivity.
Always helpful

2016-07-19 5:54 GMT+02:00 Vinod Koul <vinod.koul@intel.com>:

> On Thu, Jul 14, 2016 at 03:07:20PM +0200, Chemsi Mehdi wrote:
> >
> >    Why codec driver of ASOC are always I2C based ?, is codec driver role
> is
> >    only control of audio hardware(set/reset registers only)?
>
> That is not true, there are few SPI based and one i wrote which was a
> different method altogether. Mostly the audio embedded industry uses I2C
> codecs so they are very common
>
> >    There should be three drivers : machine driver, platform driver and
> >    codec driver , all of them have .probe and . remove , what is relation
> >    between all the probes? removes ?
>
> All of these have two probes :)
>
> First one in hardware probe. Nothing unusual here.
> Second is the ASoC probe. Each of these registers a component. The ASoC
> core
> will create the sound card only when all of these components are present.
> At
> that time the ASoC probe in invoked signalling card creation to driver
>
>
> >    As far I know McBSP is source of audio coming from host and I2C/ McBSP
> >    have no direct relation so why we connect platform driver (McBSP) with
> >    codec driver(I2C) Via DAI ?
>
> You will have to ask driver authors that, pls cc them
>
>
> >    When calling snd_pcm_open from userspace which kernel API is called ?
> >    snd_pcm_lib_ioctl or  snd_stm_spdif_player_open ? if
> >    snd_stm_spdif_player_open so when called snd_pcm_lib_ioctl ?
>
> system call open()
>
> >    How ALSA KERNELAPI is connected to ALSA SOC CORE, via which
> >    calls/mechanism ?
>
> The alsa provides driver callbacks. See struct snd_pcm_ops. ASoC provides
> the same to asoc driver as well! Additionally we have dai_ops as well.
>
> ASoC has its own ops for card and then it invokes platform, codec pcm and
> dai_ops. See sound/soc/soc-pcm.c
>
> --
> ~Vinod
>
