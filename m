From: =?ISO-8859-1?Q?tapio_laxstr=F6m?= <tapio@iptime.fi>
Subject: USB Audio - assertion
Date: Fri, 05 Jul 2002 15:51:33 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D259655.9090604@iptime.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Seems like USB Audio driver doesn't want to be on /dev/mixer0 ;)
(ecasound thru /dev/dsp0 works fine but xmms, which wants to use mixer,=20
fails).

I didn't check the code; is it just buggy assertion or something else?

Current cvs version seems to work fine with my Emagic EMI 2|6 (on=20
/dev/dsp1).

---clip---
[root@zappa asound]# insmod snd-usb-audio ; insmod snd-maestro3
Using /lib/modules/2.4.19-pre8/kernel/sound/usb/snd-usb-audio.o
Using /lib/modules/2.4.19-pre8/kernel/sound/pci/snd-maestro3.o
[root@zappa asound]# cat cards
0 [card0          ]: USB-Audio - USB Audio Driver
                      EMAGIC GmbH Emagic EMI 2|6
1 [card1          ]: Allegro - ESS Allegro PCI
                      ESS Allegro PCI at 0x1400, irq 5
[root@zappa asound]# xmms
xmms: simple.c:1376: snd=5Fmixer=5Fselem=5Fget=5Fplayback=5Fvolume: Asserti=
on=20
`(unsigned int) channel < s->str[0].channels' failed.
Aborted
[root@zappa asound]# rmmod snd-usb-audio ; rmmod snd-maestro3
[root@zappa asound]# insmod snd-maestro3 ; insmod snd-usb-audio
Using /lib/modules/2.4.19-pre8/kernel/sound/pci/snd-maestro3.o
Using /lib/modules/2.4.19-pre8/kernel/sound/usb/snd-usb-audio.o
[root@zappa asound]# xmms
[root@zappa asound]# cat cards
0 [card0          ]: Allegro - ESS Allegro PCI
                      ESS Allegro PCI at 0x1400, irq 5
1 [card1          ]: USB-Audio - USB Audio Driver
                      EMAGIC GmbH Emagic EMI 2|6


--
best regards
--
tapio laxstr=F6m



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
