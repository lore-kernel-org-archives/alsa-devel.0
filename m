From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: transport control bug...
Date: Fri, 12 Dec 2003 22:29:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FDA3351.4030106@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hello everyone!

i have jamin and ardour running. ardour reacts nicely to the "to start"=20
and "to end" transport control buttons. now when i press "play" in=20
jamin, the playhead in ardour starts moving, but no sound is heard.
this happens regardless of the "jack transport master" setting in the=20
options dialog.
otoh, when i press "play" in ardour, everything is fine. can anyone=20
reproduce this? if so, i'll put it up in mantis.

both ardour and jamin are current cvs from less than 6 hrs ago.

(btw, what does the "jack transport master" option mean ? my=20
understanding is that any client can issue transport commands...)

best,
j=F6rn

--=20
Happy Birthday, Professor !
Noam Chomsky, born Dec 7, 1928

J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxaudiodev.org (Linux Audio Developers)





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
