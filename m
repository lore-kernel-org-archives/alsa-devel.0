From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] SBLive, OSS mixer (PCM/Master) + digital out
Date: Sun, 15 Sep 2002 11:13:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209151106150.1203-100000@pnote.perex-int.cz>
References: <3D833E56.7030200@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA22908
	for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2002 11:14:52 +0200
In-Reply-To: <3D833E56.7030200@web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stefan <stefan.mau@web.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 14 Sep 2002, Stefan wrote:

> Jaroslav Kysela wrote:
> 
> >On Fri, 23 Aug 2002, Stefan wrote:
> >
> >  
> >
> >> >> So how do I get OSS applications using the Wave slider instead PCM/Master? I'm 
> >> >> not sure if this is an alsa thing but apps not supporting it.
> >> >> Maybe there's a workaround in .asoundrc? I had a look at the docs, but it 
> >> >> appeared quite complex to me.
> >>
> >>    
> >>
> >>>no, it's not possible.
> >>>so far, each OSS mixer is hard-coded to the alsa mixer element, such
> >>>as "Master" or "PCM".
> >>>      
> >>>
> >>>you can change the driver code (alsa-kernel/core/oss/mixer_oss.c)
> >>>but of course it's not a common solution...
> >>>      
> >>>
> >> 
> >>I think that Master slider and even Wave slider have no effect at all on Digital Output
> >>is very crappy. Even the OSS Kernel driver supports that. I would really love it
> >>when the Master slider would have an effect on the Digital Output.
> >>Why is it called Master slider when I can mute it and still get sound out of my Digital Boxes.
> >>    
> >>
> >
> >Because the digital path is totaly different than analog one. It's true 
> >that Master referes analog master (and only front, because rear path is 
> >standalone as digital out as well). We can rename Master to Analog Master 
> >for EMU10K1 if you want to not confuse you and others.
> >  
> >
> I noticed that Wave Surround works both for Analog Rear Output and 
> Digital Rear!
> And some other things, that may be interesting for all people outside 
> with 5.1, 4.1 Box Sets.
> I'm using a DTT 2500 Digital Cambridge Soundworks +
> SBLive! Player 1024 (Digital Output with yellow 3,5 mm)!
> 
> Things I noticed that work, don't work with ALSA 0.9 rc3 in the alsamixer
> 
> Master -> works only Analog Front (NO Analog Rear, no Digital in any way!)
> Master Mono -> what's that? necessary?
> Tone, Bass, Treble -> works fine with Analog + Digital
> 3D Control -> necessary?, I hear no difference!
> PCM -> Works ONLY for front Analog output! (No Analog Rear, no Digital)
> Surround Digital, Surround Digital Capture, Center, LFE, -> I think this 
> is for new generation SBLive! 5.1, right?
> Wave -> Front Digital Boxes AND Front Analog Output (is louder than Wave 
> Sourround!!! why?)
> Wave Surround -> Rear Digital Boxes AND Rear Analog Output
> 
> Music -> no Idea!
> Music Cap -> no Idea
> Line -> Works only for Analog Front Output (no Digital, No Analog Rear!)
> 
> The rest of the controls I don't really understand, all the EMU10k1 PCM 
> Send stuff... maybe someone could
> explain that, I've not found any Documentation about that.
> 
> When I'm hearing MP3 sound, I can't adjust the volumne in any 
> application when using Digital Output.
> Even with Analog Connection (Front+Rear) I can then only adjust the 
> Analog Front Boxes. That's driving me crazy! :(
> The different Wave, Wave Sourround sliders are nice, but the overall 
> volumne should be controlled with Master/PCM sliders.
> 
> Who's the hero that can hack this?

This sort of hacks should be implemented in the user space.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
