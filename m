From: Pavel Roskin <proski@gnu.org>
Subject: Unnecessary files on CVS
Date: Thu, 3 Oct 2002 12:29:28 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210031046250.9111-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello!

Somebody please remove these files form CVS:

alsa-kernel/include/version.h
alsa-utils/install-sh
alsa-utils/missing
alsa-utils/mkinstalldirs
alsa-utils/include/aconfig.h.in
alsa-tools/ac3dec/config.h.in

They all are replaced by "cvscompile" even if they are present.  Then cvs 
shows that they have been locally modified.

I have checked that removal of those files doesn't affect the build from a
clean CVS working directory.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
