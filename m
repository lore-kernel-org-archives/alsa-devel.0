From: Paul Davis <paul@linuxaudiosystems.com>
Subject: crash trace under gdb
Date: Fri, 9 May 2003 10:05:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305091405.h49E5af01571@linuxaudiosystems.com>
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

well, it appears that the lock up occurs in a call to
__read_lock_failed, with the PC toward the end of __kill_fasync. it
alternates between two address that are both within that function,
different by 9 bytes.

ctrl-alt-sysreq couldn't provide a trace more than 1 call back. not
sure why.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
