From: Ekatalog developers <developers-alsa@ekatalog.com.pl>
Subject: Aserver / network transparency
Date: Thu, 07 Jul 2005 20:55:36 +0200
Message-ID: <42CD7AA8.20403@ekatalog.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
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

Hi,

I am building xterminal networks. Nowaday, it needs sound support. I am
sick of arts/nas/esd etc. I'd like something very simple (no additional
buffering, mixing etc, lack of support in apps).

My idea is to add network transparency to alsa.
I've looked through alsa-lib and found aserver. I configured a chain to
use it. Sadly, alsamixer quickly freezes (but it works for a while), and
aplay fails with an error.

I'd like to make a contribution to alsa project. I will attempt to write
some documentation about aserver & co and make it work ok and work
through network (now it needs local unix socket).

I am completely new to alsa development (never written any app or driver
for it). What documentation should I read? What guidelines should I
comply with? I feel a bit lost in all this :).
How should the patches look like to get accepted?


bye,
Filip Zyzniewski
Ekatalog


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
