From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Tue, 16 Aug 2005 00:04:54 -0700 (PDT)
Message-ID: <20050816070454.27070.qmail@web54607.mail.yahoo.com>
References: <Pine.HPX.4.33n.0508151323470.21757-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508151323470.21757-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Im not sure how to use CVS. Anyway I followed what you
suggested which is to copy the content in
alsa-kernel/arm to kernel's sound/arm. However, when i
rebuild the kernel, i face a missing header file.=20

CC      sound/arm/pxa2xx-ac97.o
sound/arm/pxa2xx-ac97.c:31:28: asm/arch/audio.h: No
such file or directory
sound/arm/pxa2xx-ac97.c: In function
`pxa2xx_ac97_read':
sound/arm/pxa2xx-ac97.c:60: warning: implicit
declaration of function `wait_even
t_timeout'
sound/arm/pxa2xx-ac97.c: At top level:
sound/arm/pxa2xx-ac97.c:175: error: parse error before
"pxa2xx_ac97_ops"
sound/arm/pxa2xx-ac97.c:175: warning: type defaults to
`int' in declaration of `
pxa2xx_ac97_ops'
sound/arm/pxa2xx-ac97.c:176: error: field name not in
record or union initialize
r
sound/arm/pxa2xx-ac97.c:176: error: (near
initialization for `pxa2xx_ac97_ops')
sound/arm/pxa2xx-ac97.c:176: warning: initialization
makes integer from pointer
without a cast
sound/arm/pxa2xx-ac97.c:177: error: field name not in
record or union initialize
r
sound/arm/pxa2xx-ac97.c:177: error: (near
initialization for `pxa2xx_ac97_ops')
sound/arm/pxa2xx-ac97.c:177: warning: excess elements
in scalar initializer
.
.
.
.
sound/arm/pxa2xx-ac97.c:353: warning: pasess elements
in scalar initializer
' from incompatible pointer type initialization for
`pxa2xx_ac97_ops'
make[2]: *** [sound/arm/pxa2xx-ac97.o] Error 1
make[1]: *** [sound/arm] Error 2        =20
make: *** [sound] Error 2 =20

Do I miss anything? Where can i get audio.h file?

Raymond


--- Clemens Ladisch <clemens@ladisch.de> wrote:

> Chow Raymond wrote:
> > --- Clemens Ladisch <clemens@ladisch.de> wrote:
> > > An AC'97 codec is always connected to an AC'97
> > > controller.  It's the
> > > controller that would be supported (or not) by
> ALSA.
> >
> > Umm..so is the ac97 controller supported by ALSA?
>=20
> Yes.  The Compulab website says it's using a PXA255
> chip,
> and the "AC97 driver for the Intel PXA2xx chip"
> should
> support it.
>=20
> > I select that driver during kernel configuration
> (Sound
> > -> ALSA -> ALSA Arm Devices). However, when i
> flash
> > the kernel into the Compulab Armcore, it could not
> > detect any sound devices.
> >
> > [root@ARMCore root]$ cat /proc/asound/version
> > Advanced Linux Sound Architecture Driver Version
> 1.0.4
>=20
> I don't think you were able to select the PXA driver
> with that ALSA version.
>=20
> Get the CVS version of ALSA, and try to copy the
> contents of the alsa-kernel/arm/ directory into your
> kernel's sound/arm/ directory.
>=20
>=20
> HTH
> Clemens
>=20
>=20


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
