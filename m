From: Rob Janssen <pe1chl@amsat.org>
Subject: Re: Control the exact moment of output
Date: Wed, 30 Apr 2014 10:11:28 +0200
Message-ID: <5360B030.7010805@amsat.org>
References: <5352BEA0.3050807@amsat.org> <535F59DD.2080207@ladisch.de>
 <535F61EC.9070003@amsat.org>
 <51940.86.107.254.57.1398840206.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pe1chl.nl.eu.org (pe1chl.nl.eu.org [89.18.172.156])
 by alsa0.perex.cz (Postfix) with ESMTP id D85BE2651CB
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 10:11:32 +0200 (CEST)
Received: from linux.pe1chl.ampr.org (linux.pe1chl.ampr.org [44.137.41.97])
 by sys2.pe1chl.ampr.org (8.14.4/8.14.4/Debian-4) with ESMTP id s3U8BVJV031596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 10:11:32 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by linux.pe1chl.ampr.org (8.14.7/8.14.7) with ESMTP id s3U8BS2d030141
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 10:11:28 +0200
In-Reply-To: <51940.86.107.254.57.1398840206.squirrel@boosthardware.com>
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

Patrick Shirkey wrote:
>
> Have you looked into netjack?
>
> Several of the network timing issues have been worked through quite
> extensively. We have used it to distribute data across several machines in
> a cluster and find it to be very stable and workable with acceptable
> latency over gigbit lan.
>
> You might find netjack gives you a good headstart on this project.
>
> Adding support for JACK is a minor task compared to rewriting (and
> testing) netjack.  You will also gain access to a host of other
> professional functionality and ALSA, OSS, FIrewire support too.
>
> In addition your software will play nice with other professional software
> and have direct access to data on the JACK graph as a bonus.
>

Thanks for the pointer!  It indeed appears that this project is trying the same thing as
we are doing.

It will require some further study.  Documentation appears to be scarce, I have not been
able to locate a document yet that describles what it actually achieves and what caveats
there are.  I saw one thing on the Wiki: it transmits data all the time.  We will probably need
some form of on/off control to avoid wasting bandwidth, but maybe it can be done in a CODEC.

I also saw it has fixed network latency setting, while I had already envisioned a system for
automatically determining the added latency based on feedback from the remotes.

But at least it provides a lot of insight into using Alsa in timing critical applications, something
I had been looking for.

(I know that writing documentation is a drag, but projects like Alsa and this one would be so
much more useful and accessible when there would be more detailed documentation that
goes beyond an installation HOWTO and a plain listing of available functions and parameters)

Rob
