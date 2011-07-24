From: "Horner, Richard" <Richard.Horner.ap@nielsen.com>
Subject: lib pcm DMA problems
Date: Sun, 24 Jul 2011 09:49:19 -0400
Message-ID: <D51C65FDC8957F46B8BF3A9389EFFBE51288C8D5@nawinmsx013.enterprisenet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail11.enterprisenet.org (mail11.enterprisenet.org
	[138.108.60.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 239E3243B5
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jul 2011 15:49:21 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

To Whom It May Concern:

 

I see some weird behavior from the PCI audio driver for the Hauppauge
analog tv card (model 44842, rev D1B2) where the card is tuning properly
but audio is no longer available over PCI bus.  This condition can
happen within an hour or as late as after multiple months of 24x7
operation.  Re-loading the TV card and ALSA driver stacks do not clear
this condition.  Only a warm boot clears it up.  

 

Debug prints in the PCI device sound driver, bt87x.c.
"snd_bt87x_interrupt()" handler indicate it is returning only IRQ_NONE
when in this state.  We also get a DMA error message from pcm_lib.c
which states "capture write error (DMA or IRQ trouble?)", which I
presume means DMA is turned off for this device.

 

How can I recover from this without a system reboot?  

 

Thank you so much!

 

Here is my system info:

# cat /proc/cpuinfo

processor       : 0

vendor_id       : CentaurHauls

cpu family      : 6

model           : 7

model name      : VIA Samuel 2

stepping        : 3

cpu MHz         : 533.309

cache size      : 64 KB

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 1

wp              : yes

flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow up

bogomips        : 1066.61

clflush size    : 32

power management:

 

-----------------------------------------------------------

Interrupts are still active on IRQ 5 during this state:

# cat /proc/interrupts

           CPU0

  0:  177526733    XT-PIC-XT        timer

  1:          2    XT-PIC-XT        i8042

  2:          0    XT-PIC-XT        cascade

  4:          1    XT-PIC-XT

  5:   18834539    XT-PIC-XT        bttv0, Bt87x audio

  7:          0    XT-PIC-XT        parport0

  8:          0    XT-PIC-XT        rtc0

  9:    1587422    XT-PIC-XT        eth0

 10:   12183885    XT-PIC-XT        VIA686A

 11:   77875422    XT-PIC-XT        uhci_hcd:usb1, uhci_hcd:usb2

 12:          7    XT-PIC-XT        i8042

 14:   17133058    XT-PIC-XT        ide0

 15:          0    XT-PIC-XT        ide1

NMI:          0   Non-maskable interrupts

LOC:          0   Local timer interrupts

SPU:          0   Spurious interrupts

RES:          0   Rescheduling interrupts

CAL:          0   Function call interrupts

TLB:          0   TLB shootdowns

TRM:          0   Thermal event interrupts

ERR:          0

MIS:          0

 

 

 

Rich Horner
Engineering and Technology
The Nielsen Company
813-366-5060
www.nielsen.com

 
