From: Mark Knecht <markknecht@attbi.com>
Subject: Automounting my 1394 drives causes Alsa to not load...
Date: 01 Feb 2003 11:39:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044128364.4689.20.camel@Godzilla>
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   Bit of a problem. This is Redhat 7.3, PlanetCCRMA flow, and the
machine has 256MB. Alsa has been working reasonably well for me, but I
have two problems that I would really like to fix:

1) Old problem - if my MidiSport 2x2 is plugged in when I cold boot,
then Alsa gets loaded when the MidiSport is found. When I get to the
part of the boot process where Alsa is supposed to get started, I get a
'Failed' message, telling me Alsa is already running. Even this is OK,
but then later when Linux attempt to load the HDSP 9652 drivers, they
fail one out of two times saying they cannot allocate memory.

2) When I try to auto-mount my 1394 hard drives by creating an
auto-mount entry in /etc/fstab, they may not be turned on, which is
legal. However, in this situation Alsa always fails to load. I have to
make the drive 'noauto' to get Alsa to start correctly.

   Both of these problems seem to be solved by warm booting the system.
However, that takes time and I certainly shouldn't have to do that.

   What can I do to solve these problems so that Alsa will come up
correctly on my first cold boot.

Cheers,
Mark




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
