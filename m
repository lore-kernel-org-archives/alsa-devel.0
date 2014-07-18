From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASOC: support for Allwinner on-chip codec
Date: Thu, 17 Jul 2014 21:21:18 -0400
Message-ID: <CAKON4OyBY4jpNsJLAw0t83HiSgg2gCxsQw52Kva+phC+Ah0NjA@mail.gmail.com>
References: <CAKON4Ox19bhm47RG-phyzXkdKq3fuW8yQ4b0E6Rvhg0jDPuuyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id F2DA92655A0
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 03:21:18 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id n15so2325918lbi.4
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 18:21:18 -0700 (PDT)
In-Reply-To: <CAKON4Ox19bhm47RG-phyzXkdKq3fuW8yQ4b0E6Rvhg0jDPuuyQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 17, 2014 at 10:18 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> We have the first pass of the ASOC driver for the Allwinner on-chip
> codec making some noise that makes sense.  Code is here...
> https://github.com/jonsmirl/lpc31xx/blob/codec/sound/soc/sunxi/sunxi-codec.c
>
> Something isn't right in the channel assignments. If I play a mono
> clip I hear it. If I play a stereo clip I get silence. If I use
> speaker-test to play eight channels, I hear Center and Side Right
> channels.  Not Front left/right as expected. Device only does stereo.

We have tracked this down to something being wrong in the Linaro rootfs builds.
This one from 6/23 fails:
https://releases.linaro.org/latest/ubuntu/trusty-images/developer

Rootfs from buildroot or debian work.

Maybe Linaro is broken or this SOC driver is sending the wrong info up
to libasound on Linaro.

>
> If anyone wants to do a first pass code review I can start making the
> needed changes.
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
