From: robinud@volja.net
Subject: Change default sound card ?
Date: Tue,  8 Mar 2005 14:36:49 +0100
Message-ID: <1110289009.422daa71553ee@webmail.volja.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi!

Recently I tried to change my default sound card (I have two) and it seem=
s
more complicated than needed. (I am new to ALSA. If I overlooked a simple
solution, please point towards gently.)

Currently (alsa-1.0.8) it looks like this ( file locations might be debia=
n specific )

/usr/share/alsa/alsa.conf :

# defaults

defaults.ctl.card 0
defaults.pcm.card 0
defaults.pcm.device 0
defaults.pcm.subdevice -1
defaults.pcm.front.card defaults.pcm.card
defaults.pcm.front.device defaults.pcm.device
defaults.pcm.rear.card defaults.pcm.card
defaults.pcm.rear.device defaults.pcm.device
defaults.pcm.center_lfe.card defaults.pcm.card
defaults.pcm.center_lfe.device defaults.pcm.device
defaults.pcm.side.card defaults.pcm.card
defaults.pcm.side.device defaults.pcm.device
defaults.pcm.surround40.card defaults.pcm.card
defaults.pcm.surround40.device defaults.pcm.device
defaults.pcm.surround41.card defaults.pcm.card
defaults.pcm.surround41.device defaults.pcm.device
defaults.pcm.surround50.card defaults.pcm.card
defaults.pcm.surround50.device defaults.pcm.device
defaults.pcm.surround51.card defaults.pcm.card
defaults.pcm.surround51.device defaults.pcm.device
defaults.pcm.surround71.card defaults.pcm.card
defaults.pcm.surround71.device defaults.pcm.device
defaults.pcm.iec958.card defaults.pcm.card
defaults.pcm.iec958.device defaults.pcm.device
defaults.pcm.modem.card defaults.pcm.card
defaults.pcm.modem.device defaults.pcm.device
defaults.rawmidi.card 0
defaults.rawmidi.device 0
defaults.rawmidi.subdevice -1
defaults.hwdep.card 0
defaults.hwdep.device 0
defaults.timer.class 2
defaults.timer.sclass 0
defaults.timer.card 0
defaults.timer.device 0
defaults.timer.subdevice 0


This makes changing the default hard, as many changes are needed. For exa=
mple I want to use card 1
device 1 as default, I must change :

defaults.ctl.card 0
defaults.pcm.card 0
defaults.pcm.device 0
defaults.rawmidi.card 0
defaults.rawmidi.device 0
defaults.hwdep.card 0
defaults.hwdep.device 0
defaults.timer.card 0
defaults.timer.device 0


What about introducing :
defaults.card
and
defaults.device

and then use :
defaults.ctl.card defaults.card
defaults.pcm.card defaults.card
defaults.pcm.device defaults.device
defaults.rawmidi.card defaults.card
defaults.rawmidi.device defaults.device
defaults.hwdep.card defaults.card
defaults.hwdep.device defaults.device
defaults.timer.card defaults.card
defaults.timer.device defaults.device
+ the rest

This way to change the default, only two lines need change.

Sorry if the syntax is not correct, the idea should be clear thou.

Regards,
David


----------------------------------------------------------------
Varno. Enostavno. Vredno. Internet dodatne storitve.
http://www.voljatel.si/storitve/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
