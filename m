From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [usb-midi-fw-devel] proposal concerning cooperation of snd-usb-usx2x.o and rbtload
Date: Fri, 29 Aug 2003 20:12:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308292012.06078.annabellesgarden@yahoo.de>
References: <200308282352.54486.annabellesgarden@yahoo.de> <200308291734.20533.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308291734.20533.plcl@telefonica.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>, usb-midi-fw-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, "'us428@drehmoment.org'" <us428@drehmoment.org>
List-Id: alsa-devel@alsa-project.org

Am Freitag 29 August 2003 17:34 schrieb Pedro Lopez-Cabanillas:
> El Jueves, 28 de Agosto de 2003 23:52, Karsten Wiese escribi=F3:
> > when a hotplug occurs (EZUSB Firmware not being looked at here, works as
> > before), the kernel
> > 1.) asks snd-usb-us428.o, if it wants to have the device. snd-usb-us428=
=2Eo
> > says 'yes!'. this latest snd-usb-us428.o will not start any ALSA-Activi=
ty
> > in this stage. It just owns the interface to the us428 (and implements 2
> > new ioctl-able entriepoints).
>
> ...assuming that your module (snd-usb-us428) is already loaded, or it is
> statically linked into the kernel. Anyway, hotplug will load the module if
> it's not loaded yet.
>
> > 2.) starts rbtload (by means of the hotplug-scripts) to download the fp=
ga
> > code. this hacked rbtload does the download by means of standard ioctl()
> > - calls to snd-usb-us428.o. Thus we don't need libusb here anymore.
> > (libusb is still used here for minimizing changing efforts.) if download
> > is finished, snd-usb-us428.o ALSA-Activities are started by another ioc=
tl
> > to snd-usb-us428.o.
> >
> > Result: us428 works as before.
> >
> > What do you think about setting up a 0.2 this way?
>
> Not sure. You explained what you are doing, but not why you are doing tha=
t.
> I don't have a us428 or us122 here, so I can't test it myself.
>
> I can guess that there is a problem if you try to use rbtload when the
> kernel driver is already loaded locking the USB interface, and forces
> rbtload to fail. Another issue is that rbtload can be rewritten without
> libusb at all.
>
> But perhaps you have found some other issues. A good starting point could
> be to share your concerns, and after that we can try to find the best
> solution for them. Of course we can arrive to the conclusion that your ha=
ck
> is the best solution at all, but please: let's talk first.
>
the sequence first 'Module load' then 'hotplug script start' is hardcoded i=
n=20
the kernel's usb.c.=20
Before FPGA download, the usx2x dont work. So it is useless to start=20
ALSA-activities at this stage. None the less the module has to say 'YES, I=
=20
want the device' now. (Maybe there are other ways for an USB-module to get=
=20
attached to their device(s) but I could not find them.)
The usx2x keep their USB ProductIDs after the FPGA load, so the kernel does=
n't=20
see a 'new' device and thus wont ask the module again.
We know rbtload_0.1 can't download with a module owning the target (interfa=
ce=20
claim must fail).=20
So before rbtload getting involved, we could unload the module, rbtload and=
=20
load the module again?=20
Yes, but what if there where more then 1 usx2x attached to the system? unlo=
ad=20
would fail, if 1 usx2x would be in use.

<<some minutes break>>

Just received an email from Takashi. He asks why not do it like he=20
did it before for the vx interfaces.
I found the driver code. The firmware downloader vxloader is part of=20
alsa-tools.
as far as i can see it works like I outlined above, except that ALSA alread=
y=20
has a sceleton for this purpose.
If you are curious, grep for  snd_hwdep_dsp_image_t.
Now I think I'll make use of that so called 'hardware dependant interface' =
in=20
the us428 module. Then there should be rbtload 0.2 using this interface fro=
m=20
userspace to download the firmware and actually start the ALSA-functions of=
=20
the usx2x.=20

regards,
Karsten



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
