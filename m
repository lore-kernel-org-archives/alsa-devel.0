From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 7 Jun 2005 20:02:47 +0200
Message-ID: <200506072002.49600.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <200506071917.42953.alien999999999@users.sourceforge.net> <42A5DB84.2030407@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1172609.qMQ9MvYSom";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A5DB84.2030407@mail.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Igor Kovalenko <garrison@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1172609.qMQ9MvYSom
Content-Type: multipart/mixed;
  boundary="Boundary-01=_HFepC9jsTyN+Fg9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_HFepC9jsTyN+Fg9
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op dinsdag 7 juni 2005 19:38, schreef Igor Kovalenko:
> Alien wrote:
> > Op dinsdag 7 juni 2005 19:05, schreef Igor Kovalenko:
> >>Takashi Iwai wrote:
> >>>At Tue, 7 Jun 2005 17:16:02 +0200,
> >>>
> >>>Alien wrote:
> >>>>[1  <text/plain; iso-8859-1 (quoted-printable)>]
> >>>>
> >>>>Op dinsdag 7 juni 2005 17:05, schreef Raymond:
> >>>>>The patch (diff11.diff) cause segmenation fault on my 32bit machine
> >>>>>during /etc/init.d/alsasound start
> >>>>>
> >>>>>http://savannah.nongnu.org/patch/?func=3Ddetailitem&item_id=3D3948
> >>>>>
> >>>>>Do anyone know why readl() and writel() behave different in i386
> >>>>>(32bits) and AMD64 (64bits) ?
> >>>>>
> >>>>>http://sourceforge.net/mailarchive/message.php?msg_id=3D10773530
> >>>>>
> >>>>>
> >>>>>#ifndef CONFIG_X86_64
> >>>>>
> >>>>>#define        hwread(x,y) readl((x)+((y)>>2))
> >>>>>#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
> >>>>>
> >>>>>#else
> >>>>>
> >>>>>#define        hwread(x,y) readl((x)+(y))
> >>>>>#define        hwwrite(x,y,z) writel((z),(x)+(y))
> >>>>>
> >>>>>#endif
> >>>>
> >>>>that doesn't look good, unless the mmio is void* in 32bit and unsigned
> >>>>long* in x86_64...
> >>>>
> >>>>'unsigned long* mmio' should be preferred and together with '#define
> >>>>hwread(x,y) readl((x)+(y))' , this works for both platforms
> >>>
> >>>I guess using "unsigned long" for both architectures is broken, too.
> >>>Should be "u32" to be arch-independent.
> >>
> >>I strongly believe readl() and writel() on x86_64 does 32 bit
> >> reads/writes. (checked linux-2.6.12-rc5). Therefore reads/writes are of
> >> correct size with that patch - should be something different.
> >
> > i know that does not work!
> >
> > when i started doing this, i got segfaults because of the >>2 .
> >
> > readl and writel do long operations as evidenced by the 'l'
> >
> > i know this seems weird, but this is memory-mapped, and appearantly it's
> > memory mapped to long, anyway; when i do 'unsigned long* mmio' and i use
> > readl and writel without any bitshifts, it works...
> >
> > you may believe what you want, but i _know_ that on x86_64, i _NEED_
> > unsigned long* mmio and no bitshifting to get this to work.
> >
> > maybe the problem lies with writel and readl to begin with, maybe if you
> > wrote an int, it would work...
> >
> > AL13N
>
> OK, then let's put it this way: change to void* and removal of shifts is =
to
> make address operations correct. That is the address itself is at the same
> offset on all arches. Then readl/writel just do 32 bit read/write which is
> what we need. May be it is the mapping is wrong?

change to void* and removal of shifts will make it wrong on both systems,=20
unless you modify all the parameters to make them use byte-offsets, will=20
'allthough that would be weird' make it work _only_ on 32bit systems...

> Please check if you applied the patch correctly - I suspect you used
> different kernel version and patch may have missed some points... BTW the
> segfault (oops) report would be handy.

I never did apply the patch, i made a modification before the patch (which =
is=20
available on the net somewhere, probably some mailing list) before the patc=
h=20
was out. the oops is also at the same place... but that all is several mont=
hs=20
ago. i'll make a patch to what i have now, it's more or less similar to the=
=20
original patch.

