From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000344]: usx2y driver causes kernel oops
Date: Wed, 25 Aug 2004 10:02:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040825080249.DF30D1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 48F36288
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2004 10:02:50 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000344
======================================================================
Reported By:                maggoi
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Bug ID:                     344
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.6
======================================================================
Date Submitted:             06-24-2004 18:06 CEST
Last Modified:              08-25-2004 10:02 CEST
======================================================================
Summary:                    usx2y driver causes kernel oops
Description: 
While playing a soundfile using my Tascam us-122 (Alsa Module snd-usx2y)
after a few seconds the sound stutters and i get an Kernel oops. 
This is not happening if I use Jack.
I'm using the latest alsa drivers 1.0.5. With kernel 2.6.6. 

dmesg:
Debug: sleeping function called from invalid context at mm/slab.c:1996
in_atomic():1, irqs_disabled():1
 [<c01152f7>] __might_sleep+0xb7/0xe0
 [<c013be33>] __kmalloc+0xa3/0xb0
 [<c026dad1>] usb_alloc_urb+0x21/0x60
 [<f89b3775>] snd_usX2Y_substream_prepare+0xd5/0x1c0 [snd_usb_usx2y]
 [<f89b3397>] snd_usX2Y_urb_play_start+0xa7/0x170 [snd_usb_usx2y]
 [<f89b35bf>] snd_usX2Y_pcm_play_trigger+0x3f/0x50 [snd_usb_usx2y]
 [<f89490e8>] snd_pcm_do_start+0x28/0x30 [snd_pcm]
 [<f8948dc9>] snd_pcm_action_single+0x39/0x70 [snd_pcm]
 [<f8948f12>] snd_pcm_action_lock_irq+0x92/0x1e0 [snd_pcm]
 [<c0112a8c>] do_page_fault+0x34c/0x54e
 [<f894c4d7>] snd_pcm_common_ioctl1+0x167/0x2f0 [snd_pcm]
 [<f894c6c0>] snd_pcm_playback_ioctl1+0x60/0x3b0 [snd_pcm]
 [<c0150a32>] vfs_write+0xd2/0x130
 [<c0162f20>] sys_ioctl+0x100/0x270
 [<c010413b>] syscall_call+0x7/0xb



======================================================================

----------------------------------------------------------------------
 karsten - 06-24-2004 22:17 CEST 
----------------------------------------------------------------------
As a test please replace all occurrences of GFP_KERNEL in 
function snd_usX2Y_substream_prepare() with GFP_ATOMIC.
That function is in alsa-driver/usb/usx2y/usbusx2yaudio.c.

Thanks for debugging.

----------------------------------------------------------------------
 maggoi - 06-28-2004 09:51 CEST 
----------------------------------------------------------------------
Thank's a lot, this has solved the issue. Will you include this fix in
further versions?

----------------------------------------------------------------------
 maggoi - 06-28-2004 10:34 CEST 
----------------------------------------------------------------------
Sorry i was to fast. The old error message has gone, but after aprox. 10
min. of listening to a mp3 file by xmms (alsa plugin) the sound becomes
completely distorted. I don't if this dmesg output is alsa related:
ALSA
/var/tmp/portage/alsa-driver-1.0.5a/work/alsa-driver-1.0.5a/alsa-kernel/usb/usbmidi.c:149:
urb status -108
ALSA
/var/tmp/portage/alsa-driver-1.0.5a/work/alsa-driver-1.0.5a/alsa-kernel/usb/usbmidi.c:134:
usb_submit_urb: -32
    ACPI-0279: *** Error: Looking up [BST0] in namespace,
AE_ALREADY_EXISTS
    ACPI-1133: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node
f7fbe928), AE_ALREADY_EXISTS

----------------------------------------------------------------------
 karsten - 06-28-2004 21:04 CEST 
----------------------------------------------------------------------
The "ALSA......" lines are indeed ALSA-related. That issue is fixed in cvs
and shouldn't harm pcm playback.
The ACPI errors could cause distortion.
Please switch off the acpi-deamon.
Here I would do this as su with "/etc/init.d/acpid stop".
You could also use the kernel boot option acpi=off.
And yes, there will be a fix for the "Debug: sleeping function called from
invalid context" error. It will be a rearangement of some functions; more
complicated than this test-fix.

----------------------------------------------------------------------
 maggoi - 06-29-2004 10:45 CEST 
