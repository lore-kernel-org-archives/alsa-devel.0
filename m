From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Trivial bug in aplay
Date: Sat, 6 Sep 2003 15:36:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309061536.02462.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

There seems to be a missing LF in the output of aplay --version:

/ # aplay --version
aplay: version 0.9.6 by Jaroslav Kysela <perex@suse.cz>/ #
/ #

It's obviously not serious! And I am too lazy to submit a patch for somet=
hing=20
this trivial :) But maybe should be fixed in the next version?

Best wishes

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
