From: Paul Davis <pbd@Op.Net>
Subject: Re: oss emulation for rme9652
Date: Thu, 28 Feb 2002 09:50:06 -0500
Message-ID: <200202281450.JAA08847@renoir.op.net>
In-reply-to: Your message of "Thu, 28 Feb 2002 13:05:48 +0100."
             <C1E3CFAE25BBCB45AAB06733BDC048DF18BBC9@tempo.INTERN.ARTCOM.DE>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>
Cc: alsa-devel@lists.sourceforge.net, David Siegel <david.siegel@ARTCOM.DE>
List-Id: alsa-devel@alsa-project.org

Hi, 

before we begin, I wrote the Hammerfall driver, just so you know :)

>we're trying to get an rme9652 soundcard to work using the ALSA oss emulation 
>layer and we're stuck at a strange place. Any help is appreciated. In particul
>ar: Can anyone confirm that the oss emulation works with the rme? (If not: How

In general, I will be suprised if OSS emulation works on the
Hammerfall, and even if it does, its probably relatively costly in CPU
cycles. One of the many reasons why OSS is such a poor API is that it
can't be used efficiently with a device like the Hammerfall. Thats
because OSS does not have any concept of noninterleaved sample format.

the OSS emulation layer lives in the kernel, and as such, it requires
that the sample format matches one supported by the hardware since OSS
has no way to specify a noninterleaved format, this can't work. there
is no ioctl you can use in the OSS API that would tell ALSA that you
are using the correct sample format.

libaoss can deal with this, but it requires that LD_PRELOAD be set so
that all OSS I/O is rerouted to use alsa-lib. its a hack, and you
should not be writing new or even recent software with the idea of
using this.

> hard would it be to reengineer our software to use ALSA directly?)

Probably very easy.

>Our software is a mixer we developed inhouse. We've installed ALSA ver 0.5.12a

Sorry to have to say this, but thats a Bad Move in general, and with
the Hammerfall, a Very Bad Move. 

The Hammerfall driver in ALSA 0.5.X is badly designed (I can say this
because I wrote it), and it was completely overhauled for the
development that become 0.9.X. I do not maintain or provide advice on
the 0.5.X driver, and I regret that it has continued to be available.

I wish I could accept personal responsibility for the way ALSA has
continued to describe 0.5.X as the "stable" release, when in fact,
0.9.X is much better is almost every way and has been for at least 3
months. Unfortunately, I can't, so you'll just have to accept my
apologies for this particular situation.

If you need more help/advice, please let me know. Also, please keep in
mind that ALSA 0.9 is the API that is now part of Linux 2.5 ...

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
