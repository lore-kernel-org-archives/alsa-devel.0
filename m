From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Mon, 11 Mar 2013 07:01:59 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED4027D@DBDE01.ent.ti.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <513721E0.8000605@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D44D@DBDE01.ent.ti.com>
 <5139F411.10407@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0302B2615A6
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 08:02:08 +0100 (CET)
In-Reply-To: <5139F411.10407@topic.nl>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 08, 2013 at 19:52:09, Mike Looijmans wrote:
> On 03/06/2013 12:19 PM, Bedia, Vaibhav wrote:
> > On Wed, Mar 06, 2013 at 16:30:48, Daniel Mack wrote:
> >> On 06.03.2013 11:54, Bedia, Vaibhav wrote:
> >>> Hi Daniel,
> >>>
> >>> On Tue, Mar 05, 2013 at 21:31:59, Daniel Mack wrote:
> >>> [...]
> >>>>
> >>>> As Michal described, we used a board with a multichannel Codec on it,
> >>>> which connects 3 of its I2S inputs to the AM33xx's AXR data lines.
> >>>>
> >>>> Software wise, we tested with 'aplay -cX', and that seems to work just fine.
> >>>>
> >>>
> >>> Since you are using a multichannel codec things are a lot simplified for you :)
> >>> Someone might want to hook up multiple codecs to get multi-channel behavior.
> >>> There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
> >>> sync. I haven't really followed the recent ASoC changes so I don't know whether
> >>> something like this can be handled right now.
> >>
> >> I would rather instanciate multiple McASP cores for such setups, so you
> >> can (in theory) also make them operate on different bit depths and clock
> >> dividers. You think that's possible as well?
> >
> > Yeah. Using multiple McASPs would be much simpler to handle both in s/w and h/w.
> 
> Would it?
> 
> The McASP has multiple serializers, but they all share the same clocks 
> and format settings. The data will come in as "L1 L2 L3 .. R1 R2 R3 .." 
> so the code would have keep track of which channels have to go where, 
> and rearrange it to the clients. And it must be able to dynamically 
> add/remove channels without disturbing the other streams.
> 

I don't see how the grouping of codecs like you are mentioning helps
add/remove channels while capture/playback in on-going. By implementing
a dummy codec you can select which serializers are enabled/disabled but
won't the selection have to be be before starting any streaming since you
can't update the DMA controller configuration on the fly. Or maybe that's
what you meant by add/remove channels without disturbing the other streams.

> So unless you want to physically add more McASP hardware to the system, 
> I don't see how this would be "simpler" to handle than other options.
> 
> A way to "group" the codecs together is much simpler to implement (which 
> is simply proven by the simple fact that I implemented it on my system) 
> and it makes it very easy to control on the user side too - the 
> selection of codecs is just a mixer control.
> 

It's good that you have working a implementation. Like I mentioned in the
other thread it would be good if you can post the changes that you did
so that the approach can be discussed in detail, obviously assuming you want
something like to be handled in mainline code.

Regards,
Vaibhav
