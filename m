From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx: variable period size support,	Santa
 Cruz rear output fixes
Date: Sat, 09 Nov 2002 12:43:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCCF4C9.8040707@cucumelo.org>
References: <1036817449.30137.2.camel@pete>
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
To: Peter Good <psgood@petesinternet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>So should the drive be able to set period size with this patch?
>
>Reason I ask is this.
>
>spongy@pete:~$ alsaplayer
>error on set_period_size (1024)
>  
>
Still maximum period size is 512, just as before.
Try start alsaplayer:
alsaplayer -f 2048
alsaplayer -f 1024
alsaplayer -f 512
alsaplayer -f 128
alsaplayer -f 64

And you can try start jackd:
/usr/local/bin/jackd -R -a -d alsa -p 512 -d pcm.cs46xx
/usr/local/bin/jackd -R -a -d alsa -p 128 -d pcm.cs46xx
/usr/local/bin/jackd -R -a -d alsa -p 64 -d pcm.cs46xx
/usr/local/bin/jackd -R -a -d alsa -p 32 -d pcm.cs46xx

Should work OK, however you probably wil have a lot of xruns
with low period sizes.
Should be interesting test this with low-latency patch, or
preemptive-scheduler.

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
