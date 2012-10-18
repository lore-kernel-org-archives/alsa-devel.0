From: Prasant J <pj0585@gmail.com>
Subject: Re: ASoC: mmap or read/write?
Date: Thu, 18 Oct 2012 15:07:45 +0530
Message-ID: <CAA2DH4v4DUxf5Qh79nehTPD+22v6XddzDrEMmnBu2eM8m4JXzg@mail.gmail.com>
References: <CAA2DH4uhwV0NmxEbLKN=m+VC9ruOHM13Vpu1m33j0DNm+n6yKQ@mail.gmail.com>
 <507FC752.1050005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 18B5D2625FC
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 11:37:46 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id c1so5263308lbg.38
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 02:37:45 -0700 (PDT)
In-Reply-To: <507FC752.1050005@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 18, 2012 at 2:39 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Prasant J wrote:
>> I'm writing an alsa application for recording & playing 16 channel audio.
>>
>> The application is intended to run on an embedded platform & the
>> resources are highly constrained.
>
> Then I wonder how you manage to handle 16 channels.
> What hardware is this?

I'm working with Beaglebone (ARM Cortex-A8 720 MHz). (Currently
failures are for 8 channels 32 bit / 16 bit, but our final target is
16 channels)

>
>> My application is not performing well with read/write methods.
>
> How much CPU usage?

The CPU usage is around 35% (as seen in top)

I have managed to get Audio capture working fine (after certain linux
optimizations) but playback is giving under-runs (only when PLAYBACK &
CAPTURE run together)
I was wondering that changing access method to mmap (currently I'm
using read/write) may give me some more CPU time.


>
>> Does the mmap method has any advantages over read/write?
>
> No, except when then samples are generated in/consumed from the
> device's buffer directly without copying them around, and even then
> it's unlikely that the time needed for copying actually matters.
>
>> Is there any thumb rule to decide when to use mmap or read/write?
>
> Yes; use read/write.

OK. You say read/write is the best apart from the one use case you
mentioned, makes sense, because, irrespective I use read/write or
mmap, in my case, I will anyway have to copy the buffers to mmap-ed
area.

>
>
> Regards,
> Clemens


Thanks for inputs!

Regards, Prasant
