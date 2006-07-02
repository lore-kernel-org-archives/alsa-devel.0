From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: OSS driver removal, 2nd round
Date: Sun, 2 Jul 2006 11:58:37 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<20060701073133.GA99126@dspnet.fr.eu.org>
	<44A6279C.3000100@superbug.co.uk> <44A76DDF.4020307@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from linux01.gwdg.de (linux01.gwdg.de [134.76.13.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E50621C
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 11:58:44 +0200 (MEST)
In-Reply-To: <44A76DDF.4020307@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>, Lee Revell <rlrevell@joe-job.com>, perex@suse.cz, Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

>
>There is an ALSA tool called aoss.
>What this does is hook any calls the application does to
>fopen/fwrite/fread/fclose/open/close/read/write/ioctl etc. and detects
>any calls to open /dev/dsp and /dev/mixer and diverts them to use
>alsa-lib. This therefore manages to divert the applications use of
>/dev/dsp before it even reaches the kernel. This therefore gives the
>application full use of all the alsa-lib features. So, for example,
>4-channel output would work in this mode. But, and this is the bit we
>need help with, if the application uses dlopen to dynamically open a
>plugin, the plugin's calls to open/close/read/write etc. are not hooked,
>so the application fails.
>
>Is there any way to also hook the IO calls of dlopened plugins?
>
Well you could patch the affected plugin's .dynstr table so that it should at
best try to call a function that has not yet been defined somewhere else (like
open); IOW, you change the .dynstr entry from 'open' to say 'my_open', and
regularly include libmy.so through e.g. LD_PRELOAD.

Of course the MD5 won't match afterwards, but I think the plugin should execute
as usual afterwards, since .dynstr is something no app should rely on.


Jan Engelhardt
-- 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
