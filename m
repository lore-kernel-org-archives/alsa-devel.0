From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
Date: Wed, 29 Oct 2014 10:42:00 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
	 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
	 <1414392371.8884.2.camel@perches.com>
 <1414531369.10912.14.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1414531369.10912.14.camel@perches.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: 'Joe Perches' <joe@perches.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, Akinobu Mita <akinobu.mita@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>"linux-mm@kvack.org" <linux-mm@kvack.org>Will Deacon <Will.Deacon@arm.com>Akinobu Mita <akinobu.mita@gmail.com>"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>alsa-devel <alsa-devel@alsa-project.org>LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Use the inline function instead of directly indexing the array.
>=20
> This allows some architectures with hardware instructions for bit reversa=
ls
> to eliminate the array.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> On Sun, 2014-10-26 at 23:46 -0700, Joe Perches wrote:
> > On Mon, 2014-10-27 at 14:37 +0800, Wang, Yalin wrote:
> > > this change add CONFIG_HAVE_ARCH_BITREVERSE config option, so that
> > > we can use arm/arm64 rbit instruction to do bitrev operation by
> > > hardware.
> []
> > > diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h index
> > > 7ffe03f..ef5b2bb 100644
> > > --- a/include/linux/bitrev.h
> > > +++ b/include/linux/bitrev.h
> > > @@ -3,6 +3,14 @@
> > >
> > >  #include <linux/types.h>
> > >
> > > +#ifdef CONFIG_HAVE_ARCH_BITREVERSE
> > > +#include <asm/bitrev.h>
> > > +
> > > +#define bitrev32 __arch_bitrev32
> > > +#define bitrev16 __arch_bitrev16
> > > +#define bitrev8 __arch_bitrev8
> > > +
> > > +#else
> > >  extern u8 const byte_rev_table[256];
>=20
>  sound/usb/6fire/firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c inde=
x
> 3b02e54..62c25e7 100644
> --- a/sound/usb/6fire/firmware.c
> +++ b/sound/usb/6fire/firmware.c
> @@ -316,7 +316,7 @@ static int usb6fire_fw_fpga_upload(
>=20
>  	while (c !=3D end) {
>  		for (i =3D 0; c !=3D end && i < FPGA_BUFSIZE; i++, c++)
> -			buffer[i] =3D byte_rev_table[(u8) *c];
> +			buffer[i] =3D bitrev8((u8)*c);
>=20
>  		ret =3D usb6fire_fw_fpga_write(device, buffer, i);
>  		if (ret < 0) {
>=20
I think the most safe way is change byte_rev_table[] to be satic,
So that no driver can access it directly,
The build error can remind the developer if they use byte_rev_table[]
Directly .

Thanks

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
