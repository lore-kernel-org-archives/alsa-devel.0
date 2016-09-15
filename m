From: Rob Nertney <rob@rob-otics.com>
Subject: Re: arecord: does hardware or software throw away
	unused
Date: Thu, 15 Sep 2016 12:57:14 -0700
Message-ID: <CALAeOVOXDKcJYvc3AJbPUgS29LnZd4xW3LeSFJSWU+FwO8h=Cw@mail.gmail.com>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
 <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
 <CALAeOVODpXGbY-gRD9_p3_q+=nyi0f6hNqK7e7iGcX9yrn+0pg@mail.gmail.com>
 <d4151ac9-bad3-22eb-90f8-17bdf26b62be@ladisch.de>
 <CALAeOVOdJ1c12PyfbsEfTP3Z=8ZuWXJm_gQASG=vr4cjEDnLQg@mail.gmail.com>
 <485b922c-3ec6-87ac-fccc-023940583a36@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
 [209.85.161.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 096EE266F16
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 21:57:16 +0200 (CEST)
Received: by mail-yw0-f175.google.com with SMTP id i129so72995083ywb.0
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 12:57:16 -0700 (PDT)
In-Reply-To: <485b922c-3ec6-87ac-fccc-023940583a36@ladisch.de>
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

So right now my buffer is 32768, and I am filling the dma_area, firing an
IRQ every 2048 Bytes, which aligns to 32 frames of 32b, 16ch data @ 16khz.
When I don't specify a lower number of channels, it works as expected (at
least the capture sounds correct). Less than 16, the capture goes too fast.
If I define my hw_params like this, is it correct for multiple channels?

channels_min = 1
channels_max = 16
buffer_bytes_max = 32768
period_bytes_min = 32768/16
period_bytes_max = 32768/16
periods_min = 16
periods_max = 16

Everything is really associated around a 2048 Byte IRQ. The IRQ handler is
simply snd_pcm_period_elapsed (again, called every BUF/16, or 2048 bytes);
the pointer callback is the number of frames (as you mentioned, based upon
max_channels) currently copied into dma_area. I can't identify where the
speedup would come from when i specify lesser channels

Thanks,
Rob


On Wed, Sep 14, 2016 at 3:29 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rob Nertney wrote:
> > "Returned in frames". Does this mean returned in MAX_CHANNELS frames?
>
> One frames contains all channels.  The number of channels was set with
> the hw_params callback, and will never be outside the constraints that
> your driver has provided.
>
>
> Regards,
> Clemens
>
