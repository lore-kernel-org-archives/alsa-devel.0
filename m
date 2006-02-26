From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Non-atomic code
Date: Sun, 26 Feb 2006 19:18:03 +0000
Message-ID: <1140981483.9540.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

Going through other drivers for ideas to write mine I notice lots of
non-atomic code where the instructions say there shouldn't be code that
can sleep eg

http://sosdg.org/~coywolf/lxr/source/sound/mips/au1x00.c?v=2.6.15#L143

which includes:

kmalloc(sizeof(au1000_period_t), GFP_KERNEL);

In a function called from the trigger callback.

How important is it that the code is atomic? it would make my life
easier if it didn't need to be!



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
