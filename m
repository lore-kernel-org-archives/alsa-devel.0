From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: aplay CVS now works. alsamixer CVS is slightly odd.
Date: Sat, 21 Sep 2002 22:32:46 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020921213246.44092.qmail@web40604.mail.yahoo.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

With the latest changes to pcm.h and pcm.c, the CVS
version of aplay now works OK, thanks. However, the
CVS alsamixer seems to be displaying its graphics
incorrectly. Some of the columns (with the SB Live!
card) have no numbers underneath them, and the "Mic
Select" and "Mono Output Select" columns are missing
entirely except for the tags "Mic1" and "Mix"
respectively.

The rc3 alsamixer works OK with the CVS
libasound.so.2, and so I can add that all the
incorrect columns should have the value "0", although
not all of the zero-value columns are incorrect.

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
