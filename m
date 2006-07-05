From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: macro `AM_PATH_ALSA' not found in library
Date: Wed, 05 Jul 2006 18:20:26 -0400
Message-ID: <1152138027.15837.174.camel@mindpipe>
References: <1152127459.15837.127.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1152127459.15837.127.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-07-05 at 15:24 -0400, Lee Revell wrote:
> I have a script that builds alsa-lib and alsa-utils for an embedded
> platform.
> 
> It works perfectly on all my Ubuntu machines.  But when I try it on an
> FC4 box, alsa-lib builds correctly, but alsa-utils fails like so:
> 

OK, I've tried to resolve this by having my script run "cvscompile".
But it stops at:

"Copying file m4/xsize.m4

Please run 'aclocal -I m4' to regenerate the aclocal.m4 file.
You need aclocal from GNU automake 1.5 (or newer) to do this.
Then run 'autoconf' to regenerate the configure file.

You might also want to copy the convenience header file gettext.h
from the /usr/share/gettext directory into your package.
It is a wrapper around <libintl.h> that implements the configure
--disable-nls
option.

Press Return to acknowledge the previous two paragraphs."

I cannot press return here because I must be able to build
non-interactively using a script.

How can I silence these warnings?  Even if I run "aclocal -I m4" then
"autoconf" I still get this prompt on the next build.

Lee




Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
