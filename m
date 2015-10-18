From: Caleb Crome <caleb@crome.org>
Subject: Re: audio-over-SPI driver for ASoC
Date: Sun, 18 Oct 2015 07:03:11 -0700
Message-ID: <CAG5mAdxrNhfNe4tdWDYY82QcLhi33b9srTez+UVFGkF5JfAuwA@mail.gmail.com>
References: <5617CF54.7090508@orthogonaldevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D3AB2616EF
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 16:03:31 +0200 (CEST)
Received: by wicfv8 with SMTP id fv8so45154520wic.0
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 07:03:31 -0700 (PDT)
In-Reply-To: <5617CF54.7090508@orthogonaldevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Clarkson <clarkson@orthogonaldevices.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Brian,
   I've been thinking of doing something sort of similar, but perhaps
different.  It looks like you plan to go I2S/TDM into the McSPI, correct?
I've done this with a microcontroller before, which works mostly.  The
problem is that since the SPI port doesn't know about the frame sync
signal, any ESD strike that comes along provides an extra clock, and your
entire bit-stream gets out of sync.  So, as long as you can protect from
ESD well, it will work at the hardware level.

I've been thinking about using an interposer microcontroller that will
convert I2S to a packetized SPI protocol, so I can have any number of codec
channels, up to the limit of the SPI speed.  I'm not sure how it will all
work though (you can see my previous email on the subject).

Anyway, I'm definitely interested to hear how things are progressing.

-Caleb


On Fri, Oct 9, 2015 at 7:29 AM, Brian Clarkson <
clarkson@orthogonaldevices.com> wrote:

> Hi
>
> I'm about to embark on the development of an ASoC capture driver that uses
> SPI to stream the samples to the processor.  I'm still spending a lot of my
> time going through the ALSA kernel code but as I do that may I have some
> suggestions as to which examples would be closest to my case?  My
> development hardware is AM335x --> McSPI --> ADS8868.
>
> So far I think I have achieved a solid understanding of the "simple-card"
> case where you have dai-link that connects a processor peripheral driver
> (e.g. McASP ) with a codec driver and forms a snd_soc_card that can be
> registered.  Is my best option to:
>
> - write a new CPU DAI (snd_soc_dai_driver) based on the existing SPI driver
> - write a new CODEC DAI (snd_soc_dai_driver) which will be mostly empty
> - write a new platform driver that populates and registers a new
> snd_soc_card struct with the above in a dai_link?
>
> Any advice would be much appreciated.
>
> Cheers,
> Brian
>
> --
> Orthogonal Devices
> Tokyo, Japan
> www.orthogonaldevices.com
> +81 80 8700 2340
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
