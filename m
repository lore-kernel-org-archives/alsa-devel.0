From: Jaroslav Kysela <perex@suse.cz>
Subject: ALSA 1.0.6 released
Date: Mon, 16 Aug 2004 14:49:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408161446540.1780@pnote.perex-int.cz>
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
To: ALSA Announce <alsa-announce@alsa-project.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	here is a list of all changes between 1.0.5a and 1.0.6a release.
The 1.0.6a driver package fixes the /proc problem with loading of the 
sequencer client modules.

* alsa-driver
  - core
    - fixed the detection of x86-64 arch
    - 2.6 kernel sync - mostly __user stuff
    - This patch removes snd_kcalloc() from the kernel and updates callers to
      use the new generic kcalloc().
    - Removal and replacement of magic memory allocators and casts
    - Clean up of obsolete MODULE_* stuff (core part)
      - Removed MODULE_CLASSES() and MODULE_SYNTAX().
      - Replaced MODULE_DEVICES() with MODULE_SUPPORTED_DEVICE()
    - Clean up the PCI resource allocation.
    - Clean up the suspend/resume: save/restore of pci state
    - use ARRAY_SIZE() instead of sizeof() computations
    - Clean up: removed ifdefs and obsolete codes.
    - Unlock BKL in ioctl callback to avoid the long preempt-disabling.
    - Clean up DMA buffer allocation routines.
    - Fix up sound driver proc-reading interfaces.
  - PCM midlevel
    - stack usage reduction
    - Clean up and optimization of PCM format-specific functions
    - Clean up the buffer management in the PCM runtime record
    - Fix the mmap via io_remap_page_range() on nm256, rme32 and rme96.
      Added SNDRV_PCM_INFO_MMAP_IOMEM to handle this case.
    - Clean up the indirect accessing on RME32/RME96 drivers.
    - Clean up of indirect PCM data transfer with helper functions.
    - snd_pcm_timer_resolution_change() - better precision
    - The PCM prepare callback is now non-atomic, so that the driver can
      use the functions calling schedule (e.g. kmalloc with GFP_KERNEL).
    - Fixed/improved XRUN detection
      - don't print XRUN message in the case of draining.
      - pointer callback can return SNDRV_PCM_POS_XRUN to notify the middle layer.
    - ioctl32 - Added the wrapper for sync_ptr and hwsync ioctls.
    - Serialize runtime->status->state access
  - PCM OSS emulation
    - reduce stack usage
  - sequencer
    - use separate functions for some ioctls to reduce stack usage
    - Clean up Makefiles for the sequencer stuff using reverse selections.
  - Added Intel ICH6 HD Audio (Azalia) driver.
  - Added Audigy-LS driver
  - Added snd-atiixp driver for ATI IXP AC97 modem controllers.
  - Moved back pc98-specific stuff again to alsa-driver tree.
  - ICE1724
    - SPDIF output fixes
    - Fixed the volume update on aureon.
    - Removed the bogus master volume from aureon.
    - Fixed the wrong number of ADCS (not used, though).
    - Don't access GPIO high bits on VT1720.
    - Fixed the buffer byte alignment for SPDIF and independen PCMs.
    - Proper rate constraints according to the I2S/AC-link connection.
    - Clean up the private data for PCM callbacks.
    - Clean up spinlocks.
    - aureon - Added master volume control.
    - Added the (experimental) support of Terratec Phase 88.
    - Added the support of Pontis MS300 to snd-ice1724 driver.
    - Added the support of ZNF3-250 (supposed to be ZNF3-150 compatible).
  - CS46xx
    - add memory allocation checks in cs46xx_dsp_proc_register_scb_desc()
    - reduce stack usage
  - intel8x0
    - Added the PCI ID for nVidia CK8
    - Fixed the calculation of the current DMA position on some sloppy devices.
    - Fixed the detection of sample rates with no VRA support.
    - Added the support of nVidia CK804.
    - Added the support of MCP04.
    - Fixed the handling of unknown irqs on ICH5.
    - Added an ac97 quirk for ICH/AD1885 mobo.
    - Added buggy_irq module parameter to intel8x0 driver.
  - intel8x0m
    - Added the support of SIS7013 modem.
  - via82xx
    - Fixed the calculation of the current DMA position at the period boundary.
    - Added the ac97_quirk entry for ECS K7VTA3 v8.0 mobo.
    - Fixed the check of invalid DMA position.
    - Added the quirk entry for ECS L7VMM2 uATX.
    - Added the DXS whitelist entry for Acer Inspire 1353LM.
  - ali5451
    - Fixed the suspend/resume.
  - Opti9xx
    - Fixed spin deadlocks
  - USB audio
    - Quattro USB: handle the different endianness of playback and recording
      sample data
    - handle devices that allow setting but not reading sample rate
    - new functions snd_usbmidi_input_stop() and snd_usbmidi_input_start()
      needed by snd-usb-usx2y to be able to use usb_set_interface()
    - add support for Yamaha CVP-301, CVP-303, CVP-305, CVP-307, CVP-309,
      CVP-309GP, PSR-1500, PSR-3000, ELS-01, ELS-01C, PSR-295, PSR-293,
      DGX-205, DGX-203, DGX-305, DGX-505, DGP-7, DGP-5, PM5D, DME64N,
      DME24N, DTX, UB99
  - USX2Y
    - all pcm streams have to operate at the same rate and format
    - renamed functions
    - set NRPACKS to 1 as default setting to improve latency
    - Don't sleep in START/STOP callbacks anymore.
    - us428 channels C/D not handled just for this version, sorry.
  - MixArt
    - reduce stack usage
  - ES1938
    - fixed quake playback
  - ES1968
    - Fix the crash at unloading the module due to the shared interrupt
      with other devices.
  - Dummy
    - Do the buffer allocation in hw_params callback instead of open
      callback.
  - emu10k1
    - Merge EFX playback and capture streams to the single device (hw:0,2).
    - Fix Audigy + FX8010 capture (hw:x,2)
    - Audigy 2 ZS - side support
    - Enable low latency EFX capture on emu10k1
  - au88x0
    - Fixed the wrong pointer cast on 64bit architectures.
  - CMIPCI
    - reduce stack usage
    - don't sleep in prepare callback
    - Fix the i/o port range of gameport on cmipci
  - AC97 codec
    - Fixed the detection of STAC9708/11 surround control.
    - Check the validity of registers before creating controls.
    - move AC'97 bus callbacks into seperate ops record;
    - remove ac97_bus_t template requirement from snd_ac97_bus()
    - replace ac97_t template with ac97_template_t
    - Fixed the reset problem of shared audio/modem drivers.
    - Don't use mute bit in REC_GAIN register during tests.
    - Add more timeout to avoid not respond messages
  - emu10kx
    - added capture support
    - added S/PDIF support (untested)
    - fixed interrupt bug when playing multiple channels
    - split channels into separate PCMs
    - documented some of the registers
    - added support for more periods (up to 512 for playback)
    - formatting clean up
    - MIDI support
    - voice clean up
    - delayed interrupt enable/disable
    - playback/capture constraints added
    - fixed max number of periods
  - nm256
    - Added AC97 CD register to the list of allowed registeres.
  - RME32
    - Added the experimental fullduplex support.
  - OPL4
    - reorganize locking
    - optimize memory accesses
  - PPC drivers
    - Added the PCM beep support
  - PMAC
    - pmac also apply the DMA stop work around to fix capture on iBook2
    - Removed non-functional 48kHz support from pmac driver.
  - soundfont
    - Fixed messy locks in soundfont support code.
* alsa-lib
  - emu10k1 config
    - Added surround71 and side pcm definitions.
    - Added the support of side speakers on Audigy 2 ZS.
  - ice1724
    - Fixed iec958 capture using asym plugin.
    - Added the support of side and surround71 PCM types.
  - pcm_rate plugin
    - This patch fixes a number of different bugs in pcm_rate.c.
  - pcm_plug plugin
    - Fixed problem with the route plugin and ttable
* alsa-utils
  - aplay
    - Show warning if the format is changed due to the file type.
      (e.g. WAV yields little-endian)
* alsa-tools
  - ac3dec
    - Fixed to support non-48k AC3 files.
  - sbiload
    - Support -P option to specify the patch path.
    - Distribute the missing patch files.
  - us428control
    - Added MMC support
    - Tascam US-224/428 MMC Implementation
* alsa-oss
  - Added the wrapper for fopen()
  - Checks more device file names for fopen() wrappers.
  - Fixed manpage.
  - The below patch [also attached] fixes the check for device files in
    /dev/sound/ [for users of devfs who have configured their apps to use
    /dev/sound/dsp, etc..] and  adds a note to the aoss manpage
    about the state of mmap support.

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
