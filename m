From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Problems with alsa on ARM
Date: Thu, 17 Jul 2008 10:56:24 +0100
Message-ID: <1216288584.31838.79.camel@localhost.localdomain>
References: <200807162122.21989.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF63F243AD
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 11:56:25 +0200 (CEST)
In-Reply-To: <200807162122.21989.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-07-16 at 21:22 +0100, Alan Horstmann wrote:
> Hi,
> 
> I am trying to assist a collegue, we're working on ARM (AT91), and having 
> probs with alsa stuff.
> 
> Can anyone help interpret this strace from aplay -v -Dhw:0 ourfile.wav?
> I am comparing it to the same operation on a desktop PC.  After all sorts of 
> pre-amble, it gets down to accessing snd devices:
> 
> open("/dev/snd/controlC0", O_RDONLY)    = 3
> close(3)                                = 0
> open("/dev/snd/controlC0", O_RDWR)      = 3
> ioctl(3, USBDEVFS_CONTROL, 0xbecd36ac)  = 0
> ioctl(3, 0x40045532, 0xbecd36b4)        = 0
> open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 4
> close(3)                                = 0
> ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbecd34f8) = 0
> fcntl(4, F_GETFL)                       = 0x802 (flags O_RDWR|O_NONBLOCK)
> ioctl(4, AGPIOC_INFO, 0xbecd36a4)       = 0
> ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbecd369c) = 0
> mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = -1 ENXIO (No such 
> device or address)
> ioctl(4, 0xc0844123, 0xbecd3618)        = 0
> fcntl(4, F_GETFL)                       = 0x802 (flags O_RDWR|O_NONBLOCK)
> fcntl(4, F_SETFL, O_RDWR)               = 0
> ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbecd398c) = 0
> 
> The first failure is from mmap2(..).  Exactly the same line (and values) is 
> successful on PC, but I don't know what it is doing or why it might fail.
> 
> There are no other negative returns at all, but after opening the wav file, 
> the playback info is written out, and set_params begins:
> 
> ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> ioctl(4, 0xc25c4111, 0xbecd3628)        = 0
> ioctl(4, 0xc0844123, 0x1c210)           = 0
> ioctl(4, 0xc0684113, 0xbecd3528)        = 0
> ioctl(4, 0x4140, 0)                     = 0
> ioctl(4, 0xc0844123, 0x1c210)           = 0
> write(2, "aplay", 5aplay)                    = 5
> write(2, ": ", 2: )                       = 2
> write(2, "set_params", 10set_params)              = 10
> write(2, ":", 1:)                        = 1
> write(2, "1012", 41012)                     = 4
> write(2, ": ", 2: )                       = 2
> write(2, "unable to install sw params:", 28unable to install sw params:) = 28
> 
> All seems to go OK with hw_params, but sw_params must return error (not seen) 
> as the error check fails.  The values printed out show xfer_align = 
> 3201120484 which looks suspicious to me.
> 
> Any clues on either of these would be greatly appreciated.
> 

This sounds similar to a recent gcc optimisation bug with ALSA on ARM. 

http://gcc.gnu.org/ml/gcc/2006-04/msg00578.html

Best to check your toolchain and userspace as AT91 audio is quite
mature.

Fwiw, Open Embedded builds a good cross toolchain and userspace for ALSA
on ARM (I use it).

Liam  
