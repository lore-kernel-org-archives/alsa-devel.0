From: Gregoire Favre <greg@ulima.unil.ch>
Subject: pcm_native.c problem at compil time
Date: Sat, 26 Apr 2003 15:39:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030426133959.GA28411@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

just tried to compil the driver, and I got:

In file included from pcm_native.c:2:
../alsa-kernel/core/pcm_native.c: In function `snd_pcm_suspend_all':
../alsa-kernel/core/pcm_native.c:811: `runtime' undeclared (first use in
this function)
../alsa-kernel/core/pcm_native.c:811: (Each undeclared identifier is
reported only once
../alsa-kernel/core/pcm_native.c:811: for each function it appears in.)
make[1]: *** [pcm_native.o] Error 1


	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