hmm, I seem to have applied the patch after all, and made a little=20
modifications...

this is a patch against some CVS version of a few weeks ago not more than 3=
=20
weeks i think...

see if this works for you

--Boundary-01=_HFepC9jsTyN+Fg9
Content-Type: text/x-diff;
  charset="koi8-r";
  name="au88x0_12.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="au88x0_12.patch"

Index: alsa-kernel/pci/au88x0/au88x0.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.c,v
retrieving revision 1.18
diff -u -r1.18 au88x0.c
=2D-- alsa-kernel/pci/au88x0/au88x0.c	11 Apr 2005 15:58:27 -0000	1.18
+++ alsa-kernel/pci/au88x0/au88x0.c	7 Jun 2005 17:56:35 -0000
@@ -144,15 +144,18 @@
 	// check PCI availability (DMA).
 	if ((err =3D pci_enable_device(pci)) < 0)
 		return err;
=2D	if (!pci_dma_supported(pci, VORTEX_DMA_MASK)) {
+	if (pci_set_dma_mask(pci, VORTEX_DMA_MASK) < 0 ||
+		pci_set_consistent_dma_mask(pci, VORTEX_DMA_MASK) < 0) {
 		printk(KERN_ERR "error to set DMA mask\n");
+		pci_disable_device(pci);
 		return -ENXIO;
 	}
=2D	pci_set_dma_mask(pci, VORTEX_DMA_MASK);
=20
 	chip =3D kcalloc(1, sizeof(*chip), GFP_KERNEL);
=2D	if (chip =3D=3D NULL)
+	if (chip =3D=3D NULL) {
+		pci_disable_device(pci);
 		return -ENOMEM;
+	}
=20
 	chip->card =3D card;
=20
@@ -202,6 +205,10 @@
 		goto alloc_out;
 	}
=20
+	snd_card_set_dev(card, &pci->dev);
+
+	snd_card_set_dev(card, &pci->dev);
+
 	*rchip =3D chip;
=20
 	return 0;
Index: alsa-kernel/pci/au88x0/au88x0.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.h,v
retrieving revision 1.11
diff -u -r1.11 au88x0.h
=2D-- alsa-kernel/pci/au88x0/au88x0.h	22 Mar 2005 08:50:55 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0.h	7 Jun 2005 17:56:35 -0000
@@ -41,8 +41,8 @@
=20
 #define	VORTEX_DMA_MASK	0xffffffff
=20
=2D#define	hwread(x,y) readl((x)+((y)>>2))
=2D#define	hwwrite(x,y,z) writel((z),(x)+((y)>>2))
+#define	hwread(x,y) readl((x)+(y))
+#define	hwwrite(x,y,z) writel((z),(x)+(y))
=20
 /* Vortex MPU401 defines. */
 #define	MIDI_CLOCK_DIV		0x61
@@ -107,7 +107,7 @@
 	//int this_08;          /* Still unknown */
 	int fifo_enabled;	/* this_24 */
 	int fifo_status;	/* this_1c */
=2D	int dma_ctrl;		/* this_78 (ADB), this_7c (WT) */
+	u32 dma_ctrl;		/* this_78 (ADB), this_7c (WT) */
 	int dma_unknown;	/* this_74 (ADB), this_78 (WT). WDM: +8 */
 	int cfg0;
 	int cfg1;
@@ -172,7 +172,7 @@
=20
 	/* PCI hardware resources */
 	unsigned long io;
=2D	unsigned long __iomem *mmio;
+	void __iomem *mmio;
 	unsigned int irq;
 	spinlock_t lock;
=20
@@ -195,14 +195,14 @@
 				     int count);
 static void vortex_adbdma_setmode(vortex_t * vortex, int adbdma, int ie,
 				  int dir, int fmt, int d,
=2D				  unsigned long offset);
+				  u32 offset);
 static void vortex_adbdma_setstartbuffer(vortex_t * vortex, int adbdma, in=
t sb);
 #ifndef CHIP_AU8810
 static void vortex_wtdma_setbuffers(vortex_t * vortex, int wtdma,
 				    snd_pcm_sgbuf_t * sgbuf, int size,
 				    int count);
 static void vortex_wtdma_setmode(vortex_t * vortex, int wtdma, int ie, int=
 fmt, int d,	/*int e, */
=2D				 unsigned long offset);
+				 u32 offset);
 static void vortex_wtdma_setstartbuffer(vortex_t * vortex, int wtdma, int =
sb);
 #endif
