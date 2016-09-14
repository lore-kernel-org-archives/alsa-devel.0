From: Rob Nertney <rob@rob-otics.com>
Subject: Re: arecord: does hardware or software throw away
	unused
Date: Tue, 13 Sep 2016 18:40:50 -0700
Message-ID: <CALAeOVOdJ1c12PyfbsEfTP3Z=8ZuWXJm_gQASG=vr4cjEDnLQg@mail.gmail.com>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
 <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
 <CALAeOVODpXGbY-gRD9_p3_q+=nyi0f6hNqK7e7iGcX9yrn+0pg@mail.gmail.com>
 <d4151ac9-bad3-22eb-90f8-17bdf26b62be@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 by alsa0.perex.cz (Postfix) with ESMTP id BB8BC2610A6
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 03:40:54 +0200 (CEST)
Received: by mail-yw0-f169.google.com with SMTP id i129so4203761ywb.0
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 18:40:54 -0700 (PDT)
In-Reply-To: <d4151ac9-bad3-22eb-90f8-17bdf26b62be@ladisch.de>
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

So the arecord (and aplay for this matter)'s pointer callback? The writing
ALSA driver user guide says


*This callback is called when the PCM middle layer inquires the current
hardware position on the buffer. The position must be returned in frames,
ranging from 0 to buffer_size - 1. This is called usually from the
buffer-update routine in the pcm middle layer, which is invoked when
snd_pcm_period_elapsed() is called in the interrupt routine. Then the pcm
middle layer updates the position and calculates the available space, and
wakes up the sleeping poll threads, etc.*

"Returned in frames". Does this mean returned in MAX_CHANNELS frames?

On Fri, Sep 2, 2016 at 12:09 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rob Nertney wrote:
> > I just changed my channels to half of MAX_CHANNELS, and when i play the
> resulting WAV file, my voice is super slow (50% slower, I'd wager)
>
> This sounds like a bug in your driver.
>
>
> Regards,
> Clemens
>
