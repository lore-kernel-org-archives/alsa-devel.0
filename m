From: Rob Nertney <rob@rob-otics.com>
Subject: Re: arecord: does hardware or software throw away
	unused
Date: Fri, 2 Sep 2016 00:05:32 -0700
Message-ID: <CALAeOVODpXGbY-gRD9_p3_q+=nyi0f6hNqK7e7iGcX9yrn+0pg@mail.gmail.com>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
 <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EEE226724D
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 09:05:34 +0200 (CEST)
Received: by mail-ua0-f176.google.com with SMTP id i32so170460019uai.2
 for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2016 00:05:34 -0700 (PDT)
In-Reply-To: <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
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

Thanks for the quick reply.

I just changed my channels to half of MAX_CHANNELS, and when i play the
resulting WAV file, my voice is super slow (50% slower, I'd wager) I
ensured my MAX_PERIODS went up with a decrease in channels, but I can't
tell what would cause the effect. Any thoughts?

On Fri, Sep 2, 2016 at 12:01 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rob Nertney wrote:
> > My hardware is putting a stream of MAX_CHANNELS into memory, and firing
> the
> > IRQs on my period boundary with respect to this full MAX_CHANNELS stream.
> > [...]
> > will arecord see the MAX_CHANNELS in my driver, and use its *software*
> > to strip out the upper channels worth of data automatically for me?
>
> Yes.
>
>
> Regards,
> Clemens
>
