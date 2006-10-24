From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: (no subject)
Date: Tue, 24 Oct 2006 21:08:27 +0200
Message-ID: <m2r6wx1qhg.fsf@vador.mandriva.com>
References: <66e2865bf4a72dae46566dc04c1a0397@192.168.1.254>
	<08893603f9fbf36bdfc7189f5ae6d856@192.168.1.254>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <08893603f9fbf36bdfc7189f5ae6d856@192.168.1.254> (Ricardo
	Cerqueira's message of "Fri, 20 Oct 2006 19:16:19 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ricardo Cerqueira <ricardo@cerqueira.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ricardo Cerqueira <ricardo@cerqueira.org> writes:

> >>> > Check alsa-kernel hg tree whether you have a changeset 4658
> >>> > "Fix re-use of va_list" (although it should work even without
> >>> > this patch on i386).
> >>>
> >>> Yes, I'm at changeset 4662... I checked core/info.c by hand, and
> >>> the va_list change is there... I just tried cloning fresh copies
> >>> of alsa-kernel and alsa-driver, and the result is the same.
> >>
> >> Weird.  Could you check whether really it's 4k boundary problem?
> > 
> > Looks like it is:
> 
> OK... The resize call is never reached (the break clause is always
> true).  I added a small printk before the size test, and got:
> 
> DEBUG - res=48 and len=74
> DEBUG - res=25 and len=26
> DEBUG - res=0 and len=1
> DEBUG - res=0 and len=1
> DEBUG - res=0 and len=1
> 
> And from here on, vsnprintf always returns 0. From my understanding
> of the documentation, it shouldn't happen, but... (maybe a glibc
> bug?)

core/info.c is kernel land, no glibc code is used there

> Changing the "if (res < len)" to "if (res && res < len)" solves it,
> but I don't know if there'll be other side effects.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
