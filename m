From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Problem with my test driver
Date: Sun, 7 Sep 2003 19:47:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309071947.09343.adrian@mcmen.demon.co.uk>
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

I am building a driver for the Sega Dreamcast (sorry for all those who ha=
ve=20
heard this before). I get this when I attempt to see it using aplay:

/ # aplay -l
ALSA lib control.c:612:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:199: control open (0): No such file or directory
aplay: conf.c:3110: snd_config_update_free: Assertion `update->count > 0 =
&&=20
update->finfo' failed.
Aborted


Can someone tell me what my driver is missing?

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