=20
Index: alsa-kernel/pci/au88x0/au88x0_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
retrieving revision 1.11
diff -u -r1.11 au88x0_core.c
=2D-- alsa-kernel/pci/au88x0/au88x0_core.c	23 Feb 2005 11:00:31 -0000	1.11
+++ alsa-kernel/pci/au88x0/au88x0_core.c	7 Jun 2005 17:56:37 -0000
@@ -376,7 +376,7 @@
=20
 static void vortex_mixer_init(vortex_t * vortex)
 {
=2D	unsigned long addr;
+	u32 addr;
 	int x;
=20
 	// FIXME: get rid of this crap.
@@ -639,7 +639,7 @@
=20
 static void vortex_srcblock_init(vortex_t * vortex)
 {
=2D	unsigned long addr;
+	u32 addr;
 	int x;
 	hwwrite(vortex->mmio, VORTEX_SRC_SOURCESIZE, 0x1ff);
 	/*
@@ -1035,7 +1035,7 @@
 static void vortex_fifo_init(vortex_t * vortex)
 {
 	int x;
=2D	unsigned long addr;
+	u32 addr;
=20
 	/* ADB DMA channels fifos. */
 	addr =3D VORTEX_FIFO_ADBCTRL + ((NR_ADB - 1) * 4);
@@ -1054,7 +1054,7 @@
 		hwwrite(vortex->mmio, addr, FIFO_U0);
 		if (hwread(vortex->mmio, addr) !=3D FIFO_U0)
 			printk(KERN_ERR
=2D			       "bad wt fifo reset (0x%08lx, 0x%08x)!\n",
+			       "bad wt fifo reset (0x%08x, 0x%08x)!\n",
 			       addr, hwread(vortex->mmio, addr));
 		vortex_fifo_clearwtdata(vortex, x, FIFO_SIZE);
 		addr -=3D 4;
@@ -1152,7 +1152,7 @@
=20
 static void
 vortex_adbdma_setmode(vortex_t * vortex, int adbdma, int ie, int dir,
=2D		      int fmt, int d, unsigned long offset)
+		      int fmt, int d, u32 offset)
 {
 	stream_t *dma =3D &vortex->dma_adb[adbdma];
=20
@@ -1411,7 +1411,7 @@
=20
 static void
 vortex_wtdma_setmode(vortex_t * vortex, int wtdma, int ie, int fmt, int d,
=2D		     /*int e, */ unsigned long offset)
+		     /*int e, */ u32 offset)
 {
 	stream_t *dma =3D &vortex->dma_wt[wtdma];
=20
Index: alsa-kernel/pci/au88x0/au88x0_eq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_eq.c,v
retrieving revision 1.8
diff -u -r1.8 au88x0_eq.c
=2D-- alsa-kernel/pci/au88x0/au88x0_eq.c	27 Oct 2004 07:31:16 -0000	1.8
+++ alsa-kernel/pci/au88x0/au88x0_eq.c	7 Jun 2005 17:56:37 -0000
@@ -377,23 +377,23 @@
=20
 #endif
 /* Global Control */
=2Dstatic void vortex_EqHw_SetControlReg(vortex_t * vortex, unsigned long r=
eg)
+static void vortex_EqHw_SetControlReg(vortex_t * vortex, u32 reg)
 {
 	hwwrite(vortex->mmio, 0x2b440, reg);
 }
=20
=2Dstatic void vortex_EqHw_SetSampleRate(vortex_t * vortex, int sr)
+static void vortex_EqHw_SetSampleRate(vortex_t * vortex, u32 sr)
 {
 	hwwrite(vortex->mmio, 0x2b440, ((sr & 0x1f) << 3) | 0xb800);
 }
=20
 #if 0
=2Dstatic void vortex_EqHw_GetControlReg(vortex_t * vortex, unsigned long *=
reg)
+static void vortex_EqHw_GetControlReg(vortex_t * vortex, u32 *reg)
 {
 	*reg =3D hwread(vortex->mmio, 0x2b440);
 }
=20
=2Dstatic void vortex_EqHw_GetSampleRate(vortex_t * vortex, int *sr)
+static void vortex_EqHw_GetSampleRate(vortex_t * vortex, u32 *sr)
 {
 	*sr =3D (hwread(vortex->mmio, 0x2b440) >> 3) & 0x1f;
 }
@@ -554,7 +554,7 @@
=20
 #if 0
 static int
=2Dvortex_Eqlzr_GetAllBands(vortex_t * vortex, u16 * gains, unsigned long *=
cnt)
+vortex_Eqlzr_GetAllBands(vortex_t * vortex, u16 * gains, s32 *cnt)
 {
 	eqlzr_t *eq =3D &(vortex->eq);
 	int si =3D 0;
@@ -586,7 +586,7 @@
 }
=20
 static int
=2Dvortex_Eqlzr_SetAllBands(vortex_t * vortex, u16 gains[], unsigned long c=
ount)
+vortex_Eqlzr_SetAllBands(vortex_t * vortex, u16 gains[], s32 count)
 {
 	eqlzr_t *eq =3D &(vortex->eq);
 	int i;
@@ -604,11 +604,10 @@
 }
=20
 static void
=2Dvortex_Eqlzr_SetA3dBypassGain(vortex_t * vortex, unsigned long a,
=2D			      unsigned long b)
+vortex_Eqlzr_SetA3dBypassGain(vortex_t * vortex, u32 a, u32 b)
 {
 	eqlzr_t *eq =3D &(vortex->eq);
=2D	int eax, ebx;
+	u32 eax, ebx;
=20
 	eq->this58 =3D a;
 	eq->this5c =3D b;
@@ -624,7 +623,7 @@
 static void vortex_Eqlzr_ProgramA3dBypassGain(vortex_t * vortex)
 {
 	eqlzr_t *eq =3D &(vortex->eq);
=2D	int eax, ebx;
+	u32 eax, ebx;
=20
 	if (eq->this54)
 		eax =3D eq->this0e;
@@ -641,7 +640,7 @@
 		vortex_EqHw_ZeroA3DIO(vortex);
 }
=20
=2Dstatic void vortex_Eqlzr_SetBypass(vortex_t * vortex, long bp)
+static void vortex_Eqlzr_SetBypass(vortex_t * vortex, u32 bp)
 {
 	eqlzr_t *eq =3D &(vortex->eq);
 =09
@@ -651,8 +650,8 @@
 		vortex_EqHw_SetBypassGain(vortex, eq->this08, eq->this08);
 	} else {
 		/* EQ disabled. */
=2D		vortex_EqHw_SetLeftGainsTarget(vortex, (u16 *) (eq->this14));
=2D		vortex_EqHw_SetRightGainsTarget(vortex, (u16 *) (eq->this14));
+		vortex_EqHw_SetLeftGainsTarget(vortex, eq->this14_array);
+		vortex_EqHw_SetRightGainsTarget(vortex, eq->this14_array);
 		vortex_EqHw_SetBypassGain(vortex, eq->this0c, eq->this0c);
 	}
 	vortex_Eqlzr_ProgramA3dBypassGain(vortex);
@@ -706,7 +705,7 @@
 	eq->this5c =3D 0xffff;
=20
 	/* Set gains. */
=2D	memset(eq->this14, 0, 2 * 10);
+	memset(eq->this14_array, 0, sizeof(eq->this14_array));
=20
 	/* Actual init. */
 	vortex_EqHw_ZeroState(vortex);
Index: alsa-kernel/pci/au88x0/au88x0_eq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_eq.h,v
retrieving revision 1.1
diff -u -r1.1 au88x0_eq.h
=2D-- alsa-kernel/pci/au88x0/au88x0_eq.h	9 Mar 2004 11:52:13 -0000	1.1
+++ alsa-kernel/pci/au88x0/au88x0_eq.h	7 Jun 2005 17:56:37 -0000
@@ -18,26 +18,26 @@
 } auxxEqCoeffSet_t;
=20
 typedef struct {
=2D	unsigned int *this00;	/*CAsp4HwIO */
=2D	long this04;		/* How many filters for each side (default =3D 10) */
=2D	long this08;		/* inited to cero. Stereo flag? */
+	u32 ptr_this00;		/*CAsp4HwIO */
+	s32 this04;		/* How many filters for each side (default =3D 10) */
+	s32 this08;		/* inited to cero. Stereo flag? */
 } eqhw_t;
=20
 typedef struct {
=2D	unsigned int *this00;	/*CAsp4Core */
+	u32  ptr_this00;	/*CAsp4Core */
 	eqhw_t this04;		/* CHwEq */
=2D	short this08;		/* Bad codec flag ? SetBypassGain: bypass gain */
=2D	short this0a;
=2D	short this0c;		/* SetBypassGain: bypass gain when this28 is not set. */
=2D	short this0e;
+	u16 this08;		/* Bad codec flag ? SetBypassGain: bypass gain */
+	u16 this0a;
+	u16 this0c;		/* SetBypassGain: bypass gain when this28 is not set. */
+	u16 this0e;
=20
=2D	long this10;		/* How many gains are used for each side (right or left).=
 */
=2D	u16 this14[32];		/* SetLeftGainsTarget: Left (and right?) EQ gains  */
=2D	long this24;
=2D	long this28;		/* flag related to EQ enabled or not. Gang flag ? */
=2D	long this54;		/* SetBypass */
=2D	long this58;
=2D	long this5c;
+	s32 this10;		/* How many gains are used for each side (right or left). */
+	u16 this14_array[32];	/* SetLeftGainsTarget: Left (and right?) EQ gains  =
*/
+	s32 this24;
+	s32 this28;		/* flag related to EQ enabled or not. Gang flag ? */
+	s32 this54;		/* SetBypass */
+	s32 this58;
+	s32 this5c;
 	/*0x60 */ auxxEqCoeffSet_t coefset;
 	/* 50 u16 word each channel. */
 	u16 this130[20];	/* Left and Right gains */
Index: alsa-kernel/pci/au88x0/au88x0_eqdata.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_eqdata.c,v
retrieving revision 1.1
diff -u -r1.1 au88x0_eqdata.c
=2D-- alsa-kernel/pci/au88x0/au88x0_eqdata.c	9 Mar 2004 11:52:13 -0000	1.1
+++ alsa-kernel/pci/au88x0/au88x0_eqdata.c	7 Jun 2005 17:56:37 -0000
@@ -104,7 +104,11 @@
 };
=20
 /*_rodataba0:*/
=2Dstatic long eq_levels[32] =3D {
+static u16 eq_levels[64] =3D {
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
Index: alsa-kernel/pci/au88x0/au88x0_mpu401.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_mpu401.c,v
retrieving revision 1.2
diff -u -r1.2 au88x0_mpu401.c
=2D-- alsa-kernel/pci/au88x0/au88x0_mpu401.c	29 Jun 2004 16:10:32 -0000	1.2
+++ alsa-kernel/pci/au88x0/au88x0_mpu401.c	7 Jun 2005 17:56:37 -0000
@@ -95,7 +95,7 @@
 		return temp;
 	}
 #else
=2D	port =3D (unsigned long)(vortex->mmio + (VORTEX_MIDI_DATA >> 2));
+	port =3D (unsigned long)(vortex->mmio + VORTEX_MIDI_DATA);
 	if ((temp =3D
 	     snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_AUREAL, port,
 				 1, 0, 0, &rmidi)) !=3D 0) {
@@ -105,7 +105,7 @@
 		return temp;
 	}
 	mpu =3D rmidi->private_data;
=2D	mpu->cport =3D (unsigned long)(vortex->mmio + (VORTEX_MIDI_CMD >> 2));
+	mpu->cport =3D (unsigned long)(vortex->mmio + VORTEX_MIDI_CMD);
 #endif
 	vortex->rmidi =3D rmidi;
 	return 0;
Index: alsa-kernel/pci/au88x0/au88x0_synth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_synth.c,v
retrieving revision 1.3
diff -u -r1.3 au88x0_synth.c
=2D-- alsa-kernel/pci/au88x0/au88x0_synth.c	24 Apr 2004 14:57:33 -0000	1.3
+++ alsa-kernel/pci/au88x0/au88x0_synth.c	7 Jun 2005 17:56:37 -0000
@@ -32,7 +32,7 @@
 					unsigned char mix, int a);
 static void vortex_fifo_wtinitialize(vortex_t * vortex, int fifo, int j);
 static int vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
=2D			    unsigned long val);
+			    u32 val);
=20
 /* WT */
