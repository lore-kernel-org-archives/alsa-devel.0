From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Wed, 30 Oct 2002 00:18:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DBF173F.2010209@cucumelo.org>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu> <20021029164403.GC776@porky> <20021029170914.GE1046@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob McElrath <bob+alsa-devel@mcelrath.org>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>Seems to work well.  The relevant mixer settings are PCM1 and Surround1
>(both of which must be turned up and unmuted.  However it doesn't seem
>to deal well with odd rates:
>
>(0)<mcelrath@draal:/home/mcelrath> aplay -Dhw:0,1 /usr/share/sounds/zipper.wav 
>Playing WAVE '/usr/share/sounds/zipper.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
>aplay: pcm_write:968: write error: Input/output error
>  
>

Hm.,, just weird, does it work OK with the fron channel (hw:0,0) ???

What do get on dmesg output ???

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
