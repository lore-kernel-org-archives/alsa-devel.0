From: Jamey Drennan <jamey.drennan@gmail.com>
Subject: Re: VOIP xrun problem
Date: Mon, 22 Oct 2012 16:56:56 -0400
Message-ID: <CAJqUV39RZ6SB4OQmn5oF61P2=NNxvs9yzPzAtY8fqP7Y1yVjgA@mail.gmail.com>
References: <CAJqUV39Mg8+Cd_ogFGL1vjagwpmBYCC+avWkQaBtPpQz0zZkTg@mail.gmail.com>
 <5085B04E.8040507@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 552B5265261
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 22:56:57 +0200 (CEST)
Received: by mail-vc0-f179.google.com with SMTP id f13so3259114vcb.38
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 13:56:56 -0700 (PDT)
In-Reply-To: <5085B04E.8040507@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Maybe I don't quite understand your question but I use RTP (oRTP library)
to manage the sending/receiving of the audio streams.

On Mon, Oct 22, 2012 at 4:45 PM, Florian Faber <faber@faberman.de> wrote:

> On 10/22/12 22:40, Jamey Drennan wrote:
> > Now in the second phase, events are timed due to specification
> > requirements.  The same Alsa setup code is used yet xruns (mostly
> > underruns) are all over the place.  The underruns are periodic and can be
> > reduced by increasing the period size and number of periods (this also
> > increases the latency obviously and is undersirable) but never removed
> > completely.
> >
> > My question is how to reduce/remove the xruns.
>
> How do you synchronize the streams? You will either have to synchronize
> the media clocks or do some sort of SRC.
>
>
> Flo
> --
> Machines can do the work, so people have time to think.
> public key B3B9226C          x-hkp://wwwkeys.eu.pgp.net
>
