From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: ALSA-CVS: Card ID problem - too many symbolic links
Date: Sun, 3 Nov 2002 15:40:27 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021103154027.96438.qmail@web40607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

Here is what my /proc/asound directory looks like with
the latest ALSA CVS:

$ ls -als /proc/asound/
total 0
   0 dr-xr-xr-x    7 root     root            0 Nov  3
15:38 .
   0 dr-xr-xr-x  111 root     root            0 Oct 30
23:08 ..
   0 lrwxrwxrwx    1 root     root            0 Nov  3
15:38 ICH -> ICH
   0 lrwxrwxrwx    1 root     root            0 Nov  3
15:38 SB-Live -> SB-Live
   0 dr-xr-xr-x    7 root     root            0 Nov  3
15:38 card0
   0 dr-xr-xr-x    4 root     root            0 Nov  3
15:38 card1
   0 -r--r--r--    1 root     root            0 Nov  3
15:38 cards
   0 dr-xr-xr-x    2 root     root            0 Nov  3
15:38 dev
   0 -r--r--r--    1 root     root            0 Nov  3
15:38 devices
   0 -r--r--r--    1 root     root            0 Nov  3
15:38 hwdep
   0 dr-xr-xr-x    2 root     root            0 Nov  3
15:38 oss
   0 -r--r--r--    1 root     root            0 Nov  3
15:38 pcm
   0 dr-xr-xr-x    2 root     root            0 Nov  3
15:38 seq
   0 -r--r--r--    1 root     root            0 Nov  3
15:38 timers
   0 -r--r--r--    1 root     root            0 Nov  3
15:38 version

The problem is that both my "Card ID" symbolic links
are now pointing to themselves. (Module option "ID=").

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
