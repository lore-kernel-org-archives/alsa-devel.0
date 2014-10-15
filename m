From: Nick Stoughton <nstoughton@aether.com>
Subject: Re: [RFC] provide a simple mechanism to start playback
 at a given time
Date: Wed, 15 Oct 2014 14:08:23 +0200
Message-ID: <CADO7NSG3XWmBRKJ2a2HgfsRjZon5k67xQLC08RuD+RVhWPA-GQ@mail.gmail.com>
References: <CADO7NSF=uneov2a9MShswbmpu1P=cwZ1dSkA-jJvoCvxsTFT3A@mail.gmail.com>
 <1413302296.2415261.178874085.6CE8BB88@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id CE33A26040E
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 14:08:24 +0200 (CEST)
Received: by mail-la0-f47.google.com with SMTP id pv20so906961lab.34
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 05:08:24 -0700 (PDT)
In-Reply-To: <1413302296.2415261.178874085.6CE8BB88@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I agree with these points in general. I will change the function to fail
(EINVAL) if the timestamp is in the past, but permit arbitrarily small
future times (which seems preferable to passing in an extra parameter to
something that can easily be checked in user space).

*______________________________*
*Nick Stoughton*
 *Aether Things Inc *
 *San Francisco*
  +1 (510) 388 1413


On Tue, Oct 14, 2014 at 5:58 PM, Tim Cussins <timcussins@eml.cc> wrote:

> Hi Nick,
>
> On Tue, Oct 14, 2014, at 04:31 PM, Nick Stoughton wrote:
> > As discussed at today's meeting, please find 2 patches (one to the 3.17
> > kernel, the other to alsa-lib) following this that implement a simple
> > interface to trigger playback at a given point in the future.
> >
> > The API provides an absolute time, measured against a given clock, at
> > which
> > to trigger DMA. If the point in the future appears to be less than 100ms
> > away, we fall back to the standard snd_pcm_start() behavior. This is
> > because this interface is designed to support networked devices
> > playing back in sync, and network latencies are likely to be over 100ms.
> > This value should probably be tunable ...
>
> I'm a little wary of baked in thresholds like this, esp one in an API
> that isn't explicitly network oriented: In this case it's a policy
> decision that should be left to the application. Maybe pass the
> threshold as an argument?
>
> My general preference is to keep the API contract simple and
> unsurprising. I would just return an error if the request can't be
> satisfied, for example if the timestamp is in the past, or too soon.
> Failure shouldn't be information we hide from the application... :)
>
> > Also, we simply set up a timer and commence DMA when it expires. If the
> > devices to be synchronized have identical hardware, then there is no
> > problem. A future enhancement is to estimate the latency between the DMA
> > trigger and the codec driver (FIFO sizes etc) so that we can take that
> > into
> > account.
> >
> > Any comments gratefully accepted!
> > *______________________________*
> > *Nick Stoughton*
> >  *Aether Things Inc *
> >  *San Francisco*
> >   +1 (510) 388 1413
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
