From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: ALSA Driver for Sparc DBRI chips
Date: Sun, 21 Nov 2004 09:50:08 +0000
Message-ID: <20041121095008.GA18392@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: baccala@freesoft.org, rfkoenig@immd4.informatik.uni-erlangen.de
List-Id: alsa-devel@alsa-project.org

Hi,

I have been working on an ALSA driver for the DBRI/CS4215 chip
combo found in Sparc machines. It is a port of the 2.5 OSS driver.

Things are starting to work, but since this is my first major
undertaking I'm looking for your comments. Ask early, ask often...
At this point I expect playback to work to all possible outputs (there
is some clipping on 16 bit formats). I have not been able to get recording
output in a file, though it does seem to catch data.

So I look for anything from coding style to design issues to spelling to
'it worked' to 'I get an error' to the-meaning-of-the-universe.
Just keep the phasers on stun, please :)

At: http://www.mph.eclipse.co.uk/pub/linux/dbri
you'll find these files:
- dbri.c		Source code of the driver
- Alsa.patch		Patch against Alsa-driver 1.0.7rc1, without the driver
			code itself (pick up dbri.c and put it in
			alsa-kernel/sparc).
- Alsa-build.patch	Patched to make Alsa build for sparc drivers. This
			code is already in the current Alsa version, so you
			may not need it.
- Linux-2.6.8.patch	Patch against the Linux kernel (including the driver
			code). Will apply against other 2.6 kernels too.

Thanks for your time,
-- 
Martin
---------------------------------------------------------------------------
30 years from now GNU/Linux will be as redundant a term as UNIX/MERT is 
today. - Martin Habets
---------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
