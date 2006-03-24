From: =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@stud.ntnu.no>
Subject: Re: Q: Compiling ALSA for 2.6.16
Date: Fri, 24 Mar 2006 12:33:00 +0100
Message-ID: <20060324113300.GE22993@stud.ntnu.no>
References: <s5h1wwtjn42.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1wwtjn42.wl%tiwai@suse.de>
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


On Thu, Mar 23, 2006 at 02:40:13PM +0100, Takashi Iwai wrote:
> At Thu, 23 Mar 2006 14:28:47 +0100,
> Asbj=F8rn S=E6b=F8 wrote:
> >=20
> > [Compiling the newest ALSA in an attempt to get a vxpocket to work]

> > I recompiled and re-installed the alsa-driver package, and as far as =
I=20
> > can see, the vxpocket module is neither compiled nor installed.
>=20
> I guess you didn't enable CONFIG_ISA (PC-card requires it) or proper
> PCMCIA kernel configs.=20

And right you were.  Enabling ISA solved this one.

I am still stuck, though.  The vxloader does not find the card. =20
And neither does alsaconf.
(See the log below of the attempt to set up the card.)

The insertion of the card is reported in the logs, so the system is at=20
least aware that a card is present.  And the module loads without any=20
error messages.  (Which should be a good thing, I would guess.) =20
(Output from a verbose module loading is shown at the bottom.)

I would have thought that as the module is loaded, the card is found and
set up, and after uploading of firmware it should be ready for use.
Can the module load without error messages if it does not find the card?
And if the module finds the card, why doesn't the firmware loader?

What do I do now?


Asbj=F8rn=20

-----------------------------
dhcp91:~# date
Thu Mar 23 22:34:46 CET 2006
dhcp91:~# uname -a
Linux dhcp91 2.6.16-rt5-realtime #1 PREEMPT Thu Mar 23 15:00:19 CET 2006 =
i686 GNU/Linux
dhcp91:~# # Insert vxpocket sound card
dhcp91:~# tail -3 /var/log/messages
Mar 23 22:32:47 dhcp91 kernel: Linux video capture interface: v1.00
Mar 23 22:32:47 dhcp91 kernel: [drm] Loading R200 Microcode
Mar 23 22:35:36 dhcp91 kernel: pccard: PCMCIA card inserted into slot 0
dhcp91:~# lsmod |grep vx
dhcp91:~# modprobe snd-vxpocket
dhcp91:~# lsmod |grep vx
snd_vxpocket           15200  0
pcmcia                 38716  1 snd_vxpocket
snd_vx_lib             33152  1 snd_vxpocket
snd_hwdep               9476  1 snd_vx_lib
snd_pcm                85920  5 snd_vx_lib,snd_intel8x0,snd_intel8x0m,snd=
_ac97_codec,snd_pcm_oss
snd                    52608  15 snd_vxpocket,snd_vx_lib,snd_hwdep,snd_in=
tel8x0,snd_intel8x0m,snd_ac97_codec,snd_pcm_os\
s,snd_mixer_oss,snd_pcm,snd_seq_dummy,snd_seq_oss,snd_rawmidi,snd_seq,snd=
_timer,snd_seq_device
dhcp91:~# vxloader
vxloader: no VX-compatible cards found
dhcp91:~#
---------------------------------


If the snd-vxpocket module is removed, and loaded again with the
"verbose" parameter to modprobe, this (below) is the output.  Does the
"ignore-install" have any significance with respect to the current=20
problem?
-------------------------------------------
dhcp91:~# modprobe -v snd-vxpocket
insmod /lib/modules/2.6.16-rt5-realtime/kernel/sound/acore/snd-hwdep.ko=20
insmod /lib/modules/2.6.16-rt5-realtime/kernel/sound/drivers/vx/snd-vx-li=
b.ko=20
insmod /lib/modules/2.6.16-rt5-realtime/kernel/lib/crc32.ko=20
insmod /lib/modules/2.6.16-rt5-realtime/kernel/drivers/pcmcia/pcmcia.ko=20
install modprobe --ignore-install snd-vxpocket  && /lib/alsa/modprobe-pos=
t-install snd-vxpocket
insmod /lib/modules/2.6.16-rt5-realtime/kernel/sound/pcmcia/vx/snd-vxpock=
et.ko=20
----------------------------------

----- End forwarded message -----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
