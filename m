From: Paul Davis <paul@linuxaudiosystems.com>
Subject: CVS broken under gdb
Date: Fri, 9 May 2003 09:42:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305091342.h49DgeF00827@linuxaudiosystems.com>
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

after a CVS update yesterday, i can no longer debug any JACK client
under gdb. interrupting gdb with ctrl-c causes my entire system to
lock up, immune even to Ctrl-Alt-SysReq. the exact driver doesn't seem
to matter: i've tried it with the trident and the hdsp drivers (two
different cards).

very painful. i'm going to try debugging from a console and see if i
can get a trace on the kernel.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
