From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: hdsp I/O-error
Date: Sun, 13 Apr 2003 02:37:23 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304130237.24281.Jaakko.Prattala@Helsinki.FI>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI> <200304121240.17736.Jaakko.Prattala@Helsinki.FI> <1050176702.1427.681.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050176702.1427.681.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Saturday 12 April 2003 22:45, Thomas Charbonnel wrote:
> > Hi. More info. This is the /var/log/messages output when I run
> > hdsploader.
> >
> > Apr 12 12:30:56 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:4104: card initialization pendin=
g :
> > waiting for firmware
> > Apr 12 12:31:03 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <=3D 0
> > failed after 30 iterations
> > Apr 12 12:31:03 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:3800: initializing firmware uplo=
ad
> > Apr 12 12:31:03 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:522: loading firmware
> > Apr 12 12:31:03 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:548: finished firmware loading
> > Apr 12 12:31:07 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <=3D 1=
27
> > failed after 5000 iterations
> > Apr 12 12:31:07 kiertotahti kernel: ALSA
> > ../../alsa-kernel/pci/rme9652/hdsp.c:3824: error creating alsa device=
s
> >
> > (I/O-box shows host error).
>
> Did the hardware show the typical led blinking sequence while the
> firmware uploaded, and then the host error, or was the host error
> showing from the beginning ?

No blinking. The red led is on without a pause.

This is so strange. The card is there enough for
snd-hdsp to load but after that it's blocked.
What could be blocking the fw load process
and apps from using the card for I/O if
the fw is loaded in windows?

I really would love to know how to debug this.
How could I try to seek the exact place
where the communication breaks down?

So far, I've compiled kernels (2.4.20, 2.4.19) trying out
a few configurations (pcmcia in kernel and outside, acpi and no acpi
irq's from bios or directly, just hoping to get lucky :-)
but nothing. Everything looks the same as with rhl's 2.4.18.
(Except that external pcmcia couldn't make a connection
to the card for snd-hdsp to load.)

[What about interrupts? They don't matter here, do they?
In linux the pcmcia controller shares
irq 11 with eth0. In winXP it gets irq 10 and shares it with something
else I don't remember. I hope they aren't significant because
I don't think I know how to change them
(no bios options available).]

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
