From: Rob Nertney <rob@rob-otics.com>
Subject: arecord: does hardware or software throw away unused
Date: Sun, 18 Sep 2016 19:48:10 -0700
Message-ID: <CALAeOVOR0BZVF+1pQd4=_Q=5N5wboihFaL9jLhC+CyPF9fqvNQ@mail.gmail.com>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
 <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
 <CALAeOVODpXGbY-gRD9_p3_q+=nyi0f6hNqK7e7iGcX9yrn+0pg@mail.gmail.com>
 <d4151ac9-bad3-22eb-90f8-17bdf26b62be@ladisch.de>
 <CALAeOVOdJ1c12PyfbsEfTP3Z=8ZuWXJm_gQASG=vr4cjEDnLQg@mail.gmail.com>
 <485b922c-3ec6-87ac-fccc-023940583a36@ladisch.de>
 <CALAeOVOXDKcJYvc3AJbPUgS29LnZd4xW3LeSFJSWU+FwO8h=Cw@mail.gmail.com>
 <19996f68-0a7b-807b-6519-64720afb1e19@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f182.google.com (mail-yb0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2931826155E
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 04:48:11 +0200 (CEST)
Received: by mail-yb0-f182.google.com with SMTP id i66so74773299yba.0
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 19:48:11 -0700 (PDT)
In-Reply-To: <19996f68-0a7b-807b-6519-64720afb1e19@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I'm building the hardware, so I can technically do whatever I want. I
didn't want to add more to the hardware if ALSA can handle this.

The hardware is spec-ed to *always* have 16 channels worth of data being
written into DDR. I think this comes full-circle to my original question of
whether arecord can filter out channels. It sounds like arecord can handle
multiple channels, but its under the assumption that the hardware itself
changes (in the pcm_open function) to only copy in the requested channels
worth of data; i.e. arecord assumes that the data in dma_area is exactly as
requested by arecord.

If it's -c10 channels worth of data requested, my hardware needs to change
to capture only 10 channels, and throw away the last 6 before it writes it
to DDR. Does that sound right?

Thanks,
Rob

On Fri, Sep 16, 2016 at 12:26 AM, Clemens Ladisch <clemens@ladisch.de>
wrote:

> Rob Nertney wrote:
> > If I define my hw_params like this, is it correct for multiple channels?
> >
> > channels_min = 1
> > channels_max = 16
>
> I don't know what the actual constraints of your hardware are.
>
> > buffer_bytes_max = 32768
> > period_bytes_min = 32768/16
> > period_bytes_max = 32768/16
> > periods_min = 16
> > periods_max = 16
> >
> > Everything is really associated around a 2048 Byte IRQ.
>
> Is that an actual constraint of your hardware?
>
> Anyway, this will not work with, e.g., 15 channels; 60-byte frames do
> not fit into 32768 bytes.
>
>
> Regards,
> Clemens
>
