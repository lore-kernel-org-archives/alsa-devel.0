From: "P. Christeas" <p_christ@hol.gr>
Subject: Reproducible deadlock w. alsa/maestro3 when sleeping (ACPI,) 2.6.0-test1
Date: Mon, 14 Jul 2003 19:17:22 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307141917.22813.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: lkml <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have been experiencing some fully reproducible deadlock when waking from=
=20
sleep, using artsd over ALSA.
The scenario is:
I use ALSA, with the maestro3 device and everything else compiled as module=
s.
=46rom userspace, I launch artsd, which uses its native ALSA support to con=
nect=20
to /dev/pcmXXXXX .
I only have a custom script, which sleeps the machine by a 'echo 1>=20
/proc/acpi/sleep' . It does NOT stop alsa .
When the machine weaks, it has a deadlock. The suspended 'artsd' process wa=
its=20
for the /dev/pcmXXXX to become available (presumably; I can see 'D' on the=
=20
'ps' line), while the maestro3 module waits for the 'artsd' process to free=
 =20
/dev/pcmXXX .
I have tried to kill (w. 15, 9 etc.) the artsd process, rmmod the=20
'snd_maestro3' module (w. '-f' or '-l' options to rmmod). Nothing would=20
happen. In the worst case (after the rmmod), the whole module mechanism wou=
ld=20
lock as well ('lsmod' would hang ).
I could not find any relevant message for this case. However, on a subseque=
nt=20
sleep, the system refuses to sleep because it cannot suspend 'artsd'.

ps. My scripts (including module-init-tools) are definitely messy. However,=
=20
since 'artsd' or any ALSA client works in userspace and can be launched at=
=20
any time, I believe this problem leads to serious trouble for the system.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
