From: Hans Kramer <Hans.Kramer@xs4all.nl>
Subject: Re: PCM playback doesn't work on Toshiba Tecra8100.
Date: Thu, 11 Nov 2004 12:03:15 +0100
Message-ID: <1100170995.2430.32.camel@cancun.hanskramer.com>
References: <4701.80.126.101.126.1100122463.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4701.80.126.101.126.1100122463.squirrel@webmail.xs4all.nl>
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
List-Id: alsa-devel@alsa-project.org

Just a note:

Very rarely it happens when I boot up my Toshiba Tecra, the PCM playwork
works fine. Perhaps, I am ignorant, but couldn't it be a simple
initialization issue?
Any pointers on how to unload the ALSA drivers with rmmod?
A lot of other drivers seem to depend on it. Also, how can I prevent
this module to be loaded in the first place. I commented out the lines
in /etc/modprobe.conf and /etc/sysconfig/hwconf. (again I am using
RHFC3)

Thanks in advance,

Hans.

On Wed, 2004-11-10 at 22:34, Hans Kramer wrote:
> Dear ALSA developers,
> 
> >From the following link I understand that the snd-ymfpci
> module doesn't work on a Toshiba Tecra 8100.
> http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Aopen&card=AW744+Pro.&chip=YMF744B&module=ymfpci
> 
> I was running Fedora Core 1 my Tecra 8100 and then the sound card was
> working fine (using OSS I assume). After my upgrade to Fedora Core 3, the
> card still gets recognized, however, it only produces noice. My
> understanding is that with the introduction of kernel 2.6, Fedora Core 2
> switched to ALSA.
> 
> Perhaps it's a bit of an old box, nonetheless, I would like to make it work.
> Although, I am a developer, I have no experience with device drivers or
> kernel programming. So the learning curve might be a bit steep. Is there
> an ALSA developer that can help me or want to work on this issue. Any help
> and pointers are welcome!
> 
> Thanks in advance,
> 
> Hans.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
