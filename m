From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Wed, 30 Oct 2002 00:47:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DBF1E29.1000901@cucumelo.org>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>With a GTXP on an alpha. ;)
>  
>
Cool! stupid question from me, which endianess does the Alpha 
architecture have ??
well, I believe the cs46xx is never tested on Big-Endian architecture

>I managed to stall the codec by playing with the IEC958.  I turned the
>IEC958 input all the way down, unmuted it, then unmuted the IEC958
>output.  I was playing an mp3 at the time, and the mp3 stopped and the
>codec just puts out a constant ~8khz tone.  This is repeatable.
>  
>
A old bug that I supposed was fixed, but apparentily it's not, probably 
course
I've never tested to play with SPDIF in and SPDIF out control at the same
time. Hopefully I'll find a way to get around it ....

Just to confirm; if you only play with SPDIF input mixer control, leaving
the SPDIF output unmuted it dont happen right ?

>Recording still seems to not work.  I still get about a 1Hz ticking in
>the right channel when recording (no matter what the mixer settings).
>  
>
Recording should work fine, did you have the DAC capture SPIDF input 
"on" ?? then
it could be SPDIF input related ...

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
