From: Antonio Willy Malara <behappy@maialone.com>
Subject: usx2y nightmare
Date: Wed, 06 Oct 2004 00:38:41 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1097023122l.2120l.2l@Zeryn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

i've tried to apply the karsten's patches but i cant manage to get the =20
kernel compiling, here's what i've done:

* got vanilla 2.6.8.1
* patched with patch-2.6.9-rc3
* untarred the usx2y_0.8.2+linux-2.6.9-rc2-mm4-S7.tar.gz and copied
  to the kernel tree
* configured and compiled the kernel

but there's something i've missed, because:

[...]
  LD [M]  sound/usb/snd-usb-lib.o
  LD      sound/usb/usx2y/built-in.o
  CC [M]  sound/usb/usx2y/usbusx2y.o
  CC [M]  sound/usb/usx2y/usbusx2yaudio.o
  CC [M]  sound/usb/usx2y/usX2Yhwdep.o
  CC [M]  sound/usb/usx2y/usx2yhwdeppcm.o
  LD [M]  sound/usb/usx2y/snd-usb-usx2y.o
sound/usb/usx2y/usx2yhwdeppcm.o(.text+0x174c): In function =20
`usX2Y_audio_create':
: multiple definition of `usX2Y_audio_create'
sound/usb/usx2y/usbusx2yaudio.o(.text+0x174c): first defined here
make[3]: *** [sound/usb/usx2y/snd-usb-usx2y.o] Error 1
make[2]: *** [sound/usb/usx2y] Error 2
make[1]: *** [sound/usb] Error 2
make: *** [sound] Error 2

someone can help me having a clue with all those patches? :)

wil
---
Il jazz e' lasciare che la luce brilli, lasciarla essere.
		-- Keith Jarrett




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
