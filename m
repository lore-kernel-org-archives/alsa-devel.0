From: Pavel Roskin <proski@gnu.org>
Subject: Abuse of EREMOTE and EREMOTEIO
Date: Thu, 8 Aug 2002 11:49:36 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208081140160.5370-100000@marabou.research.att.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I have noticed that some functions in ice1712.c return -EREMOTE.  "info 
libc" describes this error so:

 - Macro: int EREMOTE
     An attempt was made to NFS-mount a remote file system with a file
     name that already specifies an NFS-mounted file.  (This is an
     error on some operating systems, but we expect it to work properly
     on the GNU system, making this error code impossible.)

My interpretation of the code is that there is an communication error on 
the i2c bus.  That should be EIO:

 - Macro: int EIO
     Input/output error; usually used for physical read or write errors.

Please somebody with write access replace EREMOTE with EIO in 
alsa-kernel/i2c/cs8427.c and alsa-kernel/pci/ice1712.c.  There is also an 
occurence of EREMOTEIO (undocumented) in alsa-kernel/i2c/i2c.c - please 
replace it with EIO as well.

Those errors are only returned, there are no comparisons with EREMOTE or 
EREMOTEIO, so it should be safe.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
