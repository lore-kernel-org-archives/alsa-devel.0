From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: Patchmix-style application for EMU cards
Date: Thu, 24 Apr 2008 23:32:55 +0200
Message-ID: <200804242332.55916.c.fertr@gmail.com>
References: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
	<200804201916.00941.c.fertr@gmail.com>
	<c812bae60804202142y1d59905fib7721089fc701fef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.vol.cz (smtp2.vol.cz [195.250.128.75])
	by alsa0.perex.cz (Postfix) with ESMTP id DD68A24655
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 23:34:39 +0200 (CEST)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp2.vol.cz (Postfix) with ESMTP id 64B2328FE2
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 23:34:36 +0200 (CEST)
In-Reply-To: <c812bae60804202142y1d59905fib7721089fc701fef@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

> On my card, playback channels 1 & 2 (hw:0,3) appear on all DSP busses
> associated with surround.
> Say you turn up the "Side" fader in alsamixer, channels 1 & 2 will appear
> at the relevant DSPs (6-7, I think)
> Whatever, for now I am just keeping all surround controls down (that is,
> Front, Surround, Center, Side & LFE).

I see, you talking hw:0,3. Perhaps this will help: 
http://www.mjmwired.net/kernel/Documentation/sound/alsa/Audigy-mixer.txt
http://www.mjmwired.net/kernel/Documentation/sound/alsa/emu10k1-jack.txt

> I think the switches and enums for the card models are rather trivial, one
> can handle it with a customized version
> of qamix (done with a simple XML file), for example. A separate application
> would not be necessary for only that.

I disagree. With all the switches, routing, sample rates and several models, 
the EMU is one of the most complex cards. Definitely more complex than 
Envy24, Echo or perhaps even RME/HDSP. All these cards have their 
appliactions in alsa tools. 

> By the way, only DSP0-7 work in this way. I have no idea how to make
> DSP8-31 work.

You cannot do that without a driver modification. There is no any EMU specific 
code for hw:0,3. It somewhat works thanks to DSP code in hw:0,0, which copies 
data from emu10k registers to DSP0 to DSP7 ports. 

Personally, I'd like to have an 8 channel 24bit  playback on hw:0,0 with all 
the fader stuff for consumer playback and then another device (modified 
hw:0,3 or even a new one)  for (at least) 16 channel 24bit playback directly 
passed onto DSP buses. 

Regards,

Ctirad    
