From: <maniacdavid@cableone.net>
Subject: RE: Re: Audigy 2 support - update
Date: Sat, 24 May 2003 19:27:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a38101c32265$23ec8410$2900740a@cableone.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
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

I have the same problem that I posted a while ago on.=20

Thanks
David=20
maniacdavid@cableone.net



-----Original Message-----
From:	"alsa-devel-admin@lists.sourceforge.net" =
<alsa-devel-admin@lists.sourceforge.net> on behalf of	"Arcady Genkin" =
<agenkin@thpoon.com>
Sent:	Sat, 24 May 2003 14:47:15 -0400
To:	"Stephen Hassard" <steve@hassard.net>
Cc:	"alsa-devel@lists.sourceforge.net" =
<alsa-devel@lists.sourceforge.net>
Subject:	Re: [Alsa-devel] Re: Audigy 2 support - update

Stephen Hassard <steve@hassard.net> writes:

> On that note, does anyone know if you can purchase a digital IO
> module for the Audigy2 separate from the Platinum package? I
> wouldn't mind finding one that sits over a PCI slot in my chassis. I
> don't like cables that hang out the front of my case.

Have a look at Audigy2 Platinum EX.  Essentially, it's the same as the
regular platinum (i.e. it comes with an internal PCI card), but
instead of the LiveDrive there is an external module full of I/O
connectors.

I have the Audigy2 Platinum Ex, which I purchased for the same reason
as you.  However, I still could not get Alsa's emu10k1 driver to work
with it (neither the recent CVS version, nor the 0.9.3 series). :(  I
get the following error.  SB's emu10k1 driver works, though.

,----[ modprobe output ]
| ice alsa-driver # modprobe snd-emu10k1
| /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: \
|   init_module: No such device
| Hint: insmod errors can be caused by incorrect module parameters, \
|   including invalid IO or IRQ parameters.
|       You may find more information in syslog or the output from dmesg
| /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod \
|   /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o failed
| /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod \
|   snd-emu10k1 failed
`----

,----[ dmesg output ]
| PCI: Found IRQ 11 for device 02:05.0
| PCI: Sharing IRQ 11 with 00:1f.3
| PCI: Sharing IRQ 11 with 02:01.0
| ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2089: AC'97 0:0 does not =
respond - RESET
| EMU10K1/Audigy soundcard not found or device busy
`----
--=20
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