----------------------------------------------------------------------
Sorry, with alsa related i meant the acpi lines. But anyway, does this mean
that the usx2y driver will not work with acpi at all? I used my tascam
us-122 under WinXP and had also issues with drop outs while acpi was
switched on.
Thanks for your efford.

----------------------------------------------------------------------
 tiwai - 06-30-2004 15:44 CEST 
----------------------------------------------------------------------
You can set SNDRV_PCM_INFO_NONATOMIC_OPS to pcm->info field, so that
prepare callback is called outside the spinlock.  See usbaudio.c.

----------------------------------------------------------------------
 karsten - 07-01-2004 00:43 CEST 
----------------------------------------------------------------------
Does setting SNDRV_PCM_INFO_NONATOMIC_OPS also allow to sleep in start
callback? Don't think so, no?
usx2y support should evolve like this I think:

params_callback(){
// handle out params with userspace
}

prepare_callback(){
//actually set hardware: usbinterface for format,
//& submit some urbs to set the rate.
//AND prepare, start all needed isochronus endpoints.
//May sleep here if we set SNDRV_PCM_INFO_NONATOMIC_OPS.
}

start_callback(){
// activate interaction with alsas pcm stream.
// Don't sleep here, no?
}

stop_callback(){
// deactivate interaction with alsas pcm stream.
// Don't sleep here neither ;-)
}

hw_free_callback(){
// May sleep here.
// stop unneeded isochronus endpoints.
}

Code is all there, but currently not always in erm... their callbacks.

----------------------------------------------------------------------
 karsten - 07-15-2004 11:48 CEST 
----------------------------------------------------------------------
hi maggoi

please test with the latest version from alsa cvs.
The issue "Debug: sleeping function called from invalid context at
mm/slab.c:1996" should be solved.
Stuff should also work with an ACPI or APM enabled kernel.
To hold off buggy ACPI or APM implementations from disturbing ALSA's
operations (i.e. by disabling interrupts for too long) switch off the
relevant deamons (that's what I do here) or even boot with acpi=off or
apm=off.
To help fixing ACPI please mail to LKML. 

Thanks
karsten

----------------------------------------------------------------------
 maggoi - 08-25-2004 10:02 CEST 
----------------------------------------------------------------------
Hi Karsten,
I'm now using alsa-driver 1.0.6. with kernel 2.6.8.1 The sleeping function
issue is solved. Thanks for that ;-) I consider to send the following
errors also to the acpi dev-team because I don't know how related they
are: 

The Kernel
Aug 25 07:33:37 uma kernel:     ACPI-0279: *** Error: Looking up [BST0] in
namespace, AE_ALREADY_EXISTS
Aug 25 07:33:37 uma kernel:     ACPI-1133: *** Error: Method execution
failed [\_SB_.BAT0._BST] (Node f7fbd920), AE_ALREADY_EXISTS
Aug 25 07:37:54 uma kernel: ALSA
/var/tmp/portage/alsa-driver-1.0.6a/work/alsa-driver-1.0.6a/alsa-kernel/usb/usx2y/usbusx2yaudio.c:304:
Sequence Error!(ep=10;nuc=0,frame=490)
Aug 25 07:37:54 uma kernel: ALSA
/var/tmp/portage/alsa-driver-1.0.6a/work/alsa-driver-1.0.6a/alsa-kernel/usb/usx2y/usbusx2yaudio.c:304:
Sequence Error!(ep=8;nuc=1,frame=490)
Aug 25 07:37:55 uma kernel: ALSA
/var/tmp/portage/alsa-driver-1.0.6a/work/alsa-driver-1.0.6a/alsa-kernel/usb/usx2y/usbusx2yaudio.c:304:
Sequence Error!(ep=8;nuc=0,frame=491)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-24-04 18:06 maggoi         New Bug                                      
06-24-04 18:06 maggoi         Distribution              => Gentoo          
06-24-04 18:06 maggoi         Kernel Version            => 2.6.6           
06-24-04 22:17 karsten        Bugnote Added: 0001337                       
06-28-04 09:51 maggoi         Bugnote Added: 0001343                       
06-28-04 10:34 maggoi         Bugnote Added: 0001344                       
06-28-04 21:04 karsten        Bugnote Added: 0001346                       
06-29-04 10:45 maggoi         Bugnote Added: 0001347                       
06-30-04 15:44 tiwai          Bugnote Added: 0001351                       
07-01-04 00:43 karsten        Bugnote Added: 0001367                       
07-15-04 11:48 karsten        Bugnote Added: 0001431                       
08-25-04 10:02 maggoi         Bugnote Added: 0001619                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
