From: hugo.ferreira@mail.telepac.pt
Subject: [Fwd: [Alsa-user] Wits end: Opti931]
Date: Thu, 1 Aug 2002 8:04:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020801070450.FMJQ12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fep06-svc.mail.telepac.pt (fep06-svc.mail.telepac.pt [194.65.5.211])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA01775
	for <alsa-devel@alsa-project.org>; Thu, 1 Aug 2002 09:05:28 +0200
Received: from [127.0.0.1] by fep06-svc.mail.telepac.pt
          (InterMail vM.5.01.04.13 201-253-122-122-113-20020313) with SMTP
          id <20020801070450.FMJQ12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
          for <alsa-devel@alsa-project.org>; Thu, 1 Aug 2002 08:04:50 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Seeing as I did not get any response in the user's
list, I am trying my luck here. 

While scanning the latests messages on both user and 
developer lists, I have learned that to "cat" to ALSA
devices is a "no-no"; therefore the question in regards
to this issue should be ignored.

I will be glad to provide additional information, recompile
with debugging code added, etc. to diagnose this problem.

TIA,
Hugo.

> Hi,
> 
> I am at my wits end trying to make a Opti82C931 chip based card 
> (MED 3931 ver.2.0) work on my Linux box. I have it working on
> my Wn95 and NT 4.0 OSs. I even had it working with OSS's mad16 driver.
> To be honest, I thing something is amiss or buggy here because ISA PnP
> doesn't seem to work as it should.
> 
> 
> I have a Mandrake 8.1 installation, I compiled a new kernel with:
> 1. IsaPnP and generic PNP support
> 2. Sound kernel
> 3. No OSS modules or drivers were compiled into the kernel (I actually
>  removed these, period) 
> 4. I compiled with symbol versioning
> 
> 
> As for the Alsa stuff I:
> 
> 1. Compiled the drivers with the following options:
> ./configure --with-isapnp=no \
>            --with-sequencer=yes \
>            --with-oss=yes \
>            --with-debug=full 
> 
> 2. I also made & installed the libraries, tools and utilities (in that 
> order).
> 
> 3. I followed the instructions in INSTALL to no avail.
> Here is what I have:
> 
> /etc/modules.conf-----------------
> 
> # ALSA: native device number
> alias char-major-116 snd
> # OSS/Free portion: kernel soundcore muliplexer + OSS compatibility
> alias char-major-14 soundcore
> 
> # ALSA: toplevel soundcard
> alias snd-card-0 snd-opti93x
> # OSS/Free portion: OSS support
> alias sound-slot-0 snd-card-0
> 
> # /proc/isapnp
> # snd_fm_port   - port # for OPL3 device (0x388) ??
> options snd-opti93x snd_isapnp=0 snd_port=0x530 snd_fm_port=0x388 snd_mpu_port=0x330 snd_irq=10 snd_mpu_irq=9 snd_dma1=0 snd_dma2=1      
> 
> # OSS/Free emulation modules
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> 
> /etc/modules.conf-----------------
> 
> 
> 
> /etc/devfsd.conf-----------------
> 
> # ALSA stuff
> #LOOKUP 		snd 		MODLOAD ACTION snd
> #REGISTER 	sound/.*	EXECUTE /sbin/pam_console_apply
> #REGISTER 	snd/.*		EXECUTE /sbin/pam_console_apply
> # New
> LOOKUP 		snd 		MODLOAD ACTION snd
> REGISTER 	^sound/.* 	PERMISSIONS root.audio 660
> REGISTER 	^snd/.* 	PERMISSIONS root.audio 660
> 
> /etc/devfsd.conf-----------------
> 
> Ok, this is what I have noticed (someone may already know these symptoms):
> 
> 1. When I set the parameters via isapnp, the Alsa driver will change these.
> This seems to happen wether or not the parameters are the same.
> 
> 2. The parameters that are shown by a pnpdump are all the same for WSS/MSS
> port number (0x534). ALSA driver snd-opt93x does not like this and generates 
> an error.I have to use a 0x530.
> 
> 3. The OPL device is not activated if I use ioport 0x380. I can use 0x388
> though.
> 
> 2. I can only seem to load the modules if I:
> a) do not activate the devices in the isapnp.conf files or
> b) use the snd_isapnp=0 option
> c) add "(CSN 1 (LD 0 ( REG 2 (POKE 4))))" to the isapnp.conf file
> and configure the card directly.
> 
> Please note that, point b) occurs when I try to configure the card directly
> (see http://www.woodyweb.ca/~woody/opti931.html) 
> 
> Ok, now the interesting part. Once the driver is loaded I get the following 
> modules into the system:
> 
> lsmod ----------------------
> 
> Module                  Size  Used by
> snd-opti93x            13344   0 
> snd-pcm                60192   0  [snd-opti93x]
> snd-opl3-lib            6864   0  [snd-opti93x]
> snd-timer              11792   0  [snd-pcm snd-opl3-lib]
> snd-hwdep               4528   0  [snd-opl3-lib]
> snd-mpu401-uart         3600   0  [snd-opti93x]
> snd-rawmidi            14144   0  [snd-mpu401-uart]
> snd-seq-device          4352   0  [snd-opl3-lib snd-rawmidi]
> snd                    34848   0  [snd-opti93x snd-pcm snd-opl3-lib snd-timer snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
> soundcore               4176   3  [snd]
> ....
> 
> lsmod ----------------------
> 
> A few interesting observations:
> 1.) Although I configured interrupts 9 & 10, only interrupt 9 is listed.
>           CPU0       
>   0:     283776          XT-PIC  timer
>   1:      13044          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   4:      16341          XT-PIC  serial
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  MPU401 UART
>  13:          0          XT-PIC  fpu
>  14:      16641          XT-PIC  ide0
>  15:       1573          XT-PIC  ide1
> NMI:          0 
> ERR:          0
> 
> The count remains at 0 always.
> 
> 2.) Attempts to play "au" or "midi" files generates this error (using aplay):
> 
> ALSA ../alsa-kernel/core/pcm_lib.c:1871: playback write error (DMA or IRQ trouble?)
> ALSA ../alsa-kernel/core/pcm_native.c:1098: playback drain error (DMA or IRQ trouble?)
> ALSA ../alsa-kernel/core/pcm_native.c:1098: playback drain error (DMA or IRQ trouble?)
> ...
> 
> The errors from aplay are:
> 
> laying raw data '/usr/share/sndconfig/sample.midi' : Unsigned 8 bit, Rate 8000 Hz, Mono
> ALSA lib pcm_hw.c:407:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed: Input/output error
> 
> or 
> 
> Playing Sparc Audio '/usr/share/sndconfig/sample.au' : Mu-Law, Rate 8000 Hz, Mono
> aplay: pcm_write:968: write error: Input/output error
> 
> 
> 3.) Attempts to cat directly to the devices generates errors of  
> "file descriptor in bad state"
> example "cat file > /proc/asound/dev/pcmC0D0p"
> 
> 4.) When I unload the drivers using moprobe's -r option (with or without a
> following rmmod -a), "cat /proc/ioports", "cat /proc/dma" 
> generates a segmentation fault.
> The alsa driver generates the following errors:
> 
> ALSA ../../alsa-kernel/isa/opti9xx/opti92x-ad1848.c:1268: bad MAGIC (0x22)
> ALSA ../alsa-kernel/core/device.c:65: device free failure
> ALSA ../alsa-kernel/core/memory.c:74: Not freed snd_alloc_kmalloc = 100
> ALSA ../alsa-kernel/core/memory.c:84: kmalloc(100) from c48644e7 not freed
> 
> 
> 5) Calling "alsamixer -c 0" always causes a core dump (Floating point exception)
> 6) Calling "amixer -c 0" always causes a core dump (Floating point exception)
> 7) Calling "amixer -c 0 contents" or "controls" seems to work
> 8) Attempts to change the mixer's values fails.
> 
> I would like to know what steps I may take to diagnose/debug this problems.
> I think this is a question of the ISA configuration but I cannot seem to
> find the corrcet parameters. 
> 
> BTW, does anyone have the chip's datasheets. I cannot seem to get these from 
> Opti's site.
> 
> I have placed additional data at the end of this (already veruy long) e-mail
> in case this is also needed.
> 
> TIA.
> Hugo Ferreira
> 
> cat /proc/asound ------------------------
> 
> card0/
> cards
> dev/
> devices
> hwdep
> meminfo
> oss/
> pcm
> seq/
> timers
> version
> 
> cat /proc/asound/card0/midi -------------------
> 
> MPU-401 (UART)
> 
> Output 0
>   Tx bytes     : 0
> Input 0
>   Rx bytes     : 0
> 
> cat /proc/asound/card0/pcm0c/info-----------------
> 
> card: 0
> device: 0
> subdevice: 0
> stream: CAPTURE
> id: OPTi 82C93X
> name: 82C931
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 1
> subdevices_avail: 1
> 
> 
> cat /proc/asound/card0/pcm0c/info-----------------
> 
> card: 0
> device: 0
> subdevice: 0
> stream: PLAYBACK
> id: OPTi 82C93X
> name: 82C931
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 1
> subdevices_avail: 1
> 
> cat /proc/asound/devices -----------------
> 
>  0: [0- 0]: ctl
>   4: [0- 0]: hardware dependent
>   8: [0- 0]: raw midi
>  16: [0- 0]: digital audio playback
>  24: [0- 0]: digital audio capture
>  33:       : timer
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
