From: Matt Flax <flatmax@ieee.org>
Subject: Re: Re: SiS7012 hang alsa version 0.9.3c
Date: Mon, 26 May 2003 23:26:10 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030526132610.GA27490@ee.unsw.edu.au>
References: <20030524170852.GB15643@ee.unsw.edu.au> <Pine.HPX.4.33n.0305261041530.24202-100000@studcom.urz.uni-halle.de>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA05524
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2003 14:41:30 +0200
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0305261041530.24202-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I  just checked the BIOS - it is a mobile bios and does not let you turn 
IRQs on/off nor other stuff ...

In the bios it reports the card as a SiS 7018.
This would mean it requires the trident driver.

Still no success ! I am   beginning to believe that it is something else 
! It is a mobile combo chip ... SiS M650 and SiS962

dmesg prints:
Trident 4DWave PCI soundcard not found or device busy

Module inst. reports :
/lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o: insmod 
/lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o failed
/lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o: insmod 
snd-trident failed


lspci  -v  prints :

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
        Flags: medium devsel
        I/O ports at 1c00 [disabled] [size=256]
        I/O ports at 1800 [disabled] [size=128]
        Capabilities: [48] Power Management version 2




On Mon, May 26, 2003 at 10:44:31AM +0200, Clemens Ladisch wrote:
> Matt Flax wrote:
> > When I try to load the intel alsa module I get a hang state, with this
> > output :
> > PCI: Enabling device 00:02.7 (0000 -> 0001)
> > PCI: No IRQ known for interrupt pin C of device 00:02.7. Please try
> > using pci=biosirq.
> > ALSA ../alsa-kernel/pci/intel8x0.c:2249: unable to grab IRQ 0
> >
> > So I appended that to the lilo.conf file and ran lilo, upon reboot -
> > same problem.
> 
> Apparently, your BIOS didn't allocate an interrupt for the AC'97 device.
> Try changing some PnP-related settings in the BIOS setup.
> 
> 
> HTH
> Clemens
> 

-- 
http://mffm.ee.unsw.edu.au

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
