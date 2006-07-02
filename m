From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: OSS driver removal, 2nd round
Date: Sun, 02 Jul 2006 07:55:27 +0100
Message-ID: <44A76DDF.4020307@superbug.co.uk>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<20060701073133.GA99126@dspnet.fr.eu.org>
	<44A6279C.3000100@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4CE82225
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 08:55:30 +0200 (MEST)
In-Reply-To: <44A6279C.3000100@superbug.co.uk>
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

James Courtier-Dutton wrote:
> "Never" probably only means terribly long. :-)
> 

There is in fact one implementation method that we would like to
implement, but currently we don't know how, so some input from people
from this list might be helpful.

There is an ALSA tool called aoss.
What this does is hook any calls the application does to
fopen/fwrite/fread/fclose/open/close/read/write/ioctl etc. and detects
any calls to open /dev/dsp and /dev/mixer and diverts them to use
alsa-lib. This therefore manages to divert the applications use of
/dev/dsp before it even reaches the kernel. This therefore gives the
application full use of all the alsa-lib features. So, for example,
4-channel output would work in this mode. But, and this is the bit we
need help with, if the application uses dlopen to dynamically open a
plugin, the plugin's calls to open/close/read/write etc. are not hooked,
so the application fails.

Is there any way to also hook the IO calls of dlopened plugins?

James

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
