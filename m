From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: 1.0.13 and hdsp cardbus
Date: Thu, 12 Oct 2006 12:36:32 -0400
Message-ID: <1160670992.4665.27.camel@localhost.localdomain>
References: <70a871c80610050541r73bbc2d7j408595802bb2c43f@mail.gmail.com>
	<4525F73D.2040105@chello.at>
	<70a871c80610060027l4196fdfi7b7ecd215733a7b3@mail.gmail.com>
	<45264A94.6010504@chello.at>
	<70a871c80610060709s73c87f03u31f4e91af077da46@mail.gmail.com>
	<4526D56E.1000904@chello.at>
	<70a871c80610070341q3104c89ne76bd70dd6be035e@mail.gmail.com>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <70a871c80610070341q3104c89ne76bd70dd6be035e@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-10-07 at 14:41 +0400, Dmitry Baikov wrote:
> 1) booting with plugged cardbus
>     card works
>    after unplugging, writes: card ejected from slot 0
>    all subsequent cardbus insertions/removals are not detected.
>    Not a single word in syslog.

this has been the case for quite a long time. my laptop has a cardbus
eject button that is too easy to hit, and i have never seen a kernel i
couldn't hang/crash by accidentally hitting it and then finishing the
full "press" by hand.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
