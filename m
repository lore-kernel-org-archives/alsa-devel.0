From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: VOIP xrun problem
Date: Tue, 23 Oct 2012 17:10:06 +0200
Message-ID: <5086B34E.30400@ladisch.de>
References: <CAJqUV39Mg8+Cd_ogFGL1vjagwpmBYCC+avWkQaBtPpQz0zZkTg@mail.gmail.com>
 <5085B04E.8040507@faberman.de>
 <CAJqUV39RZ6SB4OQmn5oF61P2=NNxvs9yzPzAtY8fqP7Y1yVjgA@mail.gmail.com>
 <50863AB0.9040004@ladisch.de>
 <CAJqUV3_pp0upB_fV_TzK7PTJYQTatU=uGbgWG8cC899RBHXxqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 908E92652DB
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 17:10:08 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 195B820666
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 11:10:08 -0400 (EDT)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id AE4CA4825DD
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 11:10:07 -0400 (EDT)
In-Reply-To: <CAJqUV3_pp0upB_fV_TzK7PTJYQTatU=uGbgWG8cC899RBHXxqw@mail.gmail.com>
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

Jamey Drennan wrote:
> On Tue, Oct 23, 2012 at 2:35 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> So the RTP stream is synchronized to the sender's clock.
>> How do you handle the differences between the stream's clock and
>> the playback device's clock?
>
> The client and server negotiate the connection parameters including packet
> interval, size, audio format, and rate.  The rtp library ensures that the
> packets arrive on time and accounts for initial time differences.  Maybe
> the timestamps of the stream packets aren't enough to keep the two clocks
> synchronized(or a frame is the same regardless if the two devices are set
> up the same)?

The sender's and receiver's clocks are determined by the crystals
soldered onto their sound cards.  You can try to configure them for
the same nominal sample rate, but you cannot avoid that they run fast
or slow relative to each other by some fraction of a percent.

> In testing, the two clocks are one and the same since I am
> running the client and server on the same device.

So the problem shows up even when testing?


Regards,
Clemens
