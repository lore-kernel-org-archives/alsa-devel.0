From: Andrew Burgess <aab@cichlid.com>
Subject: cvs build help
Date: Sun, 31 Aug 2003 10:34:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308311734.h7VHY1612936@cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

How do I get rid of the "-I/lib/modules/2.4.22-pre6/build/include" in the CFLAGS
when building cvs? My kernel is 2.4.23-pre2

I did:

 build prep
 build config
 build clean
 build all

and still it insists on 2.4.22-pre6

Is it left over from a previous build? I think I did run this kernel
in the past. I know hand editing all the files where it appears isn't
the answer :-)

Must I always do a cvs get in an empty directory tree? I'll do that
now but would like to know the correct way to just update my tree, if
possible.

Thanks very much
Andrew



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
