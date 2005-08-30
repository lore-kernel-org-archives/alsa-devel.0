From: Tom Watson <sdc695@yahoo.com>
Subject: Question about Surround (4.0) and the Revolution 7.1 card
Date: Mon, 29 Aug 2005 19:59:08 -0700 (PDT)
Message-ID: <20050830025908.30143.qmail@web60824.mail.yahoo.com>
References: <20050830002654.0468C33DB5@sc8-sf-spam1.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050830002654.0468C33DB5@sc8-sf-spam1.sourceforge.net>
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

In futzing around with the M-Audio Revolution card and newer ALSA (1.0.10=
rc1),
I found that surround40 doesn't appear to work.  It gives an invalid slav=
e
channel:

[tsw alsa]$ aplay -Dsurround40 quad_id.wav
ALSA lib pcm_route.c:1005:(snd_pcm_route_load_ttable) Invalid slave chann=
el: 4
aplay: main:540: audio open error: Invalid argument

Of course, using 'default' works just fine (without the '-DSurround40'). =
 This
is an example the problem I'm having.  I believe that this because someth=
ing
changed in the Revo driver.  Here are some files that I believe shed some=
 light
on the problem:

>>>>>>>>>>The soundcard list from 'aplay':
[tsw alsa]$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Revolution71 [M Audio Revolution-7.1], device 0: ICE1724 [ICE1724=
]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Revolution71 [M Audio Revolution-7.1], device 1: IEC1724 IEC958
[IEC1724 IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Revolution71 [M Audio Revolution-7.1], device 2: ICE1724 Surround=
s
[ICE1724 Surround PCM]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2

>>>>>>>A portion of ICE1724.conf
...
ICE1724.pcm.surround40.0 {
        @args [ CARD ]
        @args.CARD {
                type string
        }
        type route
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.4 1
        ttable.3.5 1
        slave {
                channels 4
                pcm {
                        type hw
                        card $CARD
                }
        }
}
...

All I know is that something changed in recent versions.  I was using one
of the 0.9.x versions and (insert doubting words here) it did work.

I think it is because the device seperates the "normal" (front) channels
from the "surround" (the other 6) channels.  Are the routes correct?

I'm not an expert in the configuration files, thus the message.

Thanks


--=20
Tom Watson
tsw@johana.com


	=09
____________________________________________________
Start your day with Yahoo! - make it your home page=20
http://www.yahoo.com/r/hs=20
=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
