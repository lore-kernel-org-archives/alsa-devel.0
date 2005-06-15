From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001025]: kernel panic when trying to load module
 snd-au8830
Date: Wed, 15 Jun 2005 21:30:36 +0800
Message-ID: <42B02D7C.7040000@netvigator.com>
References: <2407912799486cb54fbd13ab25aa8c3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2407912799486cb54fbd13ab25aa8c3d@bugtrack.alsa-project.org>
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
Cc: openvortex-dev@nongnu.org, Erik <assie2@zonnet.nl>
List-Id: alsa-devel@alsa-project.org

Alien wrote:
> Op dinsdag 7 juni 2005 15:44, schreef Raymond:
>
>> From your png, it seem that you are not using the alsamixer in the
>>latest version of alsa-utils.
>
>
> since i'm using alsa CVS for driver, kernel and lib; i'll use utils 
> from CVS as well...

It seem that there are bugs in alsamixer 1.0.9a ( even CVS Rev 1.88 )

alsamixer -V capture

1) The volume (Line,CD,Mic,Video,Home,Aux,Mix,Mix Mono) cannot be 
changed in view capture.

2) The Mic Select(Mic1,Mic2) and Mono Out(Mix,Mic) controls are missing 
in view capture.

The above problems do not exist when using "alsamixer" or "alsamixer -V 
playback"

>
>>The alsamixer or amixer are unable to display EQ Peaks correctly, the EQ
>>Peaks is a volatile read-only kcontrol which return 20 EQ peak values
>>from the 10-bands stereo hardware equalizer in au8810/au8830.
>
>
> didn't know that, in the previous versions, i know that all these 
> peaks were listed as mono sliders, not partly mono and stereo...
>
>
>>The graphic equalizer in vortexcontrol use a timer callback to read and
>>display the EQ peaks when EQ Enable switch is on. (attached vc_eq.png)
>
>
> vortexcontrol looks nice, from what alsa CVS package is that?


"vortexcontrol" (Vortex Control Panel) can be obtained from the support 
page in openvortex

http://savannah.nongnu.org/support/?func=detailitem&item_id=103017


If your au8810/au8830 has stereo codec

speaker-test -c 2 -t 2 -f frequency


If your au8810/au8830 has quad codec

speaker-tet -c 4 -t 2 -f frequency

The graphic equalizer will show left and right EQ peak values in
different bands when you change the frequency , please note that only
front channels are connected to the equalizer.


Takashi Iwai wrote:
 > At Wed, 8 Jun 2005 15:29:50 +0200,
 > Alien wrote:
 >
 >>Op woensdag 8 juni 2005 14:12, schreef Takashi Iwai:
 >>
 >>>At Wed, 8 Jun 2005 13:13:46 +0200,
 >>>
 >>>Alien wrote:
 >>>
 >>>>>You don't need to define values if the static array is initialize to
 >>>>>zero.  In this case,
 >>>>>
 >>>>>	static u16 eq_levels[64];
 >>>>>
 >>>>>would be better.



diff -Naur alsa-driver-1.0.9b/alsa-kernel/pci/au88x0_orig/au88x0_eq.c 
alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_eq.c
--- alsa-driver-1.0.9b/alsa-kernel/pci/au88x0_orig/au88x0_eq.c 
2005-06-12 08:01:13.000000000 +0800
+++ alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_eq.c 
2005-06-15 15:15:28.000000000 +0800
@@ -149,26 +149,6 @@
         *b = hwread(vortex->mmio, 0x2b3c8);
  }

-static void vortex_EqHw_GetLeftCoefs(vortex_t * vortex, u16 a[])
-{
-
-}
-
-static void vortex_EqHw_GetRightCoefs(vortex_t * vortex, u16 a[])
-{
-
-}
-
-static void vortex_EqHw_GetLeftStates(vortex_t * vortex, u16 * a, u16 b[])
-{
-
-}
-
-static void vortex_EqHw_GetRightStates(vortex_t * vortex, u16 * a, u16 b[])
-{
-
-}
-
  #endif
  /* Mix Gains */
  static void vortex_EqHw_SetBypassGain(vortex_t * vortex, u16 a, u16 b)
@@ -321,27 +301,26 @@

  #endif
  /* EQ band levels settings */
