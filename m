From: Benny Morgan <gorm@cucumelo.org>
Subject: Re: RC7 and CS46xx (GTXP)
Date: Thu, 06 Feb 2003 16:46:30 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E42D7B6.6030205@cucumelo.org>
References: <20030201144858.0479188a.flame@home.se> <20030201170036.47cea5c3.flame@home.se>
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
To: Richard Olsson <flame@home.se>
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>
>
>Replying to my own mail, I know:)
>
>I reverted the changes the recent amplifier patch did to cs46xx_lib.c
>and RC7 works perfectly - no warning in dmesg either.
>
>  
>
The cs46xx FIFO's are usually only accessed internally by the DSP. 
There's is backdoor that make it possible to access the FIFO's from the 
host.

My theory is that it's not possible to use this backdoor while the DSP 
is accesing the FIFO's
To enable the rear speakers on the Santa Cruz card this backdoor is used 
to access some GPIO's on the secondary codec.
A couple of month agoo I've changed the initialization order so: the 
rear-speakers on the Santa Cruz board was enabled was enababled before 
the DSP core was started, apparently it worked out. Now the problem 
could be that the initialization order is changed again.

/Benny




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