=20
@@ -166,7 +166,7 @@
 /* WT hardware abstraction layer generic register interface. */
 static int
 vortex_wt_SetReg2(vortex_t * vortex, unsigned char reg, int wt,
=2D		  unsigned short val)
+		  u16 val)
 {
 	/*
 	   int eax, edx;
@@ -190,7 +190,7 @@
 #endif
 static int
 vortex_wt_SetReg(vortex_t * vortex, unsigned char reg, int wt,
=2D		 unsigned long val)
+		 u32 val)
 {
 	int ecx;
=20
@@ -279,7 +279,7 @@
=20
 static void vortex_wt_init(vortex_t * vortex)
 {
=2D	int var4, var8, varc, var10 =3D 0, edi;
+	u32 var4, var8, varc, var10 =3D 0, edi;
=20
 	var10 &=3D 0xFFFFFFE3;
 	var10 |=3D 0x22;
@@ -353,7 +353,7 @@
 static void vortex_wt_SetFrequency(vortex_t * vortex, int wt, unsigned int=
 sr)
 {
 	wt_voice_t *voice =3D &(vortex->wt_voice[wt]);
=2D	long int eax, edx;
+	u32 eax, edx;
=20
 	//FIXME: 64 bit operation.
 	eax =3D ((sr << 0xf) * 0x57619F1) & 0xffffffff;
Index: alsa-kernel/pci/au88x0/au88x0_wt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_wt.h,v
retrieving revision 1.1
diff -u -r1.1 au88x0_wt.h
=2D-- alsa-kernel/pci/au88x0/au88x0_wt.h	9 Mar 2004 11:52:13 -0000	1.1
+++ alsa-kernel/pci/au88x0/au88x0_wt.h	7 Jun 2005 17:56:37 -0000
@@ -53,11 +53,11 @@
 #endif
=20
 typedef struct {
=2D	unsigned int parm0;	/* this_1E4 */
=2D	unsigned int parm1;	/* this_1E8 */
=2D	unsigned int parm2;	/* this_1EC */
=2D	unsigned int parm3;	/* this_1F0 */
=2D	unsigned int this_1D0;
+	u32 parm0;	/* this_1E4 */
+	u32 parm1;	/* this_1E8 */
+	u32 parm2;	/* this_1EC */
+	u32 parm3;	/* this_1F0 */
+	u32 this_1D0;
 } wt_voice_t;
