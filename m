From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Fwd: Re: [PATCH] cs46xx DAC volume's mechanism
 rewrite, minor bugfixes]
Date: Mon, 11 Nov 2002 09:49:00 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211110947460.521-100000@pnote.perex-int.cz>
References: <3DCF70BD.3020603@cucumelo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DCF70BD.3020603@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Peter Good <psgood@petesinternet.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Nov 2002, Benny Sjostrand wrote:

> >
> >
> >------------------------------------------------------------------------
> >
> >Ok, that's fixed the bass problem I had here.
> >One thing though. Benny, do you have any idea what these values "should"
> >be?
> >  
> >
> But I still dont understand the problem. And reports are not at all 
> consequent ...
> 
> >iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2
> >  
> >
> I guess you need to add in .asoundrc:
> iec958 {
>   type hw
>   card 0
>   device 2
> }
> 
> Then maybe someone knows what xine uses the 
> AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2 values to,
> do they need to interfaces to the lowlevel driver ???

It's first 32-bits to setup the channel status block in the S/PDIF 
stream. The main job is to tell the remote receiver, that data are 
'non-audio' (bit 1 = 1).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
