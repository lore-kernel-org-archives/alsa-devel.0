From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Wed, 8 Jun 2005 12:23:01 +0200
Message-ID: <200506081223.03802.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <s5hwtp6w2nw.wl@alsa2.suse.de> <42A6B51F.20405@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1291599.r2Mv5eyDM9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A6B51F.20405@netvigator.com>
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
Cc: Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

--nextPart1291599.r2Mv5eyDM9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I don't think it'll be faster, gcc -O2 will have changed it accordingly=20
anyway, without optimization it might be faster, but the thing is that it=20
just looks cleaner...

Op woensdag 8 juni 2005 11:06, schreef Raymond:
> au8830 can be loaded after I change "unsigned long __iomem *mmio" to
> "void __iomem *mmio" on my 32 bits machine.
>
> How can I obtain the disassembly of snd-au8830.o to prove that it run
> faster than before ( without bitshift ) ?
>
> alsa-kernel/pci/au88x0/au88x0.h
>
> @@ -41,8 +41,8 @@
>
>   #define        VORTEX_DMA_MASK 0xffffffff
>
>
> -#define        hwread(x,y) readl((x)+((y)>>2))
> -#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
> +#define        hwread(x,y) readl((x)+(y))
> +#define        hwwrite(x,y,z) writel((z),(x)+(y))
>
> @@ -172,7 +172,7 @@
>
>          /* PCI hardware resources */
>          unsigned long io;
> -       unsigned long __iomem *mmio;
> +       void __iomem *mmio;
>          unsigned int irq;
>          spinlock_t lock;
>
>
>
> I don't have any MPU401 device to test this change.
>
>
> alsa-kernel/pci/au88x0/au88x0_mpu401.c
> @@ -95,7 +95,7 @@
>                  return temp;
>          }
>   #else
> -       port =3D (unsigned long)(vortex->mmio + (VORTEX_MIDI_DATA >> 2));
> +       port =3D (unsigned long)(vortex->mmio + VORTEX_MIDI_DATA);
>          if ((temp =3D
>               snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_AUREAL, port,
>                                   1, 0, 0, &rmidi)) !=3D 0) {
> @@ -105,7 +105,7 @@
>                  return temp;
>          }
>          mpu =3D rmidi->private_data;
> -       mpu->cport =3D (unsigned long)(vortex->mmio + (VORTEX_MIDI_CMD >>
> 2)); +       mpu->cport =3D (unsigned long)(vortex->mmio + VORTEX_MIDI_CM=
D);
> #endif
>          vortex->rmidi =3D rmidi;
>          return 0;
>
>
> Is there any reason to make this change ?
>
> alsa-kernel/pci/au88x0/au88x0.c
> @@ -144,15 +144,18 @@
>          // check PCI availability (DMA).
>          if ((err =3D pci_enable_device(pci)) < 0)
>                  return err;
> -       if (!pci_dma_supported(pci, VORTEX_DMA_MASK)) {
> +        if (pci_set_dma_mask(pci, VORTEX_DMA_MASK) < 0 ||
> +               pci_set_consistent_dma_mask(pci, VORTEX_DMA_MASK) < 0) {
>                  printk(KERN_ERR "error to set DMA mask\n");
> +               pci_disable_device(pci);
>                  return -ENXIO;
>          }
> -       pci_set_dma_mask(pci, VORTEX_DMA_MASK);
>
>          chip =3D kcalloc(1, sizeof(*chip), GFP_KERNEL);
> -       if (chip =3D=3D NULL)
> +       if (chip =3D=3D NULL) {
> +               pci_disable_device(pci);
>                  return -ENOMEM;
> +       }
>
>          chip->card =3D card;
>
> @@ -202,6 +205,8 @@
>                  goto alloc_out;
>          }
>
> +       snd_card_set_dev(card, &pci->dev);
> +
>          *rchip =3D chip;
>
>          return 0;
>
> Those changes in au88x0_eq.h and au88x0_eqdata.c seem WRONG.
>
> -       unsigned int *this00;   /*CAsp4HwIO */
> +       u32 ptr_this00;         /*CAsp4HwIO */
>
>
> 2 * 10 seem related to the 10-bands stereo EQ.
>
>
> -       u16 this14[32];         /* SetLeftGainsTarget: Left (and right?)
> +       u16 this14_array[32];   /* SetLeftGainsTarget: Left (and right?)
>
>          /* Set gains. */
> -       memset(eq->this14, 0, 2 * 10);
> +       memset(eq->this14_array, 0, sizeof(eq->this14_array));
>
>
>
>
> -static long eq_levels[32] =3D {
> +static u16 eq_levels[64] =3D {
> +       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>
>
> http://lists.nongnu.org/archive/html/openvortex-dev/2003-12/msg00007.html
>
> There is no kcontrol to change vortex->xt_mode for speaker wide, speaker
> narrow, speaker Diamond , headphones to test the Crosstalk canceler
>
> long -> s32
> short -> s16
>
> alsa-kernel/pci/au88x0/au88x0_xtalk.h
> @@ -39,11 +39,11 @@
>   #define XT_SPEAKER1            3
>   #define XT_DIAMOND             4
>
> -typedef long xtalk_dline_t[XTDLINE_SZ];
> -typedef short xtalk_gains_t[XTGAINS_SZ];
> -typedef short xtalk_instate_t[XTINST_SZ];
> -typedef short xtalk_coefs_t[5][5];
> -typedef short xtalk_state_t[5][4];
> +typedef u32 xtalk_dline_t[XTDLINE_SZ];
> +typedef u16 xtalk_gains_t[XTGAINS_SZ];
> +typedef u16 xtalk_instate_t[XTINST_SZ];
> +typedef u16 xtalk_coefs_t[5][5];
> +typedef u16 xtalk_state_t[5][4];
>
> Takashi Iwai wrote:
> > At Tue, 7 Jun 2005 17:16:02 +0200,
> >
> > Alien wrote:
> >>[1  <text/plain; iso-8859-1 (quoted-printable)>]
> >>
> >>Op dinsdag 7 juni 2005 17:05, schreef Raymond:
> >>>The patch (diff11.diff) cause segmenation fault on my 32bit machine
> >>>during /etc/init.d/alsasound start
> >>>
> >>>http://savannah.nongnu.org/patch/?func=3Ddetailitem&item_id=3D3948
> >>>
> >>>Do anyone know why readl() and writel() behave different in i386
> >>>(32bits) and AMD64 (64bits) ?
> >>>
> >>>http://sourceforge.net/mailarchive/message.php?msg_id=3D10773530
> >>>
> >>>
> >>>#ifndef CONFIG_X86_64
> >>>
> >>>#define        hwread(x,y) readl((x)+((y)>>2))
> >>>#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
> >>>
> >>>#else
> >>>
> >>>#define        hwread(x,y) readl((x)+(y))
> >>>#define        hwwrite(x,y,z) writel((z),(x)+(y))
> >>>
> >>>#endif
> >>
> >>that doesn't look good, unless the mmio is void* in 32bit and unsigned
> >> long* in x86_64...
> >>
> >>'unsigned long* mmio' should be preferred and together with '#define
> >>hwread(x,y) readl((x)+(y))' , this works for both platforms
> >
> > I guess using "unsigned long" for both architectures is broken, too.
> > Should be "u32" to be arch-independent.
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you
> shotput a projector? How fast can you ride your desk chair down the office
> luge track? If you want to score the big prize, get to know the little gu=
y.
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart1291599.r2Mv5eyDM9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpscHuBWKXETrtdcRArdyAJ9/KzKCIWseZTs+imNdLE+Outlg2gCg2HxR
ORhR8F6XRuRrE7opxZWoeI4=
=oZqp
-----END PGP SIGNATURE-----

--nextPart1291599.r2Mv5eyDM9--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
