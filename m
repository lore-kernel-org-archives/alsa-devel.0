From: Tobias Deiminger <tobias.deiminger@ngi.de>
Subject: Can't record properly with cmi8738 card
Date: Tue, 9 Sep 2003 12:34:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308241501.58837.tobias__7241.2152695053$1063096402@rueckverdumung.de>
Reply-To: tobias.deiminger@ngi.de
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

I've posted this to alsa-user, but didn't get a useful response. So I pos=
t it=20
here again (sorry):=20

I've got this card (Anubis Typhoon):
[CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                     C-Media PCI CMI8738-MC6 (model 55) at 0xd400, irq 10

and i'm using alsa 0.9.6.

I want to record something via mic-in using DAP for example. When I tried=
 it=20
the first time, i could only record a very low signal (although the signa=
l=20
was monitored clean and loud to the speakers). Then I turned off the=20
"mic-to-center" switch as described at alsa-project.org. Now the recorded=
=20
signal was higher, but still to low to work properly with it. What's wron=
g?=20
Mic-capture is on, mic and mic-caputre are set to max and mic-boost is on=
=2E Is=20
this a general problem with this card/driver?

(recording via line-in doesen't work at all, but that's not so bad becaus=
e I=20
only want to record guitar/microphone. CD recording works fine.)




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
