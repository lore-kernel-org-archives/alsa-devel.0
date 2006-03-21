From: Lee Revell <rlrevell@joe-job.com>
Subject: Skype
Date: Tue, 21 Mar 2006 18:32:33 -0500
Message-ID: <1142983954.4532.189.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I am afraid the well known Skype+aoss problems may be unfixable from the
ALSA side. It appears that the Skype binary is self modifying and takes
extensive measures to make sure it is not being run in a debugger or
emulator. This almost certainly would eliminate any LD_PRELOAD hacks
from working.

http://www.secdev.org/conf/skype_BHEU06.handout.pdf [^]

I believe the only solution to get Skype working with dmix etc. is for
the Skype developers to add proper native ALSA support.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
