From: "Jaap Struyk" <japie@deserver.nl>
Subject: Re: problems with via82xx alsa part
Date: Fri, 20 Oct 2006 07:00:52 +0000 (UTC)
Message-ID: <eh9s74$jcl$1@sea.gmane.org>
References: <ef3pll$kng$1@sea.gmane.org> <efos3e$g63$1@sea.gmane.org>
	<s5hwt7ghsxd.wl%tiwai@suse.de>
	<1160121885.1790.2.camel@japie.deserver.nl>
	<s5hd595u1t3.wl%tiwai@suse.de>
	<1160325289.2558.2.camel@japie.deserver.nl>
	<s5hzmc5pb7c.wl%tiwai@suse.de>
	<1160499844.2449.5.camel@japie.deserver.nl>
	<s5hbqokm65g.wl%tiwai@suse.de> <eglrgk$vpi$1@sea.gmane.org>
	<s5hfydtiic4.wl%tiwai@suse.de> <egt810$628$1@sea.gmane.org>
	<s5hac3wbmpn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Op Mon, 16 Oct 2006 12:04:52 +0200, schreef Takashi Iwai:

> Odd, indeed.  You ARE using 32bit kernel, right?
> 
> My system is with gcc4.1, too, but doesn't get such flags.

It's 32bit, maybe glibc related?

I tryed modules and modprobe -v snd_via82xx didn't gave me anything
usefull, but now dmesg shows me:
ALSA sound/core/pcm_native.c:2594: unknown ioctl = 0x80144132
Is this usefull to work with?
-- 
Japie


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
