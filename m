From: Jaroslav Kysela <perex@suse.cz>
Subject: 1.0.3 release
Date: Sun, 29 Feb 2004 16:23:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402291616380.1880@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	it was quite busy month for the ALSA development. The 1.0.3 
packages were released. I would like to note that most of problems with 
rate resampling plugin were solved (thus indirectly the most of dmix 
issues, too). Also, aoss wrapper code (alsa-oss package) was recoded
and improved.
	Two new drivers were added: HDSP MADI and snd-atiixp for ATI 
chips.
	If you reported a bug, please, check, if this new code solves your 
problem and write the actual situation to your bug-report. Thanks.

					Enjoy new ALSA,
						Jaroslav

Changelog:

* alsa-driver
  - lot of compilation fixes (2.6 kernels, other archs)
  - gcc 3.5 related fixes
  - rawmidi midlevel
    - copy_*_user() function cannot be called from spinlock context
  - OSS mixer emulation
    - improved (added check for more controls)
  - OSS PCM emulation
    - fixed poll behaviour (read/write) to solve arts CPU overloading problems
  - sequencer core
    - fixed the mutex race conditions
    - fix KERNEL_QUOTE event timestamping
    - fix typo in port_broadcast_event
    - fix typo in port flags
    - add GM2 capability bit
  - sequencer midi
    - fixed the behavior of SNDCTL_SEQ_IOCTL (don't close the device)
  - added HDSP MADI driver by Winfried Ritsch
  - added snd-atiixp driver for ATI IXP 150/200/250 chips
  - bt87x driver
    - moved to alsa-kernel tree (thus to 2.6 mainstream)
  - PDAudioCF driver
    - moved to alsa-kernel tree (thus to 2.6 mainstream)
  - MixArt driver
    - moved to alsa-kernel tree (thus to 2.6 mainstream)
  - FM801 driver
    - added support for TEA575x radio tuners (over GPIO)
  - AC97 codec
    - fixed the mic gpio switch handling on the old ALC650.
    - fixed the wrong register initialization on ALC655/658.
    - fixed the detection of surround/LFE VRA on ALC650.
    - fix for AD1885
      - set the default MISC register value.
      - disabled 'digital audio mode', which seems problematic on many boards.
    - added AD1888 support
    - fixed the initial value of AD_MISC register for AD1885.
    - fixed swap_headphone() quirk when headpone controls do not exist
    - fixed the handling of S/PDIF rates.
      the IEC958 status bits are updated according to the current rate
  - EMU10K1 drive
    - improved the mixer names of Audigy2 without AC97 codec for better
      OSS emulation
    - fixed page overflow - soundfont loading
  - ICE1712 driver
    - added the support for Digigram VX442 board
  - ICE1724 driver
    - Aureon - fixed the GPIO pins for CS8415 CS and CDTO
    - fixed the access in trigger callback to byte access.
      (may fix the problem on ppc.)
    - added the support of independent surround PCM for ice1724
  - vix82xx driver
    - small code cleanups
    - fixed the codec valid check at reading.
    - added MSI KT266 to the dxs whitelist.
    - fixed the dxs support of ASUS K8V.
    - added a short delay in the codec read routine.
    - added ac97_quirk manual override module parameter
    - changed the default DXS of GA-7VAXP to NO_VRA
    - added the dxs default for MSI KT6 Delta-SR.
    - fixed the calculation of rate bits (based on 0x100000)
    - added dxs_support default for EPIA MII
    - added the dxs_support default for Uniwill laptop
  - intel8x0 driver
    - added the ac97 quirks for amd64 mobo and MSI P4 ATX 645.
    - check the return value of snd_ac97_pcm_open() in playback open callback
    - added ac97_quirk manual override module parameter
    - added the ac97 quirk for Intel D845WN (82801BA)
    - return with IRQ_RETVAL() for the unknown IRQ bits (often found on nForce2)
      with debug messages
    - clean up the irq status bit debugging
    - added nVidia Ck8S support
  - USB audio driver
    - assign PCM unique (sub)streams for each USB format type.
      this will avoid the mix up of format I and format III on M-audio transit.
    - Terratec PHASE 26 MIDI support
    - added the quirk for Edirol UA-3FX
  - usbusx2y driver
    - enabled the support for US224
  - es1688 driver
    - fixed mpu401 port validation
  - trident driver
    - fixed s/pdif control initialization (loading problem)
  - HDSP driver
    - fixed wrong assert, added checks for copy_*_user functions
  - MPU401 UART
    - remove unneeded technical information from port names
  - ALS4000 driver
    - fixed the build without joystick support
  - CMIPCI driver
    - use 0x201 as the default joystick port address 
  - gus-interwave
    - InterWave STB without TEA6330T without TEA6330T also exists
  - PPC tumbler driver
    - fixed the resume of bass/treble volumes on snapper
  - AK4531 (ENS1370) driver
    - Aux Input Route -> Aux Capture Route renaming
  - library for VX cards
    - fixed the wrong locks  - use spin_lock_irqsave() now
    - fixed the missing input VU meter
    - fixed the 24bit mono recording
  - snddevices
    - create proper OSS rawmidi devices (/dev/midi0X)
* alsa-lib
  - added --with-tmpdir configure option.
    the directory used for socket files of direct pcm plugins
  - fixed ICE1712.conf (spdif device definition)
  - fixed ICE1724.conf
    - added the indepdent front, rear, center_lfe support
  - fixed RME9636.conf (the control type of "IEC958 Playback PCM Stream")
  - fixed RME9652.conf
  - fixed the type punning (compilation warnings with the recent GCC)
  - test code
    - cleanups for gcc 2.9x
    - fixed wrong initialization of start_threshold
  - PCM API
    - added start_threshold sanity checks for snd_pcm_sw_params()
  - dmix, dsnoop
    - the format check condition was wrong (dmix<->dsnoop)
    - dmix asm code - don't use register bx/ebx - it's GOT pointer for
      -fPIC libraries
  - rate plugin
    - redesigned; now only whole periods are resampled to
      avoid rounding problems and to allow using other "block" algorithms
  - jack plugin
    - this patch changes the JACK plugin to use a unique client name, which
      allows for multiple ALSA streams to share a JACK server
  - file plugin
    - fixed bugs (zero sample stream)
  - marked _snd_pcm_mmap_hw_ptr() and _snd_pcm_boundary() functions as obsolete
* alsa-utils
  - alsamixer
     - show the version number of the package.
     - use ACS_CKBOARD for the volume bars.
     - fixed the path of /proc/asound/oss/devices.
     - fixed the max length to display the item name.
     - support for ncurses 5.4+
  - add aplaymidi & arecordmidi utilities
  - added --with-curses option to specify the curses library
* alsa-tools
  - envy24control
    - Delta1010LT has wordclock too
    - some fixes to handle channels correctly (still needs some work)
* alsa-firmware
  - added/fixed US112 and US224 firmware
* alsa-oss
  - total redesign
    - separated LD_PRELOAD wrapper code & OSS->ALSA emulation code
    - introduces oss-redir code (OSS API redirector)
    - introduces test utils (osstest & lmixer)
    - added mangling of OSS power of two parameters to ALSA any size
      parameters
    - improved mmap() emulation code

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
