From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [RFC] provide a simple mechanism to start playback
 at a given time
Date: Tue, 14 Oct 2014 17:58:16 +0200
Message-ID: <1413302296.2415261.178874085.6CE8BB88@webmail.messagingengine.com>
References: <CADO7NSF=uneov2a9MShswbmpu1P=cwZ1dSkA-jJvoCvxsTFT3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 235F226040E
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 17:58:18 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by gateway2.nyi.internal (Postfix) with ESMTP id EF0A3206A5
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 11:58:16 -0400 (EDT)
In-Reply-To: <CADO7NSF=uneov2a9MShswbmpu1P=cwZ1dSkA-jJvoCvxsTFT3A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Nick,

On Tue, Oct 14, 2014, at 04:31 PM, Nick Stoughton wrote:
> As discussed at today's meeting, please find 2 patches (one to the 3.17
> kernel, the other to alsa-lib) following this that implement a simple
> interface to trigger playback at a given point in the future.
> 
> The API provides an absolute time, measured against a given clock, at
> which
> to trigger DMA. If the point in the future appears to be less than 100ms
> away, we fall back to the standard snd_pcm_start() behavior. This is
> because this interface is designed to support networked devices
> playing back in sync, and network latencies are likely to be over 100ms.
> This value should probably be tunable ...

I'm a little wary of baked in thresholds like this, esp one in an API
that isn't explicitly network oriented: In this case it's a policy
decision that should be left to the application. Maybe pass the
threshold as an argument?

My general preference is to keep the API contract simple and
unsurprising. I would just return an error if the request can't be
satisfied, for example if the timestamp is in the past, or too soon.
Failure shouldn't be information we hide from the application... :)

> Also, we simply set up a timer and commence DMA when it expires. If the
> devices to be synchronized have identical hardware, then there is no
> problem. A future enhancement is to estimate the latency between the DMA
> trigger and the codec driver (FIFO sizes etc) so that we can take that
> into
> account.
> 
> Any comments gratefully accepted!
> *______________________________*
> *Nick Stoughton*
>  *Aether Things Inc *
>  *San Francisco*
>   +1 (510) 388 1413
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
