From: peloy@chapus.net (Eloy A. Paris)
Subject: cs46xx: failure waiting for FIFO command to complete
Date: 24 Jan 2003 10:32:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87ptqmk1gy.fsf@canaima.chapus.net>
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

I am getting this message when I load the cs46xx module:

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:468: cs46xx: failure waiting for FIFO command to complete

I think it does not happen when I boot the machine, i.e. the first time
the card is initialized. It seems to happen only after the card has been
initialized and I stop ALSA and then start it again (unload and reload
modules.)

It seems pretty harmless because everything works just fine, but I
wonder if anyone knows the reason fot the message. I searched the
mailing list archives and didn't find anything relevant.

Cheers,

Eloy.-


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
