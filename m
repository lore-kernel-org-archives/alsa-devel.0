From: vollmer.philipp@t-online.de (Philipp Vollmer)
Subject: Emptying read buffer
Date: Fri, 4 Oct 2002 18:46:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210041846.22642.vollmer.philipp@t-online.de>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm playing soundfiles in read/write fullduplex mode, but I have one
problem:

When I'm playing this file, I'm not able to empty the buffer, because
it needs too much CPU load. And after 2 or 3 seconds
the buffer is full and the app crashes. Is there a possibility to
empty the buffer without any reading? Or is there any function
to suspend the read handle, without closing it so that I can=20
playback data?

Thanks for any answer

73 Phil


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
