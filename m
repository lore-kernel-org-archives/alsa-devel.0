From: markknecht@attbi.com
Subject: Re: hdsp multiface pci.
Date: Mon, 20 Jan 2003 16:12:33 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18aeXQ-0006Z2-00@sc8-sf-list1.sourceforge.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Williams <raw@qux.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Roger,
   I'm in the office right now, so I'll pop home at noon PST and happily try 
out things. 

   Yesterday the only thing were you seemed to differ with me on my description 
of things was how Alsa_pcm:playback signals got to the physical outputs. I said 
they were hooked up automatically, by the driver. I think you felt otherwise. 
Possibly that is part of this problem I'm having?

   My test setup was pretty simple. I started alsaplayer and qjackconnect so 
that I could see how things were hooked up. Standard default hookup takes 
alsaplayer audio and sends it to playback_1/2. This goes out through ADAT-1, 
channels 1 & 2, and to a PowerPlay Pro headphone amp. My headphones are plugged 
in there.

   With a CD in the drive I can hear sound through my headphones.

   At this point I believe that Alsa_pcm:playback_1/2 are hooked to physical 
outputs 1/2 since I get sound.

   I then run (from my sleepy memory) 

amixer cset numid=5 26,0,300
amixer cset numid=5 27,1,300

to reduce volume, but it doesn't. No values in the '300' position seemed to do 
anything.

   For clarification, what I thought I was doing with the above command was 
taking playback_1/2 (26,27) and routing them through the mixer to physical 
I/O's 0&1. If the numbering is wrong, that set of commands could certainly be 
incorrect. (Or I'm still just not understanding things and plain mixed up.)

   Thinking about it this morning though, it seems to me that possibly the 
default routing of audio doesn't go through the mixer at all? If this is the 
case, then maybe I need to break whatever the default conection is before I can 
hear the effects of the mixer? Is this the purpose of your script below?

   Let me know where you think I'm going wrong.

Thanks!
Mark
> Hi, Mark --
> 
>   > When I tried some amixer commands I was disappointed to find that
>   > they do nothing at all on my machine. No command I tried seems to
>   > control volume to my headphones or speakers at all.
> 
> Could you briefly explain your test setup and what amixer commands
> you've been generating?  I'm surprised that the ALSA driver seems to
> work, yet amixer doesn't.
> 
> Are you setting the "line_outs_monitor" parameter in /etc/modules.conf?
> (You shouldn't.)
> 
> When you try to zero all of the mixer routes, does it have any effect?
> Perhaps the channels are mapped differently than we think.  This
> script will try to zero all 1352 channels for you:
> 
> #!/bin/bash
> 
> ADAT1="0 1 2 3 4 5 6 7"
> ADAT2="8 9 10 11 12 13 14 15"
> ADAT3="16 17 18 19 20 21 22 23"
> SPDIF="24 25"
> 
> function disconnect () {
>     for output in "$@"; do
>         input=0
> 	while [ $input -le 25 ]; do
> 	    echo -n "."
> 	    amixer cset numid=5 $input,$output,0 > /dev/null
>             input=$((input+1))
> 	done
>     done
>     echo
> }
> 
> echo -n "Disconnecting ADAT1 outputs"
> disconnect $ADAT1
> echo -n "Disconnecting ADAT2 outputs"
> disconnect $ADAT2
> echo -n "Disconnecting ADAT3 outputs"
> disconnect $ADAT3
> echo -n "Disconnecting SPDIF output"
> disconnect $SPDIF
> 
> -- 
> Roger Williams <raw@qux.com>
> Qux Tool & Die, Middleborough, Massachusetts
> // Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
