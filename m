From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: alsa-lib make error
Date: Mon, 28 Jun 2004 01:37:30 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DEF7CA.8050109@boosthardware.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I get this error with latest cvs:

make[4]: Nothing to be done for `install-exec-am'.
/bin/sh ../../../mkinstalldirs /usr/share/alsa/cards/SI7018
  /usr/bin/install -c -m 644 ./SI7018/sndoc-mixer.alisp 
/usr/share/alsa/cards/SI7018/SI7018/sndoc-mixer.alisp
/usr/bin/install: cannot create regular file 
`/usr/share/alsa/cards/SI7018/SI7018/sndoc-mixer.alisp': No such file or 
directory
  /usr/bin/install -c -m 644 ./SI7018/sndop-mixer.alisp 
/usr/share/alsa/cards/SI7018/SI7018/sndop-mixer.alisp
/usr/bin/install: cannot create regular file 
`/usr/share/alsa/cards/SI7018/SI7018/sndop-mixer.alisp': No such file or 
directory

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
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
