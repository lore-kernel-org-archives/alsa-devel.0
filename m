From: Dave Andruczyk <djandruczyk@yahoo.com>
Subject: Lockups with emu10k1 on mandrake 8.2
Date: Fri, 22 Mar 2002 18:54:04 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020323025404.37190.qmail@web14106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received: from web14106.mail.yahoo.com (web14106.mail.yahoo.com [216.136.172.136])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id DAA15584
	for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2002 03:54:10 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



After managing to get alsa 0.9beta 12 compiled and install on a fresh ins=
tall
of mandrake 8.2,  loading worked fine.  running alsamixer in an xterm and
trying to unmute the channels,  alsamixer locked hard, couldn't move, cou=
ldn't
quit,  hard lock for that APP ONLY.  Tried loading gmix (it worked on 8.1=
 with
a 2.4.16-xfs kernel with no problems).  as soons as gmix loaded the syste=
m
locked solid, no mouse, nothing.  onlypower off would cure it..


upon power up part of the FS was hosed. (/etc/modules.conf was scrambled
leading to a whole host of issues.).  Not trusting the FS state, I reinst=
alled
again.   Tried OSS driver provided with the syetm (no compiling necessary=
).=20
Works great,  no lockups..

Are there issues with ALSA 0.9beta12 and the 2.4.18 kernel,  or more
specifically the Mandrake 8.2 2.4.18 kernel??

I'm currently stuck with OSS, but I want to be using ALSA..   Does anyone=
 have
any suggestions?

HW info:
Tyan Tiger MP Dual processor athlon 1.2 Ghz  MP's
512MB DDR 266Mhz, PC2100 RAM
NVIDIA Geforce4 MX440 Video(with NVIDIA's 1.0-2808 driver)
Symbios 53c1010-33 Ultra 3 scsi controller
Sound Blaster Live Value.

System ran completely stable on Mandrake 8.1 wiht a custom built 2.4.16-x=
fs
kernel (clean 2.4.16 + xfs 1.02 patch) with ALSA 0.9beta 12

System locks up immediately on using ALSA's OSS emulation (gmix) mixer, a=
nd
causes alsamixer to freeze solid upon running with Mandrakes 8.2's kernel
(2.4.18 + whatever vendor applied patches)

No core dumps, only lockups.  :(




=3D=3D=3D=3D=3D
Dave J. Andruczyk
Enterprise Resource Providers

__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards=AE
http://movies.yahoo.com/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
