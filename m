From: Michal Seta <mis@creazone.com>
Subject: Re: powermac build fails
Date: Mon, 30 Sep 2002 22:52:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020930225202.421488e7.mis@creazone.com>
References: <20020924231609.GC3369@debian> <s5h7khanx6p.wl@alsa2.suse.de>
 <20020930183705.GA14193@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20020930183705.GA14193@debian>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Sep 2002 11:37:05 -0700
brett-alsa@kavi.com wrote:

> Are either of these documented somewhere? 

from the 'INSTALL' file, which should get downloaded from CVS (inside alsa-lib directory, which should be the first one to compile and install):

<snip stuff>
Compilation from CVS sources
----------------------------

You need also GNU packages automake and libtool installed in your system
to compile CVS sources of alsa-lib package.

For compilation you can use these commands:

        libtoolize --force --copy --automake
        aclocal
        autoheader
        automake --foreign --copy --add-missing
        autoconf
        ./configure
        make

The included cvscompile script does this job for you.

Note: Some automake packages have missing aclocal program. Use newer version
      in the case.


<snip some more>


HTH.
-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis
CreaZone		http://www.creazone.com
No One Receiving	http://www.noonereceiving.32k.org

upcoming release:
NOR - "The Release of the Wandering-Eyed Girl"
	http://www.grainofsound.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