-static void vortex_EqHw_SetLevels(vortex_t * vortex, u16 peaks[])
+static void vortex_EqHw_SetLevels(vortex_t * vortex)
  {
         eqhw_t *eqhw = &(vortex->eq.this04);
         int i;

         /* set left peaks */
         for (i = 0; i < eqhw->this04; i++) {
-               hwwrite(vortex->mmio, 0x2b024 + i * 
VORTEX_BAND_COEFF_SIZE, peaks[i]);
+               hwwrite(vortex->mmio, 0x2b024 + i * 
VORTEX_BAND_COEFF_SIZE, 0);
         }

-       hwwrite(vortex->mmio, 0x2b3cc, peaks[eqhw->this04]);
-       hwwrite(vortex->mmio, 0x2b3d8, peaks[eqhw->this04 + 1]);
+       hwwrite(vortex->mmio, 0x2b3cc, 0);
+       hwwrite(vortex->mmio, 0x2b3d8, 0);

         /* set right peaks */
         for (i = 0; i < eqhw->this04; i++) {
-               hwwrite(vortex->mmio, 0x2b204 + i * VORTEX_BAND_COEFF_SIZE,
-                       peaks[i + (eqhw->this04 + 2)]);
+               hwwrite(vortex->mmio, 0x2b204 + i * 
VORTEX_BAND_COEFF_SIZE, 0);
         }

-       hwwrite(vortex->mmio, 0x2b3e4, peaks[2 + (eqhw->this04 * 2)]);
-       hwwrite(vortex->mmio, 0x2b3f0, peaks[3 + (eqhw->this04 * 2)]);
+       hwwrite(vortex->mmio, 0x2b3e4, 0);
+       hwwrite(vortex->mmio, 0x2b3f0, 0);
  }

  #if 0
@@ -377,7 +356,7 @@

  #endif
  /* Global Control */
-static void vortex_EqHw_SetControlReg(vortex_t * vortex, unsigned long reg)
+static void vortex_EqHw_SetControlReg(vortex_t * vortex, u32 reg)
  {
         hwwrite(vortex->mmio, 0x2b440, reg);
  }
@@ -449,7 +428,7 @@
         //vortex_EqHw_SetCurrA3DBypassGain(vortex, 0, 0);
         vortex_EqHw_SetLeftStates(vortex, eq_states_zero, 
asEqOutStateZeros);
         vortex_EqHw_SetRightStates(vortex, eq_states_zero, 
asEqOutStateZeros);
-       vortex_EqHw_SetLevels(vortex, (u16 *) eq_levels);
+       vortex_EqHw_SetLevels(vortex);
  }

  /* Program coeficients as pass through */
