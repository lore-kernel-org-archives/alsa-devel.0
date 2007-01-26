From: <jmsgrtn-alsa@yahoo.com>
Subject: RE : Re: RE : Re: RE : Re: No sound with intel hda
	driver on a sony vaio vgx xl100 system
Date: Fri, 26 Jan 2007 22:02:01 +0100 (CET)
Message-ID: <796344.86727.qm@web36815.mail.mud.yahoo.com>
References: <s5hd55122zm.wl%tiwai@suse.de>
Reply-To: jmsgrtn-alsa@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd55122zm.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, jmsgrtn-alsa@yahoo.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

What i have tested :
using aplay or any other player do not give any sound, with or without the
model option.
e.g. aplay /usr/lib/openoffice/share/gallery/sounds/gong.wav do not give any
sound in my speakers

The mixer changes when i force the model :
without "model" option : only "master" and "pcm" playback exist
with "vaio" option, one "capture device appears, with 2 parameters : line-in
and microphone
with "vaio-ar", two more capture devices appear : line-in and microphone.

The "master" and "pcm" device are not muted.

Is there anoter parameter i missed to unmute the sound ?

Jean-Marc

--- Takashi Iwai <tiwai@suse.de> a =E9crit :

> At Thu, 25 Jan 2007 23:20:22 +0100 (CET),
> <jmsgrtn-alsa@yahoo.com> wrote:
> > =

> > When i force model "vaio" dmesg gives :
> > =

> > ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> > PCI: Enabling device 0000:00:1b.0 (0000 -> 0002)
> > ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
> > PCI: Setting latency timer of device 0000:00:1b.0 to 64
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_in=
tel.c:696:
> > codec_mask =3D 0x1
> > ALSA /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:1739:
> hda_codec:
> > model 'vaio' is selected
> > =

> > When i force "vaio-ar" :
> > =

> > ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> > PCI: Enabling device 0000:00:1b.0 (0000 -> 0002)
> > ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
> > PCI: Setting latency timer of device 0000:00:1b.0 to 64
> > ALSA
> >
>
/home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_in=
tel.c:696:
> > codec_mask =3D 0x1
> > ALSA /home/jm/tmp/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:1739:
> hda_codec:
> > model 'vaio-ar' is selected
> > =

> > What other information so you need ?
> =

> The facts:  What did you test and didn't work as expected?
> =

> Note that the mixer appearance should be different from the state
> without model option.
> =

> =

> Takashi



	=


	=

		=

___________________________________________________________________________ =

D=E9couvrez une nouvelle fa=E7on d'obtenir des r=E9ponses =E0 toutes vos qu=
estions ! =

Profitez des connaissances, des opinions et des exp=E9riences des internaut=
es sur Yahoo! Questions/R=E9ponses =

http://fr.answers.yahoo.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
