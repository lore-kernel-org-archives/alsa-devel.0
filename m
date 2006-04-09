From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Adding a new architecture to alsa-driver
Date: Sat, 08 Apr 2006 20:56:43 -0400
Message-ID: <1144544204.22490.177.camel@mindpipe>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144542208.10642.9.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-04-09 at 01:23 +0100, Adrian McMenamin wrote:
> The changes you suggest simply are inadequate.

I am not surprised.  It should be a start though.  Did you create the
sh/Kconfig file?

>  There is no makefile
> without configure

Yes, there is.  Try a fresh CVS checkout of alsa-driver then "find -name
Makefile" - you'll see ./ppc/Makefile, ./sparc/Makefile, etc.

I would have to see your driver in the form of a patch against ALSA CVS
to comment further.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
