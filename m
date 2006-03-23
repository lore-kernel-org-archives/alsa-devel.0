From: =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@stud.ntnu.no>
Subject: Re: Q: Compiling ALSA for 2.6.16
Date: Thu, 23 Mar 2006 14:28:47 +0100
Message-ID: <20060323132847.GA27484@stud.ntnu.no>
References: <20060323102614.GA19835@stud.ntnu.no> <s5h64m5jv9y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h64m5jv9y.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 23, 2006 at 11:43:53AM +0100, Takashi Iwai wrote:
> At Thu, 23 Mar 2006 11:26:14 +0100,
> Asbj=F8rn S=E6b=F8 wrote:
> >=20
> > In an attempt to get my vxpocet sound card to work (see thread at=20
> > alsa-user), I have installed the 2.6.16 kernel.  Now I would like to=20
> > have a suitably recent ALSA along with it.
> >=20
> > Should I go for the stable alsa release (1.0.10), or for the developm=
ent=20
> > release?
>=20
> 1.0.11rc4 please.  1.0.11 can't work with 2.6.15/16 kernels.
> [...]

OK.
All packages downloaded in version 1.0.11rc4 (except alsa-oss and=20
alsa-firmware, for which only 1.0.11rc3 were available)

All packages "./configure"-d and "make install"-ed.
(Exceptions: alsa-plugins, which needed a pkg-config script which I=20
don't have, and alsa-oss, which I currently have no use for, I think.)
For alsa-tools, I configure-d and make installed-ed in the vxloader=20
subdirectory, as it is the vxpocket I need support for.

However, after this (and after a reboot) "modprobe snd-vxpocket" gives=20
the error message:
------------
dhcp91:/home/asbjorn/alsa_dev_2006-03-23# modprobe snd-vxpocket
FATAL: Module snd_vxpocket not found.
FATAL: Error running install command for snd_vxpocket
------------------


Searching for "vx" in /lib/modules/2.6.16-rt5-realtime (the current=20
kernel) does not find the vxpocket module:
---------------------------
dhcp91:/home/asbjorn/alsa_dev_2006-03-23# uname -a
Linux dhcp91 2.6.16-rt5-realtime #1 PREEMPT Thu Mar 23 11:54:28 CET 2006 =
i686 GNU/Linux
dhcp91:/home/asbjorn/alsa_dev_2006-03-23# find /lib/modules/2.6.16-rt5-re=
altime/ |grep vx
/lib/modules/2.6.16-rt5-realtime/kernel/sound/drivers/vx
/lib/modules/2.6.16-rt5-realtime/kernel/sound/drivers/vx/snd-vx-lib.ko
/lib/modules/2.6.16-rt5-realtime/kernel/sound/pci/vx222
/lib/modules/2.6.16-rt5-realtime/kernel/sound/pci/vx222/snd-vx222.ko
--------------------------


I recompiled and re-installed the alsa-driver package, and as far as I=20
can see, the vxpocket module is neither compiled nor installed.


Asbj=F8rn



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
