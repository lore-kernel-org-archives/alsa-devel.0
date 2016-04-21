From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 11:11:12 +0900
Message-ID: <571836C0.40605@sakamocchi.jp>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
 <57181862.6060501@sakamocchi.jp>
 <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B562608B3
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 04:11:15 +0200 (CEST)
In-Reply-To: <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Allan Klinbail <aklinbail@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 21 2016 09:14, Allan Klinbail wrote:
> Thanks Takashi ,
>
> It was my understanding that FFADO would eventually be deprecated,  so am
> trying to provide test feedback for my device.  I thought comparable
> performance would be a goal.

Your misunderstanding.

ALSA firewire stack is not an alternative of FFADO implementation. 
Against understanding of most of FFADO users, the implementation of this 
stack doesn't come from FFADO implementation, therefore they're based on 
quite different designs and code bases.

(It's your misfortune that FFADO project has already lost 
well-established developers who can explain about it.)

And you should realize that the decrease of size of PCM buffer is an 
ancient technique to reduce communication latency in a past decade. JACK 
developers still adhere on it, against their aim, unfortunately.  To 
understand this aspect, please read Alexander Patrakov's paper proposed 
in LAC 2015.
http://lac.linuxaudio.org/2015/papers/10.pdf

It's a bit difficult to you. But when thinking about the 'latency' 
severely, at least, users and developers should understand what in the 
article, at least. About the communication latency, I'm willing to use 
my time for this direction, but not for the others.

> Using ALSA is desirable as I have a large number of MIDI devices (2*AMT 8)
> and 3 other control devices..  Using ALSA provides better connectivity than
> a2jmidi..

What's the 'AMT'?

> I will try alsa in,  plug.. I am concerned though this is not an ideal
> solution due to trying to sync multiple devices which in reality share a
> clock..  Adding even more latency..

Even if using FFADO implementation, you can't achieve it. It pretends as 
what you say. Of cource, the size of PCM buffer is accumulated to the 
communication latency.

> I will continue using FFADO for production work,  but am happy to keep
> testing if you believe improvements can be made.

I haven no plan of my development for the direction about which you 
mentioned, sorry. There're more crutial issues than them.


Regards

Takashi Sakamoto
