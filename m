From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs64xx distortion (GameTheater XP)
Date: Fri, 17 Jan 2003 00:11:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E273C33.9050905@cucumelo.org>
References: <200301160014.11787.c.esken@cityweb.de>
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
To: Christian Esken <c.esken@cityweb.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>I wonder what the status of the cs64xx distortion problem is.
>I tested the 2003-01-14.tar.bz2 snapshot with my GameThaeter 7.1 XP
>
My opinion: the GameTheater XP it's a cheap soundcard with a beautiful 
blue box. Usually cheap soundcard got a cheap design as result of a tiny 
bugdet, so just dont expect to much from the analog part's.

Actually I got a Hercules GameTheater XP 6.1, when volume is over about 
a ~80% the output is sometimes distorcionated, but I believe that's 
something we cant do anything about in the driver. Limit some volume 
control's in the driver dont feel like a coherent solution.

The card is still usable, I really dont expect to better quality on 
analog output with this soundcard.

>ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
>ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
>ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?
>  
>
Feel like theese messages should not be there, could be a bug in cs46xx 
driver.

>I am wondering about the status, as there is still this comment in cs64xx_lib.c:
>---------------------------
>        /* CD mute change ? */
>
>        /* Benny: this hack dont seems to make any sense to me, at least on the
>Game Theater XP,
>           Turning of the amplifier just make the PCM sound very distorcionated.           is this really needed ????????????????
>        */
>---------------------------
>
>  
>
Should only matter if you unmute the analog CD input, and with the new 
DSP code it dont matter at all.

/Benny



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
