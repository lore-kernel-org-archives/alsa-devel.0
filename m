From: Immanuel Litzroth <immanuell@enfocus.be>
Subject: make install for alsa-lib 0.9.1
Date: 13 Mar 2003 12:55:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2llzja3c4.fsf@enfocus.be>
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


I use stow for package management and I noticed that 
./configure --prefix=/usr
make 
make install prefix=/usr/stow/alsa-lib
still installs the libraries in /usr/lib. Previous versions worked
installed in the correct place. Is this a bug?
Immanuel

--
I have always been fascinated by those who want to work.
Prunesquallor - Ghormenghast
Immanuel Litzroth
Software Development Engineer
Enfocus Software
Kleindokkaai 3-5
B-9000 Gent
Belgium
Voice: +32 9 269 23 90
Fax : +32 9 269 16 91
Email: Immanuell@enfocus.be
web : www.enfocus.be
***************************************************************************



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
