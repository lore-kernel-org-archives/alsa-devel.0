From: =?iso-8859-15?q?G=FCnther=20Montag?= <Safari.Doktor@addcom.de>
Subject: env LD_PRELOAD=/usr/lib/libaoss.so ....
Date: Thu, 16 Oct 2003 14:13:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310161413.28379.Safari.Doktor@addcom.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello friends
when I start my ham program with this preload
it says
***
hfkernel_user will be started by /usr/local/bin/hfkernel start
hfkernel[235]: hfkernel 0.4.1 starting...
ALSA lib pcm.c:1809:(snd_pcm_open_noupdate) Unknown PCM dsp0
hfkernel[235]: error: open: No such file or directory
***
although I called the soundcard right with /dev/dsp0,
the device is there (cat file > /dev/dsp0 gives a sound),
the same with /dev/adsp
somewhere (where?) on the way it seems to eat the /dev!

Another question:
I looked into the file alsa-lib-0.9.7/src/pcm/pcm.c, where this#
function snd_pcm_open_noupdate is,
thanjs Jaroslav for the very interesting documentation,
You made my day,
but if You have time tell me: it looks like html,
how  can I read it as html?

tnaks a lot
G=FCnther
Safari.Doktor@addcom.de


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
