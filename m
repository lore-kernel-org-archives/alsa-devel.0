From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: mips fix
Date: Sun, 7 Sep 2003 22:36:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030908033657.GB2359@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


In configure.in:
  mips*)
    c_opts="-mcpu=r4600 -G 0 -mips2 -fno-pic -mno-abicalls -mlong-calls"
    processor="mips"
    test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
    ;;


-mcpu apparently needs to be changed for latest versions of gcc, as -mcpu
is no longer an option on mips architecture.

Anyone else build ALSA on mips recently?

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
