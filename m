From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: Please remove documentation pointer
Date: Mon, 15 Jul 2002 12:04:06 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPP.3.96.1020715113852.10952B-100000@hpux15.hrz.uni-oldenburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, webmaster@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

Alsa's documentation webbage "http://www.alsa-project.org/documentation.php3"
contains a link in section "ALSA 0.9.x Developer documentation" that
points to outdated documentation:

This link is labled "Howto use the ALSA API", and it points to
"http://www.op.net/~pbd/alsa-audio.html". The example programs presented
there do not work with the current alsa library. This link should at
least be moved out of section "ALSA 0.9.x Developer documentation". It's
quite confusing as it is now.

The only existing documentation on how to do full duplex audio
applications that I found seems to be the C source code of the jack audio
server. Maybe you can put a link to it's file "alsa_driver.c" in place of
the above link. (But this could have the side effect that any future alsa
audio application that uses full duplex is a derivative work of jack and
thus has to be licensed under the GPL)

  Tobias




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
