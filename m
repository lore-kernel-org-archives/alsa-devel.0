From: Camilo Polymeris <cpolymeris@gmail.com>
Subject: Re: Patchmix-style application for EMU cards
Date: Sun, 29 Aug 2010 03:40:01 -0400
Message-ID: <1283067601.4084.11.camel@aviva.ttga.homeip.net>
References: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
	<200804201916.00941.c.fertr@gmail.com>
	<c812bae60804202142y1d59905fib7721089fc701fef@mail.gmail.com>
	<200804242332.55916.c.fertr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 34BEA2438E
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 09:40:06 +0200 (CEST)
Received: by gyh4 with SMTP id 4so1847671gyh.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 00:40:05 -0700 (PDT)
In-Reply-To: <200804242332.55916.c.fertr@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ctirad Fertr <c.fertr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
for those of you not subscribed to LAD, I finally got to write a mixer
application for the EMU 1010 based cards. I tossed out the original
ideas of a full-featured app and went the simple way, just basic
point-to-point routing, no fancy "Multichannel"  features.

It's available here: http://code.google.com/p/emutrix/
Screenshot:
http://www2.udec.cl/~cpolymeris/emutrix/Screenshot-EMutrix-1.png

Be aware that the code is awful, just fast prototyping, but functional.
It may also mess with your mixer levels, if you want to try it. please
make a backup with 'alsactl store'.

Feedback welcome,
Camilo


On Thu, 2008-04-24 at 23:32 +0200, Ctirad Fertr wrote:
> Hello.
> 
> > On my card, playback channels 1 & 2 (hw:0,3) appear on all DSP busses
> > associated with surround.
> > Say you turn up the "Side" fader in alsamixer, channels 1 & 2 will appear
> > at the relevant DSPs (6-7, I think)
> > Whatever, for now I am just keeping all surround controls down (that is,
> > Front, Surround, Center, Side & LFE).
> 
> I see, you talking hw:0,3. Perhaps this will help: 
> http://www.mjmwired.net/kernel/Documentation/sound/alsa/Audigy-mixer.txt
> http://www.mjmwired.net/kernel/Documentation/sound/alsa/emu10k1-jack.txt
> 
> > I think the switches and enums for the card models are rather trivial, one
> > can handle it with a customized version
> > of qamix (done with a simple XML file), for example. A separate application
> > would not be necessary for only that.
> 
> I disagree. With all the switches, routing, sample rates and several models, 
> the EMU is one of the most complex cards. Definitely more complex than 
> Envy24, Echo or perhaps even RME/HDSP. All these cards have their 
> appliactions in alsa tools. 
> 
> > By the way, only DSP0-7 work in this way. I have no idea how to make
> > DSP8-31 work.
> 
> You cannot do that without a driver modification. There is no any EMU specific 
> code for hw:0,3. It somewhat works thanks to DSP code in hw:0,0, which copies 
> data from emu10k registers to DSP0 to DSP7 ports. 
> 
> Personally, I'd like to have an 8 channel 24bit  playback on hw:0,0 with all 
> the fader stuff for consumer playback and then another device (modified 
> hw:0,3 or even a new one)  for (at least) 16 channel 24bit playback directly 
> passed onto DSP buses. 
> 
> Regards,
> 
> Ctirad    
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
