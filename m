From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: USB audio kernel panic
Date: Sat, 08 May 2004 17:04:56 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <409C94A8.6010703@boosthardware.com>
References: <409B0D89.6090503@boosthardware.com> <20040507140321.28777db8@laptop> <409C687E.8010702@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Using the latest usb-audio code from cvs I get a kernel panic when 
loading the drivers. After that I cannot unload the modules and have to 
reboot if I want to try again.

This doesn't happen with the hdsp driver or cmipci driver which I also use.

I'm running kernel-2.2.21 with gcc-2.95.4

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
