From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: ALSA Aureal driver merged (soundcard matrix update)
Date: Sun, 12 Oct 2003 12:22:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065975744.1786.43.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
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
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

First of all i'm pleased to announce that there is now a driver merged
into the latest ALSA version, that supports the complete line of AUREAL
VORTEX / VORTEX2 / ADVANTAGE soundcards.

I would like to ask to update the soundcard matrix. Any soundcard using
a AU88x0 chip is supported.

At last, any bug reports are gladly welcome, and anyone owning a Aureal
AU88x0 soundcard are invited to test this new driver, which was written
from scratch, but supports many more features than the old binary driver
(hardware EQ), and more important than that, doesn't hang your computer
on any chipset (via+nvidia ...) like the old binary driver did. 

Anyone who wants to contribute, are gladly welcome to the Openvortex
project. There is much fun stuff coming, like hardware A3D (yeah, i mean
3D audio spatialization) support and wavetable. Maybe some day this can
be extended to other soundcards too (ESS maestro3 support HRTF's ?). Its
very disappointing to not have any working 3D audio interface today,
being HRTF's such an old technology.

Openvortex:
http://savannah.nongnu.org/projects/openvortex/

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
