From: holborn <holborn@telefonica.net>
Subject: alsa_seq & threads
Date: Thu, 3 Jul 2003 16:35:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307031635.24018.holborn@telefonica.net>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi!

Sorry for the english ....

I'm still developing an app using seqmidi interface .... i'm not really sure 
about that but if i open: 

snd_seq_open (&seq_handle1, "default", SND_SEQ_OPEN_INPUT, 0);
snd_seq_open (&seq_handle2, "default", SND_SEQ_OPEN_OUTPUT,0);

and in the main program i start two threads .... the second one consume 100% 
of CPU time even if this thread dont do nothing only loops. That happens also 
in another app i was developped. The program runs ... but .... 

Valgrind tells :

==19806== Thread 2:
==19806== Syscall param ioctl(generic) contains uninitialised or unaddressable 
byte(s)
==19806==    at 0x40623304: ioctl (in /lib/libc-2.3.1.so)
==19806==    by 0x4054E23F: snd_seq_get_client_pool (in 
/usr/lib/libasound.so.2.0.0)
==19806==    by 0x4054EC71: snd_seq_set_client_pool_output (in 
/usr/lib/libasound.so.2.0.0)
==19806==    by 0x805116C: GMO::init_queue() (in 
/home/holborn/gmorgan/src/gmorgan)
==19806==    Address 0x449A89C4 is on thread 2's stack

but ... i'm musicien ... not programmer ... i dont know what to do ...

Another thing is ... any posibility to include more examples in the 
documentation, they help ....

Any help?

thanks.

Josep

 



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