=20
 #endif				/* _AU88X0_WT_H */
Index: alsa-kernel/pci/au88x0/au88x0_xtalk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_xtalk.c,v
retrieving revision 1.3
diff -u -r1.3 au88x0_xtalk.c
=2D-- alsa-kernel/pci/au88x0/au88x0_xtalk.c	6 Aug 2004 09:44:58 -0000	1.3
+++ alsa-kernel/pci/au88x0/au88x0_xtalk.c	7 Jun 2005 17:56:38 -0000
@@ -562,7 +562,7 @@
 vortex_XtalkHw_SetDelay(vortex_t * vortex, unsigned short right,
 			unsigned short left)
 {
=2D	int esp0 =3D 0;
+	u32 esp0 =3D 0;
=20
 	esp0 &=3D 0x1FFFFFFF;
 	esp0 |=3D 0xA0000000;
@@ -632,18 +632,18 @@
 /* Control/Global stuff */
=20
 #if 0
=2Dstatic void vortex_XtalkHw_SetControlReg(vortex_t * vortex, unsigned lon=
g ctrl)
+static void vortex_XtalkHw_SetControlReg(vortex_t * vortex, u32 ctrl)
 {
 	hwwrite(vortex->mmio, 0x24660, ctrl);
 }
=2Dstatic void vortex_XtalkHw_GetControlReg(vortex_t * vortex, unsigned lon=
g *ctrl)
+static void vortex_XtalkHw_GetControlReg(vortex_t * vortex, u32 *ctrl)
 {
 	*ctrl =3D hwread(vortex->mmio, 0x24660);
 }
 #endif
=2Dstatic void vortex_XtalkHw_SetSampleRate(vortex_t * vortex, int sr)
+static void vortex_XtalkHw_SetSampleRate(vortex_t * vortex, u32 sr)
 {
=2D	int temp;
+	u32 temp;
=20
 	temp =3D (hwread(vortex->mmio, 0x24660) & 0x1FFFFFFF) | 0xC0000000;
 	temp =3D (temp & 0xffffff07) | ((sr & 0x1f) << 3);
@@ -651,7 +651,7 @@
 }
=20
 #if 0
=2Dstatic void vortex_XtalkHw_GetSampleRate(vortex_t * vortex, int *sr)
+static void vortex_XtalkHw_GetSampleRate(vortex_t * vortex, u32 *sr)
 {
 	*sr =3D (hwread(vortex->mmio, 0x24660) >> 3) & 0x1f;
 }
@@ -659,7 +659,7 @@
 #endif
 static void vortex_XtalkHw_Enable(vortex_t * vortex)
 {
=2D	int temp;
+	u32 temp;
=20
 	temp =3D (hwread(vortex->mmio, 0x24660) & 0x1FFFFFFF) | 0xC0000000;
 	temp |=3D 1;
@@ -669,7 +669,7 @@
=20
 static void vortex_XtalkHw_Disable(vortex_t * vortex)
 {
=2D	int temp;
+	u32 temp;
=20
 	temp =3D (hwread(vortex->mmio, 0x24660) & 0x1FFFFFFF) | 0xC0000000;
 	temp &=3D 0xfffffffe;
Index: alsa-kernel/pci/au88x0/au88x0_xtalk.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_xtalk.h,v
retrieving revision 1.3
diff -u -r1.3 au88x0_xtalk.h
=2D-- alsa-kernel/pci/au88x0/au88x0_xtalk.h	6 Aug 2004 09:44:58 -0000	1.3
+++ alsa-kernel/pci/au88x0/au88x0_xtalk.h	7 Jun 2005 17:56:38 -0000
@@ -39,16 +39,16 @@
 #define XT_SPEAKER1		3
 #define XT_DIAMOND		4
=20
=2Dtypedef long xtalk_dline_t[XTDLINE_SZ];
=2Dtypedef short xtalk_gains_t[XTGAINS_SZ];
=2Dtypedef short xtalk_instate_t[XTINST_SZ];
=2Dtypedef short xtalk_coefs_t[5][5];
=2Dtypedef short xtalk_state_t[5][4];
+typedef u32 xtalk_dline_t[XTDLINE_SZ];
+typedef u16 xtalk_gains_t[XTGAINS_SZ];
+typedef u16 xtalk_instate_t[XTINST_SZ];
+typedef u16 xtalk_coefs_t[5][5];
+typedef u16 xtalk_state_t[5][4];
=20
 static void vortex_XtalkHw_SetGains(vortex_t * vortex,
 				    xtalk_gains_t const gains);
 static void vortex_XtalkHw_SetGainsAllChan(vortex_t * vortex);
=2Dstatic void vortex_XtalkHw_SetSampleRate(vortex_t * vortex, int sr);
+static void vortex_XtalkHw_SetSampleRate(vortex_t * vortex, u32 sr);
 static void vortex_XtalkHw_ProgramPipe(vortex_t * vortex);
 static void vortex_XtalkHw_ProgramPipe(vortex_t * vortex);
 static void vortex_XtalkHw_ProgramXtalkWide(vortex_t * vortex);

--Boundary-01=_HFepC9jsTyN+Fg9--

--nextPart1172609.qMQ9MvYSom
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpeFJuBWKXETrtdcRApJCAJ9J4UctDroVRXOFhu9FufZDk5vxLQCgn+Om
DxDN785LGbtp12BjgAWoQEU=
=AQ4h
-----END PGP SIGNATURE-----

--nextPart1172609.qMQ9MvYSom--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
