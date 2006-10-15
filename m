From: "Jaap Struyk" <japie@deserver.nl>
Subject: Re: problems with via82xx alsa part
Date: Sun, 15 Oct 2006 12:02:40 +0000 (UTC)
Message-ID: <egt810$628$1@sea.gmane.org>
References: <ef3pll$kng$1@sea.gmane.org> <efos3e$g63$1@sea.gmane.org>
	<s5hwt7ghsxd.wl%tiwai@suse.de>
	<1160121885.1790.2.camel@japie.deserver.nl>
	<s5hd595u1t3.wl%tiwai@suse.de>
	<1160325289.2558.2.camel@japie.deserver.nl>
	<s5hzmc5pb7c.wl%tiwai@suse.de>
	<1160499844.2449.5.camel@japie.deserver.nl>
	<s5hbqokm65g.wl%tiwai@suse.de> <eglrgk$vpi$1@sea.gmane.org>
	<s5hfydtiic4.wl%tiwai@suse.de>
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

Op Thu, 12 Oct 2006 18:56:11 +0200, schreef Takashi Iwai:

> Also don't strip libasound, of course.

I understand that ;-)

>> open("/dev/snd/controlC1", O_RDONLY|O_LARGEFILE ) = -1 ENOENT (No such file or
>> directory)
> 
> We never open devices with O_LARGEFILE.  Something is wrong in your
> alsa-lib.

Odd, I don't see why it is build like that, maybe it has something to do
with gcc-4.1, sometime when compiling certain apps I get 64bit related
errors, like my system is reconized as a 64bit system but I dont see why.
On the other hand, on my "working" system strace shows me that thats also
uses O_LARGEFILE but is working properly so it shouldn't mather.
I will try modules instead of builtin to see if there are some kernel
messages when loading them.
-- 
Greetings Japie


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
