From: peloy@chapus.net (Eloy A. Paris)
Subject: Santa Cruz (cs46xx) stopped working after 1-21-03
Date: 24 Jan 2003 10:28:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87u1fyk1n0.fsf@canaima.chapus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi!

My Turtle Beach Santa Cruz card is not working with current CVS code. I
downloaded several CVS snapshots and was able to trace the problem to
changes that happened between the 2003-01-21.tar.bz2 and
2003-01-22.tar.bz2 snapshots (probably in cs46xx_lib.c). So, if I want
to use my Santa Cruz I need to use the cs46xx driver from the 2003-01-21
snapshot.

In 2003-01-22 and later, I see this message when I load the cs46xx
modules:

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3326: cs46xx: cs46xx_setup_eapd_slot() - no secondary codec configured

With 2003-01-21 and before I don't see it.

If anyone needs help to troubleshoot this please let me know. I'll be
happy to try any patches or provide more information.

Cheers,

Eloy.-


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
