From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [Alsa-user] alsa-lib-0.9.0rc8 doesn't compile
Date: Fri, 7 Mar 2003 21:38:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030307203802.GG14305@tuba.home>
References: <Pine.LNX.4.44.0303070935400.1226-100000@pnote.perex-int.cz> <Pine.HPX.4.33n.0303071640110.20989-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0303071640110.20989-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "ben hubbard (listmail)" <lists@camorra.bus.indiana.edu>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 07, 2003 at 04:44:55PM +0100, Clemens Ladisch wrote:
> Jaroslav Kysela wrote:
> > [...]
> > The whole idea is that the jack module should not be built by default.
> > Unfortunately, it seems difficult to redirect the build targets from
> > automake for different versions.
> 
> The automake manual
> <http://www.gnu.org/manual/automake/html_chapter/automake_6.html#SEC29>
> says ext should not be put into SUBDIRS but into DIST_SUBDIRS.
> (I can't test it on this machine.)
> 

Yep, test ok. Alsa-lib compiles again. Just apply this patch therefore.
This fixes the so often reported problem:
pcm_jack.c:36: jack/jack.h: No such file or directory


martin



--- alsa-lib/src/pcm/Makefile.am.ORIGINAL	Fri Mar  7 20:58:08 2003
+++ alsa-lib/src/pcm/Makefile.am	Fri Mar  7 20:58:39 2003
@@ -1,4 +1,4 @@
-SUBDIRS = ext
+DIST_SUBDIRS = ext
 
 EXTRA_LTLIBRARIES = libpcm.la
 


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
