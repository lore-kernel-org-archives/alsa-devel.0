From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP driver update
Date: 07 Apr 2003 13:31:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049715111.2616.27.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Here's the long awaited hdsp driver update, sorry for the delay. No file
included in this post (they're too big). Jaroslav or Takashi, you can
get them from here:
http://www.undata.org/~thomas/

hdsp.c is a replacement for the actual hdsp.c file in
alsa-kernel/pci/rme9652/

hdsp.h should be placed in alsa-kernel/include

hdsploader is the firmware loading tool. It can be included to
alsa-tools. The firmware files can be removed from
alsa-kernel/pci/rme9652/, they are included with the archive (the 4 of
them).

hdspconf is a fltk gui for the card, it can also be included to
alsa-tools.

The driver now depends on the hwdep interface, the snd-hdsp entry of the
alsa-kernel/core/Makefile should be edited to add this dependency.

This driver should solve issues with the rev11 firmwares and the
hdsp9652 cards.

The card won't work until the firmware is uploaded with the hdspload
tool. In case the firmware gets lost (e.g. power supply failure), just
try to access the card again and the firmware will get uploaded back
from kernel cached version, or run the loader again. Note that at this
point the card will be reset to its default values (your mixer settings
will be lost). 

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