@@ -608,7 +587,7 @@
                               unsigned long b)
  {
         eqlzr_t *eq = &(vortex->eq);
-       int eax, ebx;
+       u32 eax, ebx;

         eq->this58 = a;
         eq->this5c = b;
@@ -624,7 +603,7 @@
  static void vortex_Eqlzr_ProgramA3dBypassGain(vortex_t * vortex)
  {
         eqlzr_t *eq = &(vortex->eq);
-       int eax, ebx;
+       u32 eax, ebx;

         if (eq->this54)
                 eax = eq->this0e;
@@ -854,7 +833,7 @@

         vortex_Eqlzr_GetAllPeaks(vortex, peaks, &count);
         if (count != 20) {
-               printk("vortex: peak count error 20 != %d \n", count);
+               printk(KERN_ERR "vortex: peak count error 20 != %d \n", 
count);
                 return -1;
         }
         for (i = 0; i < 20; i++)
@@ -922,14 +901,6 @@

  static int vortex_eq_free(vortex_t * vortex)
  {
-       /*
-          //FIXME: segfault because vortex->eqctrl[i] == 4
-          int i;
-          for (i=0; i<10; i++) {
-          if (vortex->eqctrl[i])
-          snd_ctl_remove(vortex->card, vortex->eqctrl[i]);
-          }
-        */
         vortex_Eqlzr_shutdown(vortex);
         return 0;
  }
diff -Naur 
alsa-driver-1.0.9b/alsa-kernel/pci/au88x0_orig/au88x0_eqdata.c 
alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_eqdata.c
--- alsa-driver-1.0.9b/alsa-kernel/pci/au88x0_orig/au88x0_eqdata.c 
2005-06-12 08:01:13.000000000 +0800
+++ alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_eqdata.c 
2005-06-12 11:04:37.000000000 +0800
@@ -102,11 +102,3 @@
         0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000
  };
-
-/*_rodataba0:*/
-static long eq_levels[32] = {
-       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
-};
diff -Naur alsa-driver-1.0.9b/alsa-kernel/pci/au88x0_orig/au88x0_eq.h 
alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_eq.h
--- alsa-driver-1.0.9b/alsa-kernel/pci/au88x0_orig/au88x0_eq.h 
2005-06-12 08:01:13.000000000 +0800
+++ alsa-driver-1.0.9b/alsa-kernel/pci/au88x0/au88x0_eq.h 
2005-06-12 09:47:11.000000000 +0800
@@ -18,13 +18,13 @@
  } auxxEqCoeffSet_t;

  typedef struct {
-       unsigned int *this00;   /*CAsp4HwIO */
+//     unsigned int *this00;   /*CAsp4HwIO */
         long this04;            /* How many filters for each side 
(default = 10) */
         long this08;            /* inited to cero. Stereo flag? */
  } eqhw_t;

  typedef struct {
-       unsigned int *this00;   /*CAsp4Core */
+//     unsigned int *this00;   /*CAsp4Core */
         eqhw_t this04;          /* CHwEq */
         short this08;           /* Bad codec flag ? SetBypassGain: 
bypass gain */
         short this0a;



bugtrack@alsa-project.org wrote:
> A NOTE has been added to this issue.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025> 
> ======================================================================
> Reported By:                Osiris
> Assigned To:                mjander
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   1025
> Category:                   PCI - au88x0
> Reproducibility:            always
> Severity:                   block
> Priority:                   normal
> Status:                     assigned
> Distribution:               Debian
> Kernel Version:             2.6.11.6
> ======================================================================
> Date Submitted:             03-30-2005 22:50 CEST
> Last Modified:              04-04-2005 11:00 CEST
> ======================================================================
> Summary:                    kernel panic when trying to load module snd-au8830
> Description: 
> kernel panic occurs on boot when system tries to load kernel module for
> Aureal Vortex 2. The same thing happens when driver is compiled into
> kernel, not module
> 
> ======================================================================
> 
> ----------------------------------------------------------------------
>  Osiris - 04-03-05 21:16 
> ----------------------------------------------------------------------
> My computer's hardware configuration is:
> AMD Athlon64 2800+ (runs in 64-bit mode)
> 512 Mb RAM
> MB: Asus K8V (chipset - Via KT800)
> Video: GeForceFX 5600 (Sparcle)
> HDD: Maxtor Diamond Max 9 SATA
> 
> built-in soundcard is turned off in bios
> 
> Vortex2 driver is built into kernel (not as a module)
> 
> Here are kernel messages during boot:
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18(level, low)->IRQ177
> Vortex: init....<1> Unable to handle kernel paging request at
> ffffc20000754018
> RIP:<ffffffff802a0dda>{vortex_core_init+42}
> PGD 1ff12067  PUD 1ff11067  PMD 1fc8f067  PTE 0
> Oops:0002 [1]
> CPU 0
> Modules linked in:
> Pid:1, comm: swapper Not tainted 2.6.11.6
> RIP:0010:[<ffffffff802a0dda>] <ffffffff802a0dda> {vortex_core_init+42}
> RSP:0000:ffff8100018c3d98  EFLAGS:00010296
> RAX:ffffc20000700000  RBX:ffff81001fda8000  RCX:00000000000927bf
> RDX:ffffffff80429310  RSI:0000000000000000  RDI:0000000000000005
> RBP:0000000000000000  R08:0000000000000008  R09:ffff8100018da120
> R10:00000000ffffffff  R11:0000000000000000  R12:00000000ffffffff
> R13:ffff81001fd5fc00  R14:ffff8100018c3df0  R15:ffffffff8045bfb0
> FS:0000000000000000(0000)  GS:ffffffff804540c0(0000)
> knlGS:0000000000000008
> CS:0010  DS:0018  ES:0018  CR0:000000008005003b
> CR2:ffffc20000754018  CR3:0000000000101000  CR4:00000000000006e0
> Process swapper (pid:1, threadinfo ffff8100018c2000, task
> ffff8100018c14d0)
> Stack:ffff81001fd5fc00 ffff8100019e9000 ffff81001fda8000 ffffffff802a51d3
>       ffffffff803d8ce0 ffff81001fd5fc00 ffff8100019e9000 0000000000000000
>       0000ffffffff8010 ffffffff802a5328
> Call trace: <ffffffff802a51d3> {snd_vortex_create+323}
>             <ffffffff802a5328> {snd_vortex_probe+120}
>             <ffffffff801ed1bd> {pci_device_probe_static+61}
>             <ffffffff801ed219> {__pci_device_probe+41}
>             <ffffffff801ed270> {pci_device_probe+48}
>             <ffffffff80245f5d> {driver_probe_device+77}
>             <ffffffff80246076> {driver_attach+70}
>             <ffffffff80246570> {bus_add_driver+144}
>             <ffffffff80246a92> {driver_register+50}
>             <ffffffff801ed516> {pci_register_driver+118}
>             <ffffffff8045c85a> {do_initcalls+106}
>             <ffffffff8010c07d> {init+45}
>             <ffffffff8010ebdb> {child_rip+8}
>             <ffffffff8010c050> {init+0}
>             <ffffffff8010ebd3> {child_rip+0}
> Code  44 89 a0 18 40 05 00 e8 6a 89 e9 ff 48 8b 93 e8 40 00 00 b8
> RIP <ffffffff802a0dda> {vortex_core_init+42} RSP <ffff8100018c3d98>
> CR2: ffffc20000754018
>  <0> kernel panic - not syncing: Attempt to kill init!
> 
> the soundcard worked fine with kernel 2.6.10 (32bit) on the same machine
> 




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
