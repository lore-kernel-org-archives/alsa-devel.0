From: Raymond <rayau@netvigator.com>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Sat, 10 Sep 2005 08:40:20 +0800
Message-ID: <43222B74.1020602@netvigator.com>
References: <4317CC51.3040709@netvigator.com>     <200509042134.23916.alien999999999@users.sourceforge.net>    <1126131309.17399.8.camel@pc-erik.lan> <44272.62.59.249.250.1126163238.squirrel@62.59.249.250>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44272.62.59.249.250.1126163238.squirrel@62.59.249.250>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Erik <assie2@zonnet.nl>, Alien <alien999999999@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

When watching movie using xine (downmixing 5.1 to Surround40) with my
au8830 on 32bits machines, the 4 channels are correct at first movie
only. The Human voice (center) come out from rear speakers aftewards.

1) speaker-test -c 4 -D hw:0,0
2) using xine to play 5.1 channel-test audio samples with FFTScope enabled.

the above tests indicate that the front and rear channels are swapped
after the first play.

Please let me know if you also have this problem on your MX300.

The hardware equalizer of au8830 sound much better than the software
equalizer of XMMS.

There are follow up about how to fix 32/64bits issues related to the 
equalizer and features not presented in au8820.

http://sourceforge.net/mailarchive/message.php?msg_id=11997399

alien seem have no interest to test the hardware equalizer
because of the hang oops.


Alien wrote:
>>i'm busy with home improving but when i have time i will try the patch
>>again on 2.6.12 kernel. I have not checked if it is the same alsa
>>version as 2.6.11 but i think it is.
>>
>>b.t.w. the volume bar problem is in XMMS (didn't try other programs
>>because i haven't a lot of time) (just online for mail checking etc.
>>that's it)
>>but i think alien can tell you about the volume bar problems.
> 
> 
> which volume bar problems are you talking about?
> 1. the ones where if you get 49% it's loud and on 51% quite silently?

This problem on STAC9704 have been fixed.

> 2. or irregular sound volume when you are about halfway (without changing
> volume yourself).
> 
> actually after experimenting I think it might be something hardware
> related (ie with the volume control of my speaker system, not the
> au8810)...
> 
> 
>>pc information:
>>
>>mandriva 2005 le
>>kernel 2.6.11
>>amd 64 bit 3500+
>>diamond monster sound mx300 au8830 card
>>
>>
>>Erik
>>
>>






-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
