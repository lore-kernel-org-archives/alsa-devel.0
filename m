From: Jaroslav Kysela <perex@suse.cz>
Subject: ALSA 1.0.7
Date: Tue, 16 Nov 2004 09:19:46 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411160917160.21901@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Announce <alsa-announce@alsa-project.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

	I am proud to announce new ALSA version 1.0.7. Bellow is list of 
changes between 1.0.6 and 1.0.7.

					Jaroslav

* alsa-driver
  - core
    - fix compilation with gcc 2.95.x and 2.2.x kernels
    - enhance Kconfig help texts
    - Fix iomem variable type
    - 2.6 kernel code sync - module_param_array() should take a pointer
    - PCM
      - mmap callback is added to PCM ops
      - OSS emulation - fix for O_NONBLOCK write
      - Fixes for PCM/control 32bit emulation
      - Fix drain/drop of linked PCM streams
      - PCM boundary fix in 32bit compat layer
      - Fix non-blocking write in ALSA OSS emulation
      - nonblock_open=1 by default for OSS PCM API emulation
    - sequencer
      - OSS emulation fixes
      - suppress auto-loading of modules in module_init()
      - copy_to_user() return value checking in snd_seq_read()
      - Fix auto-loading of sequencer modules
      - fix sequencer sleeping in interrupt context
    - rawmidi
      - fix handling of EFAULT errors in snd_rawmidi_read/write
      - fix hang when writing to /dev/midi* with O_SYNC
  - new drivers
    - via82xx-modem driver
    - AudioScience asihpi driver
    - Portman2x4 driver
    - Fixed issues with Abit AV8
  - PPC Tumbler driver
    - suspend & mixer fixes
  - ES1938
    - added PM support
  - emu10k1
    - fixed AC97 master volume for Audigy
    - Audigy DSP support
    - Support for capture of 16,32,64 channels on emu10k1 device 2
    - Fix AC3 playback on SB Live
    - fixed emu10k1_fx8010_code_t structure to be less than 8192 bytes
    - add interval timer support
  - intel8x0
    - quirks for Dell Precision 450, HP xw4200 and xw8200
    - intel8x0: Fixed a long mdelay()
    - fixed resume when interrupts are shared with another devices
    - AC97 96 kHz sample rate support
    - add AC97 quirk for Fujitsu-Siemens E4010
    - remove gameport/MIDI support
    - Added Compaq Evo W4000 quirk
    - Improved clock measurement
    - Fix SPDIF rate setting for old ICHs
    - Fix SPDIF support on ICH4/5/6
  - via82xx
    - added the DXS entry for Uniwill/Targa Visionary XP-210
    - Disable legacy FM and SB to prevent lock-ups
    - ac97 quirk entry for Soltek SL-75DRV5
    - Fix DXS entry for GA-7VAX
    - Added dxs quirk for QDI Kudoz 7X/600-6AL
  - rme32
    - rme32 segfault fix
    - fixing a two-rme32-in-one-machine bug
  - hdsp
    - Fix for 64bit architectures
    - Fix the variable types in struct
    - Fix HDSP meter ioctl
    - RME9632 precise_ptr fix
  - ICE1712
   - Added support of Mediastation
   - Clean up ice1712 chip struct
   - Add routing/volume of ADAT I/O on EWS88D   
  - ICE1724
    - Added support for AudioTrak Prodigy 192 cards
    - fixes a bug that SPDIF-in mode can't be reset once after it's set
    - Allow the private EEPROM image for evaluation boards
    - aureon
      - fixed the master volume control
      - Fixed center/LFE volume controls
      - Provide individual driver names for Aureon and Prodigy boards
      - Aureon S/PDIF input fixes
      - Adds AC'97 support to Aureon cards
      - Fix Aureon CCS init sequence
    - pontis
      - buggy SPI communcation is fixed
      - fixed the return value of put callbacks of GPIO controls
      - corrected the initial register value of CS8416
  - maestro3
    - call pci_set_master() in resume (to be sure)
  - AC97
    - added jack sense switches for AD1885
    - AC97 96 kHz sample rate support
    - Added VIA shared type
    - Check ac97 codec id in quirk table
    - inverted EAPD support
    - added AC97_SCAP_DETECT_BY_VENDOR flag (for xbox)
    - Add (experimental) CM9761 support
    - fix DAC slot assignment
    - Fix AC97_EXTENDED_STATUS initialial value
    - Fixed SPDIF on CS4298
  - ATI IXP
    - add IXP400 support
    - Added workaround for buggy BIOS
  - ens1371
    - Fixed AC3-passthru on ens1371/1373 boards
    - Fix latency in ens1371 driver
  - ES18xx
    - Fixed a bug in setting the filter register
  - AZX (Intel HD Audio)
    - code update and clean-up
    - use ALSA proc info API and clean-up
  - Korg1212
    - Korg1212 misc fixes
  - USB Audio
    - add mixer quirk for LineX FM Transmitter
    - add UA-1000 sample rate detection
    - add Edirol UA-25 support
    - mixer - handle missing control bitmap when parsing MUDs
    - mixer - read bmControls array in correct order
    - mixer - fix parsing of mixer unit descriptors
  - OPL3
    - Fix / clean up OPL3 for CS4281
  - bt87x
    - detect errors reported by the hardware
    - don't stop capture on errors
    - add overclocking option for the analog input
    - use blacklist/whitelist for (non-)audio Bt878 cards
    - Limit parity error messages
  - ES1968
   - Remove delay() to improve latency
   - removes unneeded spin_lock_irqsave()s from snd-es1968
  - usX2Y
    - usx2y cleanups and fixes
    - snd-usb-usx2y 0.7.3
    - snd-usb-usx2y - crash fix for OHCI USB-HCDs
  - au88x0
    - more au88x0 eq cleanups
    - au88x0: set-levels cleanup
    - au88x0: sign_invert cleanup
    - au88x0: name typo
    - au88x0: comment and whitespace cleanup
    - au88x0: fix is-quad oops
    - au88x0: add resetup dma
    - fix data type mismatch in sign_invert
  - nm256
    - Add reset_workaround module option
  - cs46xx
    - Fix ac97 codec reset and clean up
  - CS4231
    - replace schedule_timeout() with msleep()
* alsa-lib
  - fixed endless loop when parsing backslash inside bad configuration file
  - suppress PAUSE and RESUME for direct plugins
  - dmix plugin - dont forget to return -EINVAL on errors
  - rate plugin - Fix the downsampling noise problem
  - Avoid zero division (sw_params)
* alsa-utils
  - Fix hyphens in man pages
  - aplay
    - don't parse -X option because such an option doesn't exist
    - allow argument for --sleep-min option
    - fix handling of .voc magic string
    - fix handling of .voc files on big-endian machines
    - remove superfluous "size" parameter from check_wavefile_space macro
    - reallocate buffer only if needed in check_wavefile_space
    - fix playback of >2GB .wav files
    - skip over padding bytes in .wav files
    - fix memory leak when playing .voc silence blocks
    - fix file length when recording >2GB .wav files
    - fix recording of >4GB files
  - alsamixer
    - display 2 different views of the mixer controls (Playback, Capture)
  - alsaconf
    - some fixes
    - fixed long options
    - Now -L option requires the logfile argument
    - corrected man page
* alsa-tools
  - envy24control
    - Fixed segfault when envy24control --help is called
* alsa-oss
  - Always initialize pointers before use
* alsa-firmware
  - license issues

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
