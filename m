From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: 1.0.4rc from cvs-head: snd-usb-usx2y still needs snd-hwdep....
Date: Thu, 1 Apr 2004 10:12:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404011012.10249.annabellesgarden@yahoo.de>
References: <200403310119.34195.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0403310910110.1950@pnote.perex-int.cz> <20040331185719.GA9281@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040331185719.GA9281@tuba.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 31 M=E4rz 2004 20:57 schrieb Martin Langer:
> On Wed, Mar 31, 2004 at 09:10:17AM +0200, Jaroslav Kysela wrote:
> > On Wed, 31 Mar 2004, Karsten Wiese wrote:
> > > ..., which is not built.
> > > this is for kernel 2.4.
> > >
> > > /etc/asound/driver_args:
> > > --with-cards=3Dvia82xx,msnd-pinnacle,usb-audio,usb-usx2y,es1968
> > > --with-kernel=3D/usr/src/linux-2.4 --with-debug=3Dfull --with-sequenc=
er=3Dyes
> >
> > Fixed.
>
> Really?
Yes! rm every file in alsa-driver, re-update from cvs and ./cvscompile.
There might be a simpler solution though...
>
> ./configure --with-cards=3Dusb-usx2y
>
> /sbin/depmod -ue
>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.25-rc1/kernel/sound/usb/snd-usb-audio.o
> depmod:         snd_rawmidi_transmit_peek
> depmod:         snd_rawmidi_transmit_ack
> depmod:         snd_rawmidi_transmit_empty
> depmod:         snd_rawmidi_receive
> depmod:         snd_rawmidi_new
> depmod:         snd_rawmidi_set_ops
didn't see this.

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.25-rc1/kernel/sound/usb/usx2y/snd-usb-usx2y.o
> depmod:         snd_hwdep_new
this was here also until I applied above measure.

Cheers,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
