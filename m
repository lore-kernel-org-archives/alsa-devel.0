From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: SGI/HAL2 architecture detection
Date: Fri, 3 Oct 2003 16:26:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031003212654.GA28811@dbz.icequake.net>
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


In latest kernels, the file /usr/src/linux/include/asm/sgi/sgihpc.h
has become /usr/src/linux/include/asm/sgi/hpc3.h.  Both files need to
be checked in configure.in now to determine SGI architecture.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
