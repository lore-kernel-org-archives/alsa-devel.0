From: Jaroslav Kysela <perex@suse.cz>
Subject: ALSA 1.0.8 release
Date: Fri, 14 Jan 2005 17:21:45 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0501141717210.1757@pnote.perex-int.cz>
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

Hi all,

	as you probably noted, the ALSA 1.0.8 final packages are out. The
following lines describe the changes between 1.0.7 and 1.0.8. The
changelog is automagically generated so all changes should be noted. Also,
it is splitted to short and long version (long version is at the end).

						Jaroslav

Changelog
*********

* alsa-driver
  + Sound Core
    - build without kbuild subdirectory
    - fix cross-compile for 2.6 kernels
    - Fix build for sparc64
    - Fix build of SPARC32
    - Added pci_dev_present() function for 2.6.9- kernels
    - Moved via82xx-modem driver to alsa-kernel tree
    - Improve the parse of include path
    - Exclude .cvsignore from tarball
    - Rename of audigyls to ca0106 and support of SB Live 24bit
    - Fix make pack for 2.6.x
    - Hotplug firmware loader support
    - Add Digigram PCXHR driver
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Move emu10k1x driver to alsa-kernel
    - Move snd-ca0106 driver to alsa-kernel
    - Check CONFIG_FW_LOADER in configure
    - Add echoaudio drivers
    - Add a note about make install-modules
    - release: 1.0.8rc2
    - fix compiler version check
    - Split --with-cards to --with-card-options option
    - release: 1.0.8
  + ALSA Core
    - Add pci_save_state() in suspend
    - regenerated for the addition of pci_save_state().
    - fix module_param_array() wrapper for old 2.6 kernels
    - check CONFIG_COMPAT for snd-ioctl32
    - [trivial] Fix compile warnings
    - remove CONFIG_SND_VERSION
    - Export functions for ioctl32 wrapper
    - Clean up of kfree()/vfree() NULL checks
    - Added pci_dev_present() function for 2.6.9- kernels
    - ALSA core: misc cleanups
    - Remove the NULL pointer check in kfree/vfree wrappers
    - Fix unresolved symbols for 2.4 kernels
    - Add missing USX2Y_PCM hwdep entry
    - Clean up power-management
    - Clean up power-management
    - Export snd_ctl_elem_read/write() functions
    - Add volatile to IO pinters
    - Hotplug firmware loader support
    - compilation fixes for 2.2.x/2.4.x kernels
    - Add PCXHR hwdep iface type
    - Fix creation of control devices over udev
    - Fix msleep wrapper
    - Fix handling of user-defined controls
    - Add CODEC and BUS device types
  + Control Midlevel
    - Export functions for ioctl32 wrapper
    - Clean up power-management
    - Export snd_ctl_elem_read/write() functions
    - Fix creation of control devices over udev
    - Fix handling of user-defined controls
    - Fix the release of resources at error path
    - Clean up handling of user-defined controls
  + HWDEP Midlevel
    - ALSA core: misc cleanups
  + PCM Midlevel
    - fix iomem mmap
    - regenerated for iomem mmap fix
    - fix weird placement of static keyword in sound/core/pcm_memory.c
    - Export functions for ioctl32 wrapper
    - Clean up of kfree()/vfree() NULL checks
    - ALSA core: misc cleanups
    - Fix the wrong sign of format data entries
  + RawMidi Midlevel
    - ALSA core: misc cleanups
    - Fix ioctl arguments
  + Timer Midlevel
    - Clean up of kfree()/vfree() NULL checks
  + /kbuild/Makefile
    - build without kbuild subdirectory
  + AC97 Codec
    - add Line/Headphone jack detection for AD1981A/B
    - AD18xx/19xx resume fix
    - Disable "IEC958 Input Monitor" switch for ALC codecs
    - Fix compilation without CONFIG_PM
    - Fix detection of Xbox
    - Fix CMI9739A silent problem
    - Add mute LED quirk
    - Unify ac97 control callbacks
    - Remove spinlock in callbacks
    - Don't probe rates when bus->no_vra is set
    - Allow strings for ac97_quirk options
    - Clean up and fix stereo mutes
    - Fix C-Media codecs
    - Add codec id in component names
    - Fix Oops at resume
    - Adapt SPDIF Input selection for Realtek ALC658
    - Remove & from function pointers
    - Add suspend callback
  + AD1848 driver
    - ALSA ISA drivers: misc cleanups
  + AK4117 receiver
    - Add CODEC and BUS device types
  + AK4531 codec
    - Remove spinlock in callbacks
  + ALS100 driver
    - alternate ALS0200 ident string
  + ALS4000 driver
    - Add pci_disable_device() to removal and error paths
  + ALSA Version
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - release: 1.0.8rc2
    - release: 1.0.8
  + ALSA sequencer
    - fix MIDI GS chorus/reverb mode
    - Fix targets for GUS and OPL4
  + ALSA<-OSS emulation
    - Clean up codes
  + ALSA<-OSS sequencer
    - delete unused file
  + ATIIXP driver
    - Add pci_disable_device() to removal and error paths
    - Remove unnecessary ac97 spinlocks
    - Fix DMA pointer read
    - Add ac97_quirk option
  + ATIIXP-modem driver
    - Add pci_disable_device() to removal and error paths
    - Remove unnecessary ac97 spinlocks
  + AZT3328 driver
    - Add pci_disable_device() to removal and error paths
    - ALSA PCI drivers: misc cleanups
    - Fix compile warning (make inline)
    - Fix the order of creation of instances
  + CA0106 driver
    - Add snd-ca0106 driver
    - Add a new ID
    - Don't probe sample rates on non-VRA chips
    - remove compatibility code for 2.2.x kernels
  + CMIPCI driver
    - 2.6 kernel sync
    - Fix the order of creation of instances
  + CS4231 driver
    - ALSA ISA drivers: misc cleanups
    - ifdef typos: sound_isa_cs423x_cs4231_lib.c
  + CS4236+ driver
    - alternate CS4235 ident string
  + CS4281 driver
    - Fix the order of creation of instances
  + CS46xx driver
    - [trivial] Fix compile warnings
    - Add 'Duplicate Front' control
    - Use msleep() in ac97 callbacks
  + Common EMU synth
    - misc cleanups
  + Digigram VX core
    - misc cleanups
    - Fix memory corruption
    - Hotplug firmware loader support
    - Hotplug firmware loader support
    - Fix compilation errors
  + Digigram VX222 driver
    - Hotplug firmware loader support
  + Documentation
    - Addition of pci_disable_device() and cleanup
    - Added VIA82xx-modem driver
    - Clean up power-management
    - More rewrite of azx and hda-codec drivers
    - Add description about hotplug fw loader
    - Add emu10k1x driver
    - Add snd-ca0106 driver
    - Update documentation for hotplug fw loader
    - Description about snd_card_set_dev()
    - Fix description of ALSA/OSS device mapping
    - Fixed description about ac97_quirk
    - Add ac97_quirk option
  + EMU10K1/EMU10K2 driver
    - minor send routing cleanup
    - whitespace cleanup
    - fix display of send routing in /proc
    - ALSA PCI drivers: misc cleanups
    - Fixes the "It disables the right channel" bug
    - Support for Audigy2 Value SB0400
    - add register dump to proc
    - Fixed problem with changing size of etram
    - Fix the detection of Audigy2 ZS
    - Add emu10k1x driver
    - Code clean up
    - Fix compile warning
    - Don't probe sample rates on non-VRA chips
    - Print values at errors
  + EMU8000 driver
    - fix chorus/reverb FX loader
  + ENS1370/1+ driver
    - Trivial patch to enable rear out selection for ens1373 on
    - Remove unnecessary ac97 spinlocks
    - Fix the order of creation of instances
  + ES1688 driver
    - ALSA ISA drivers: misc cleanups
  + ES18xx driver
    - ifdef typos: sound_isa_es18xx.c
  + ES1938 driver
    - Fix interrupt generation on MIDI input for es1938 sound cards
  + ES1968 driver
    - Fix sleep in h/w volume control
    - Don't probe sample rates on non-VRA chips
  + FM801 driver
    - Fix spinlocks
  + GUS Library
    - ALSA ISA drivers: misc cleanups
  + Generic drivers
    - compile fix for 2.6.10
  + HDSPM driver
    - Change the peak meter ioctl to use indirect access
  + I2C cs8427
    - misc cleanups
  + I2C lib core
    - Add CODEC and BUS device types
  + ICE1712 driver
    - Fix WM8770 Init
    - IEC958 Capture mixer controls and Universe support
    - Midiman Delta DIO2496 has two stereo analog outs
  + ICE1724 driver
    - IEC958 Capture mixer controls and Universe support
  + IOCTL32 emulation
    - Fix ioctl32 wrapper (for SPARC)
    - Fix ioctl32 wrapper (for SPARC)
    - Clean up of kfree()/vfree() NULL checks
    - Export snd_ctl_elem_read/write() functions
    - Fix ctl_read/write ioctl wrappers
  + Intel8x0 driver
    - 2.6 sync - bitfield signedness fix
    - AC97 quirks for Dell
    - fix sleep in atomic during prepare callback
    - misc clean up
    - Fix non-symmetrical page_attr changes
    - [trivial] Fix compile warning
    - Add mute LED quirk
    - Remove unnecessary ac97 spinlocks
    - Allow strings for ac97_quirk options
    - ac97 quirk entries for HP xw6200 & xw8000
    - Add quirk for HP zv5000
  + L3 drivers
    - Add CODEC and BUS device types
  + MIXART driver
    - [trivial] Fix compile warnings
    - Hotplug firmware loader support
    - Fix compilation errors
    - Fix NULL pointer access
    - Fix float format support
  + Memalloc module
    - fix the test of dma_mask
    - Clean up of kfree()/vfree() NULL checks
    - Fix SBUS-only memory allocation on older kernels
  + NM256 driver
    - Use msleep() in ac97 callbacks
  + OPL3
    - opl4 depends on opl3
    - misc cleanups
    - Add CODEC and BUS device types
  + OPL4
    - Add CODEC and BUS device types
  + PCI drivers
    - Added VIA82xx-modem driver
    - Add emu10k1x driver
    - Add snd-ca0106 driver
  + PDAudioCF driver
    - make some code static
  + PPC DACA driver
    - sync with 2.6 mainstream
  + PPC PMAC driver
    - sync with 2.6 mainstream
    - buffersize and constraints on pmac
    - Fix the invalid DMA pointer value
  + PPC Tumbler driver
    - sync with 2.6 mainstream
  + RME HDSP driver
    - Fix the missing line in the patch for hdsp accurate_ptr
    - Fix invalid "AutoSync Reference" value
    - Add hotplug firmware loader support
  + RME32 driver
    - Fix the interface type of mixer controls
  + RME96 driver
    - Fix interface type for some mixer controls
  + SA11xx UDA1341 driver
    - Clean up power-management
  + SB drivers
    - ALSA ISA drivers: misc cleanups
  + SPARC cs4231 driver
    - [trivial] Fix compilation warnings on 64bit
    - 2.6 kernel sync
  + Sound Scape driver
    - check __copy_to_user in sscape_upload_bootblock()
    - Update user-space access from sscape driver
  + SoundFont
    - misc cleanups
  + Synth
    - delete unused file
  + Trident driver
    - ALSA PCI drivers: misc cleanups
  + USB
    - hwdep interface for pcm data
  + USB USX2Y
    - Use macro usb_maxpacket() for portability
    - hwdep interface for pcm data
    - Add missing source codes in the last hwdep-pcm patch.
    - Fix open handling
    - Remove superfluous code
  + USB generic driver
    - Return -EBADFD when the device is disconnected
  + VIA82xx driver
    - via82xx: Enable DXS on ABIT KV8 Pro
    - sort DXS whitelist
    - disable legacy IRQs before request_irq() to avoid unhandled interrupts
    - Allow strings for ac97_quirk options
    - Add a DXS entry for ABIT VA-20
  + VIA82xx-modem driver
    - Added VIA82xx-modem driver
  + Wavefront drivers
    - Fix compile warning
  + YMFPCI driver
    - ALSA PCI drivers: misc cleanups
    - Avoid VRA on codec chips
  + au88x0 driver
    - Replace long delays with msleep()
    - Spinlock removal and loop fix
    - Fix spinlock
* alsa-lib
  + Core
    - Change error message handling
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Add accessor to user control elements
    - release: 1.0.8rc2
    - Add inclusion of time.h
    - release: 1.0.8
  + Control API
    - Add accessor to user control elements
  + Instrument API
    - Fix compilation with 2.6.9 kernel (glibc headers)
  + Mixer API
    - Add Front control to weight list
  + PCM API
    - Return correct error in snd_pcm_wait() after snd_pcm_poll_descriptors() call
    - appl_ptr sync fix when status/control structures are not mmaped
    - fix for capture for case when status/control structures are not mmaped
    - Fixes variable shadow problem in capture direction
    - Fixed few typos in documentation.
    - Add preamble value configuration for iec958 plugin
    - Change error message handling
    - fix changed error message handling
    - Add softvol PCM plugin
    - Add accessor to user control elements
    - Change the behavior with hardware volume controls
    - Set max volume as default for softvol
    - Fix missing declaration
    - Support stereo volume control
    - Performance optimization
    - Clear sw_params struct at initialization
    - Fix handling of DISCONNECT state
    - Fix compile warning
  + Configuration
    - Rename AudigyLS -> CA0106
    - Disable 'duplicate front' switch for rear
    - Add preamble value configuration for iec958 plugin
    - Add default for refer function
    - Make "default" PCM card-specific
    - Use softvol for PCM outputs
    - New config for ES1968 and Maestro3
    - New config for Azalia (intel HD audio) driver
    - Add new config files
  + Documentation
    - Change error message handling
    - Add softvol PCM plugin
  + Error handler
    - Change error message handling
  + I/O subsystem
    - fix miscalculation of buffer size in snd_output_buffer_need()
    - Removed wrong ATTRIBUTE_UNUSED
  + Kernel Headers
    - Sync with the driver (EFX code structure)
* alsa-utils
  + Core
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - i18nize alsaconf
    - Move m4 to the tail of SUBDIRS
    - Require alsa-lib 1.0.8
    - release: 1.0.8rc2
    - release: 1.0.8
  + ALSA Control (alsactl)
    - Support user-defined controls
    - Fix compilation
  + Speaker Test
    - Add man page of speaker-test
  + alsaconf
    - Start aplay/arecord in non-blocking mode
    - i18nize alsaconf
    - Misc clean up
    - Fix installation
    - Fix installation
  + alsamixer
    - Change the view toggle behavior
    - Assign alternative keys for function keys
    - Reinitialize the size calculation at view change
    - Add -V option
    - More descriptions about mixer views and view modes
    - Usability improvement
    - fix crashes when selecting an empty view
    - Remove number key assignment
    - Support quick volume change
  + aplay/arecord
    - Fix VU meter
* alsa-tools
  + Core
    - Add pcxhrloader
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Add echomixer
    - release: 1.0.8rc2
    - release: 1.0.8
  + Digigram Echo Mixer
    - Add echomixer
    - echomixer update
  + Digigram PCXHR Loader
    - Add pcxhrloader
    - Added missing cvscompile script
  + Envy24 Control
    - envy24control: midi support for mixer
    - Add auto-probing of ice1712 cards
    - Add missing midi.h
    - Fix the abort with MIDI control
    - Fix for envy24control and midi
    - Fix digital mixer checkboxes
  + RME Digi Control
    - Fix interface type of mixer controls
    - Fix interface type of mixer controls
* alsa-firmware
  + Core
    - Hotplug firmware loader support
    - Add pcxhrloader
    - release: 1.0.8rc1
    - Added missing Makefile for pcxhrloader
    - Add echoaudio firmware files
    - release: 1.0.8rc2
    - release: 1.0.8
  + Digigram Echo Audio Loader
    - Add echoaudio firmware files
    - Fix typo and fw path
  + Digigram MixArt Loader
    - Hotplug firmware loader support
  + Digigram PCXHR Loader
    - Add pcxhrloader
  + Digigram Vx Loader
    - Hotplug firmware loader support
  + RME HDSP Loader
    - Hotplug firmware loader support
* alsa-oss
  + Core
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Add so versions
    - release: 1.0.8rc2
    - release: 1.0.8
  + Manual Page
    - Add description of ALSA_OSS_PCM_DEVICE env variable
  + PCM Emulation
    - Fix periods_max setting
    - Misc improvement for PCM


Detailed changelog
******************

* alsa-driver
  + Sound Core
    - Summary: build without kbuild subdirectory
      The driver is built without kbuilt subdirectory by checking $(KERNELRELEASE)
      in the toplevel Makefile.
    - Summary: fix cross-compile for 2.6 kernels
      Fix cross-compile for 2.6 kernels.
      Also, CONFIG_COMPAT is checked for 2.6 kernels.
    - Summary: Fix build for sparc64
      Fix build for sparc64.
      Check of RTC kernel support is simplied, too.
    - Summary: Fix build of SPARC32
      Fixed the wrong compiler and linker checks for sparc32.
    - Summary: Added pci_dev_present() function for 2.6.9- kernels
    - Summary: Moved via82xx-modem driver to alsa-kernel tree
      Moved via82xx-modem driver to alsa-kernel tree
    - Summary: Improve the parse of include path
      Improved the parse of include path for the seprate kernel build
      directories.
    - Summary: Exclude .cvsignore from tarball
    - Summary: Rename of audigyls to ca0106 and support of SB Live 24bit
      snd-audigyls is renamed to more generic name, snd-ca0106.
      Now it's in the independent subdirectory pci/ca0106.
      The new driver supports SB Live 24bit, too.
      Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
    - Summary: Fix make pack for 2.6.x
      Fix "make pack" for 2.6 environment.
    - Summary: Hotplug firmware loader support
      The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
      drivers.  The old ALSA fw loader is still supported for built-in kernels.
      The hotplug fw is disabled on 2.2/2.4 kernels (although the recent 2.4
      could support it).
      To use the hotplug, the new firmware data must be installed beforehand
      from the latest alsa-tools package.
      The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
      too.
    - Summary: Add Digigram PCXHR driver
      Added Digigram PCXHR driver (snd-pcxhr).
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Summary: Move emu10k1x driver to alsa-kernel
      emu10k1x driver is moved to alsa-kernel tree.
    - Summary: Move snd-ca0106 driver to alsa-kernel
      snd-ca0106 driver is moved to alsa-kernel now.
    - Summary: Check CONFIG_FW_LOADER in configure
      CONFIG_FW_LOADER kernel config is checked in configure script.
    - Summary: Add echoaudio drivers
      Added echoaudio drivers by Giuliano Pochini <pochini@shiny.it>.
      These drivers require the firmware loader support on kernel
      (which is avalable on 2.6 and recent 2.4 kernels).
    - Summary: Add a note about make install-modules
      Add a short note about make install-modules.
    - release: 1.0.8rc2
    - Summary: fix compiler version check
      The compiler version check didn't actually look at the kernel
      compiler version.
    - Summary: Split --with-cards to --with-card-options option
      A new configure option --with-card-options is added.
      It contains the card-specific boolean options, which were specified in
      --with-cards option.
      The INSTALL doc is improved a bit.
    - release: 1.0.8
  + ALSA Core
    - Summary: Add pci_save_state() in suspend
      Added pci_save_state() in the ALSA suspend core callback since
      its call was removed from the PCI core driver in the recent
      version.
    - Summary: regenerated for the addition of pci_save_state().
    - Summary: fix module_param_array() wrapper for old 2.6 kernels
      Fixed the new module_param_array() wrapper for 2.6.4 or older kernels.
    - Summary: check CONFIG_COMPAT for snd-ioctl32
      check CONFIG_COMPAT for selection of snd-ioctl32 module.
    - Summary: [trivial] Fix compile warnings
      Fix trivial compile warnings.
    - Summary: remove CONFIG_SND_VERSION
      CONFIG_SND_VERSION is removed from here since it's already defined
      in version.h.
    - Summary: Export functions for ioctl32 wrapper
      Export some functions to access from ioctl32 wrapper.
      This will reduce the memory footprint (doublly kmalloc's for the same
      ioctl records).
    - Summary: Clean up of kfree()/vfree() NULL checks
      I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
      constructions. I'm going to to this for most of the kernel if I found
      some time.
      Signed-off-by: Marcel Sebek <sebek64@post.cz>
    - Summary: Added pci_dev_present() function for 2.6.9- kernels
    - Summary: ALSA core: misc cleanups
      The patch below does the following cleanups under sound/core/ :
      - make needlessly global code static
      - remove the following stale prototypes from pcm.h
        (the functions are not or no longer present):
        - snd_pcm_capture_ready_jiffies
        - snd_pcm_playback_ready_jiffies
      - remove the following unused global functions:
        - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
        - seq/seq_instr.c: snd_seq_cluster_new
        - seq/seq_instr.c: snd_seq_cluster_free
      - move global to static inline functions
        - pcm_lib.c: snd_pcm_playback_ready
        - pcm_lib.c: snd_pcm_capture_ready
        - pcm_lib.c: snd_pcm_playback_empty
        - pcm_lib.c: snd_pcm_capture_empty
        - pcm_lib.c: snd_pcm_playback_data
      - remove the following unused EXPORT_SYMBOL's:
        - snd_create_proc_entry
        - snd_interval_ratden
        - snd_midi_channel_init
        - snd_midi_channel_init_set
        - snd_pcm_playback_empty
        - snd_pcm_capture_empty
        - snd_pcm_playback_data
        - snd_pcm_capture_poll
        - snd_pcm_playback_ready
        - snd_pcm_capture_ready
        - snd_pcm_format_size
        - snd_pcm_open
        - snd_pcm_playback_poll
        - snd_pcm_playback_ready
        - snd_pcm_release
        - snd_pcm_subformat_name
        - snd_remove_proc_entry
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Remove the NULL pointer check in kfree/vfree wrappers
      The check of NULL pointer in kfree/vfree wrappers is removed.
      kfree() and vfree() accept NULL pointer.
    - Summary: Fix unresolved symbols for 2.4 kernels
    - Summary: Add missing USX2Y_PCM hwdep entry
      Added the missing SNDRV_HWDEP_IFACE_USX2Y_PCM definition.
    - Summary: Clean up power-management
      Clean up for PM code.
      snd_power_change() is called in the common routines instead of driver's callback.
    - Summary: Clean up power-management
      Clean up for PM code.
      snd_power_change() is called in the common routines instead of driver's callback.
    - Summary: Export snd_ctl_elem_read/write() functions
      snd_ctl_elem_read() and snd_ctl_elem_write() functions are exported
      to be accessible from other kernel modules.  They can be used for
      suspend/resume codes, for example.
    - Summary: Add volatile to IO pinters
      Add volatile prefix to IO pointers for copy_to_user_fromio() and
      copy_from_user_toio() functions.
    - Summary: Hotplug firmware loader support
      The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
      drivers.  The old ALSA fw loader is still supported for built-in kernels.
      The hotplug fw is disabled on 2.2/2.4 kernels (although the recent 2.4
      could support it).
      To use the hotplug, the new firmware data must be installed beforehand
      from the latest alsa-tools package.
      The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
      too.
    - Summary: compilation fixes for 2.2.x/2.4.x kernels
    - Summary: Add PCXHR hwdep iface type
      Added SNDRV_HWDEP_IFACE_PCXHR for Digigram PCXHR driver.
    - Summary: Fix creation of control devices over udev
      Don't create control devices before the driver initialization finishes
      (ALSA BTS #742).
      The control device is now handled in the device list together with others
      (holding the card instance as the device pointer).
    - Summary: Fix msleep wrapper
      Fixed the condition of msleep wrapper for the recent 2.4 kernels.
      Make msleep wrapper as a function.
    - Summary: Fix handling of user-defined controls
      Fixed handling of user-defined controls.
      The max number of user-defined controls is limited, too (as default 32).
    - Summary: Add CODEC and BUS device types
      Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
      components.
  + Control Midlevel
    - Summary: Export functions for ioctl32 wrapper
      Export some functions to access from ioctl32 wrapper.
      This will reduce the memory footprint (doublly kmalloc's for the same
      ioctl records).
    - Summary: Clean up power-management
      Clean up for PM code.
      snd_power_change() is called in the common routines instead of driver's callback.
    - Summary: Export snd_ctl_elem_read/write() functions
      snd_ctl_elem_read() and snd_ctl_elem_write() functions are exported
      to be accessible from other kernel modules.  They can be used for
      suspend/resume codes, for example.
    - Summary: Fix creation of control devices over udev
      Don't create control devices before the driver initialization finishes
      (ALSA BTS #742).
      The control device is now handled in the device list together with others
      (holding the card instance as the device pointer).
    - Summary: Fix handling of user-defined controls
      Fixed handling of user-defined controls.
      The max number of user-defined controls is limited, too (as default 32).
    - Summary: Fix the release of resources at error path
      Implemented free callback to fix the release of control resources
      before calling register.
    - Summary: Clean up handling of user-defined controls
      Cleaned up the code to handle user-defined controls.
  + HWDEP Midlevel
    - Summary: ALSA core: misc cleanups
      The patch below does the following cleanups under sound/core/ :
      - make needlessly global code static
      - remove the following stale prototypes from pcm.h
        (the functions are not or no longer present):
        - snd_pcm_capture_ready_jiffies
        - snd_pcm_playback_ready_jiffies
      - remove the following unused global functions:
        - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
        - seq/seq_instr.c: snd_seq_cluster_new
        - seq/seq_instr.c: snd_seq_cluster_free
      - move global to static inline functions
        - pcm_lib.c: snd_pcm_playback_ready
        - pcm_lib.c: snd_pcm_capture_ready
        - pcm_lib.c: snd_pcm_playback_empty
        - pcm_lib.c: snd_pcm_capture_empty
        - pcm_lib.c: snd_pcm_playback_data
      - remove the following unused EXPORT_SYMBOL's:
        - snd_create_proc_entry
        - snd_interval_ratden
        - snd_midi_channel_init
        - snd_midi_channel_init_set
        - snd_pcm_playback_empty
        - snd_pcm_capture_empty
        - snd_pcm_playback_data
        - snd_pcm_capture_poll
        - snd_pcm_playback_ready
        - snd_pcm_capture_ready
        - snd_pcm_format_size
        - snd_pcm_open
        - snd_pcm_playback_poll
        - snd_pcm_playback_ready
        - snd_pcm_release
        - snd_pcm_subformat_name
        - snd_remove_proc_entry
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + PCM Midlevel
    - Summary: fix iomem mmap
      The patch adds the definition vm_private_data again to
      snd_pcm_lib_mmap_iomem(). It got lost during the rewrite of
      the mmap stuff.
      Signed-off-by: Martin Langer <martin-langer@gmx.de>
    - Summary: regenerated for iomem mmap fix
    - Summary: fix weird placement of static keyword in sound/core/pcm_memory.c
      This patch moves the 'static' keyword to the beginning of the declaration
      to eliminate the following warning when building with gcc -W
      sound/core/pcm_memory.c:40: warning: `static' is not at beginning of declaration
      This has no actal imact on the code, but it's one less warning to sift
      through when looking for potential trouble-code with -W
      I have a hard time thinking of a reason to not apply this trivial patch :)
      Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
    - Summary: Export functions for ioctl32 wrapper
      Export some functions to access from ioctl32 wrapper.
      This will reduce the memory footprint (doublly kmalloc's for the same
      ioctl records).
    - Summary: Clean up of kfree()/vfree() NULL checks
      I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
      constructions. I'm going to to this for most of the kernel if I found
      some time.
      Signed-off-by: Marcel Sebek <sebek64@post.cz>
    - Summary: ALSA core: misc cleanups
      The patch below does the following cleanups under sound/core/ :
      - make needlessly global code static
      - remove the following stale prototypes from pcm.h
        (the functions are not or no longer present):
        - snd_pcm_capture_ready_jiffies
        - snd_pcm_playback_ready_jiffies
      - remove the following unused global functions:
        - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
        - seq/seq_instr.c: snd_seq_cluster_new
        - seq/seq_instr.c: snd_seq_cluster_free
      - move global to static inline functions
        - pcm_lib.c: snd_pcm_playback_ready
        - pcm_lib.c: snd_pcm_capture_ready
        - pcm_lib.c: snd_pcm_playback_empty
        - pcm_lib.c: snd_pcm_capture_empty
        - pcm_lib.c: snd_pcm_playback_data
      - remove the following unused EXPORT_SYMBOL's:
        - snd_create_proc_entry
        - snd_interval_ratden
        - snd_midi_channel_init
        - snd_midi_channel_init_set
        - snd_pcm_playback_empty
        - snd_pcm_capture_empty
        - snd_pcm_playback_data
        - snd_pcm_capture_poll
        - snd_pcm_playback_ready
        - snd_pcm_capture_ready
        - snd_pcm_format_size
        - snd_pcm_open
        - snd_pcm_playback_poll
        - snd_pcm_playback_ready
        - snd_pcm_release
        - snd_pcm_subformat_name
        - snd_remove_proc_entry
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Fix the wrong sign of format data entries
      Fix suggested by Benjamin Herrenschmidt <benh@kernel.crashing.org>
      On architectures like PPC, char is handled as "unsigned char", thus the
      pcm_format_data table entries with -1 give a positive 255.  This causes
      Oops with OSS-emulation on such architectures.
      The patch simply adds the right signed/unsigned prefix to fix this problem.
  + RawMidi Midlevel
    - Summary: ALSA core: misc cleanups
      The patch below does the following cleanups under sound/core/ :
      - make needlessly global code static
      - remove the following stale prototypes from pcm.h
        (the functions are not or no longer present):
        - snd_pcm_capture_ready_jiffies
        - snd_pcm_playback_ready_jiffies
      - remove the following unused global functions:
        - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
        - seq/seq_instr.c: snd_seq_cluster_new
        - seq/seq_instr.c: snd_seq_cluster_free
      - move global to static inline functions
        - pcm_lib.c: snd_pcm_playback_ready
        - pcm_lib.c: snd_pcm_capture_ready
        - pcm_lib.c: snd_pcm_playback_empty
        - pcm_lib.c: snd_pcm_capture_empty
        - pcm_lib.c: snd_pcm_playback_data
      - remove the following unused EXPORT_SYMBOL's:
        - snd_create_proc_entry
        - snd_interval_ratden
        - snd_midi_channel_init
        - snd_midi_channel_init_set
        - snd_pcm_playback_empty
        - snd_pcm_capture_empty
        - snd_pcm_playback_data
        - snd_pcm_capture_poll
        - snd_pcm_playback_ready
        - snd_pcm_capture_ready
        - snd_pcm_format_size
        - snd_pcm_open
        - snd_pcm_playback_poll
        - snd_pcm_playback_ready
        - snd_pcm_release
        - snd_pcm_subformat_name
        - snd_remove_proc_entry
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Fix ioctl arguments
      Fixed the wrong pointer types passed to get_user() for
      DROP and DRAIN ioctls.
  + Timer Midlevel
    - Summary: Clean up of kfree()/vfree() NULL checks
      I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
      constructions. I'm going to to this for most of the kernel if I found
      some time.
      Signed-off-by: Marcel Sebek <sebek64@post.cz>
  + /kbuild/Makefile
    - Summary: build without kbuild subdirectory
      The driver is built without kbuilt subdirectory by checking $(KERNELRELEASE)
      in the toplevel Makefile.
  + AC97 Codec
    - Summary: add Line/Headphone jack detection for AD1981A/B
      Line/Headphone Jack Sense mixer switches are added to
      AD1981A/B.
      HP sense is activated as default.
    - Summary: AD18xx/19xx resume fix
      Added resume callback so that the codec-specific resume code can be
      called properly.  Moved AD-specific initialization code into it.
    - Summary: Disable "IEC958 Input Monitor" switch for ALC codecs
      "IEC958 Input Monitor" switch for ALC codecs produces only the
      cracky noises, and KDE seems to turn this on as default in the
      initialization.
      So, better to remove this switch.
    - Summary: Fix compilation without CONFIG_PM
      Fixed the compilation without CONFIG_PM.
      The resume callback is built only with CONFIG_PM.
    - Summary: Fix detection of Xbox
      Unfortunately, on newer xboxes, the chip reports less info than
      before, making another change necessary - this change is backwards
      compatible, and doesn't break earlier xboxes, of course.
      The patch is originally from Ed Hucek <hostmaster@ed-soft.at>.
      Signed-off-by: David Pye <dmp@davidmpye.dyndns.org>
    - Summary: Fix CMI9739A silent problem
      Fix by Zinx Verituse <zinx@epicsol.org>
      The patch for cmi9739a is added.  The undocumented unmute bits are
      enabled.
    - Summary: Add mute LED quirk
      A new quirk type, AC97_TUNE_MUTE_LED, is added for HP/Compaq laptops.
      With this quirk, the EAPD bit is used to control the mute LED in
      conjunction with the master mute switch.
    - Summary: Unify ac97 control callbacks
      Unified single_* and double_* control callbacks.
    - Summary: Remove spinlock in callbacks
      Removed spinlocks in callback, use sempahore instead since all ac97
      callbacks are supposed to be non-atomic.
    - Summary: Don't probe rates when bus->no_vra is set
      Don't probe rates and set VRA/VRM bits when bus->no_vra is set.
    - Summary: Allow strings for ac97_quirk options
      Since there are many ac97_quirk values, the number is no longer good to
      remember what it really means.  Now ac97_quirk option becomes as a string
      option, and more undstandable.  For example, you can pass like
      "ac97_quirk=hp_only".  The old number is still kept and parsed for backward
      compatibility.
    - Summary: Clean up and fix stereo mutes
      Clean up the build of controls.  The volume resolution detection is
      unified.
      Fixed minor bugs to handle stereo mutes.
    - Summary: Fix C-Media codecs
      Don't create PCM (and Master for CM9739/9761) volume controls for some of
      C-Media codecs.  The volume is supposed to be controlled via softvol plugin.
      The wrong (duble) entry for a CM9761 model is removed, too.
    - Summary: Add codec id in component names
      Added codec id number to the component names.
      The component becomes like "AC97a:12345678".
    - Summary: Fix Oops at resume
      Fixed Oops at resume on certain codecs.
      Set null ops when no patch exists or the patch doesn't set build_ops.
    - Summary: Adapt SPDIF Input selection for Realtek ALC658
      This fixes the SPDIF Input selection for ALC658 as Realtek has
      changed the meaning betweenALC655 and ALC658.
      Signed-off-by: Stefan Macher <Stefan.Macher@web.de>
    - Summary: Remove & from function pointers
      Remove & from function pointers (it works but not common to add it...)
    - Summary: Add suspend callback
      Add suspend callback for each codec patch.
  + AD1848 driver
    - Summary: ALSA ISA drivers: misc cleanups
      The patch below makes cleanups under sound/isa/ including:
      - make needlessly global code static
      - ad1816a/ad1816a_lib.c: much code was unused starting with the
                               global function snd_ad1816a_timer
      - removed EXPORT_SYMBOL's:
        - cs423x/cs4231_lib.c: snd_cs4231_outm
        - es1688/es1688_lib.c: snd_es1688_mixer_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + AK4117 receiver
    - Summary: Add CODEC and BUS device types
      Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
      components.
  + AK4531 codec
    - Summary: Remove spinlock in callbacks
      Removed spinlocks in callback, use sempahore instead since all ac97
      callbacks are supposed to be non-atomic.
  + ALS100 driver
    - Summary: alternate ALS0200 ident string
      The patch adds an alternate ALS0200 ident string
      Signed-off-by: Pang Lih Wuei <basic@mozdev.org>
  + ALS4000 driver
    - Summary: Add pci_disable_device() to removal and error paths
      pci_disable_device() is called properly in the removal and error
      paths.  Also, the pci_set_master() is added to the resume callbacks if
      missing (just to be sure).
  + ALSA Version
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - release: 1.0.8rc2
    - release: 1.0.8
  + ALSA sequencer
    - Summary: fix MIDI GS chorus/reverb mode
      Fixed the parsing of MIDI GS chorus/reverb mode SYSEX messages.
      They were swapped.
    - Summary: Fix targets for GUS and OPL4
      The the obj targets for GUS and OPL4 are fixed.
  + ALSA<-OSS emulation
    - Summary: Clean up codes
      Got rid of the unused float codes (the legacy code for sharing with ALSA
      library).
      Add assert to the invalid conversion indices which results in oops
      (just to be sure).
  + ALSA<-OSS sequencer
    - Summary: delete unused file
      Remove nowhere referenced file. (egrep "filename\." didn't find anything)
      Signed-off-by: Domen Puncer <domen@coderock.org>
  + ATIIXP driver
    - Summary: Add pci_disable_device() to removal and error paths
      pci_disable_device() is called properly in the removal and error
      paths.  Also, the pci_set_master() is added to the resume callbacks if
      missing (just to be sure).
    - Summary: Remove unnecessary ac97 spinlocks
      Removed unnecessary spinlocks in ac97 callbacks.
    - Summary: Fix DMA pointer read
      Try to reread DMA pointer register if the value is invalid.
      The register shows bogus values on some broken hardwares.
    - Summary: Add ac97_quirk option
      Added ac97_quirk option like intel and via drivers.
  + ATIIXP-modem driver
    - Summary: Add pci_disable_device() to removal and error paths
      pci_disable_device() is called properly in the removal and error
      paths.  Also, the pci_set_master() is added to the resume callbacks if
      missing (just to be sure).
    - Summary: Remove unnecessary ac97 spinlocks
      Removed unnecessary spinlocks in ac97 callbacks.
  + AZT3328 driver
    - Summary: Add pci_disable_device() to removal and error paths
      pci_disable_device() is called properly in the removal and error
      paths.  Also, the pci_set_master() is added to the resume callbacks if
      missing (just to be sure).
    - Summary: ALSA PCI drivers: misc cleanups
      The patch below does the following cleanups under sound/pci/ :
      - make some needlessly global code static
      - remove the following unused EXPORT_SYMBOL's:
        - trident/trident_main.c: snd_trident_clear_voices
        - trident/trident_main.c: snd_trident_synth_bzero
      - remove the following unused global functions:
        - azt3328.c: snd_azf3328_mixer_read
        - emu10k1/io.c: snd_emu10k1_sum_vol_attn
        - trident/trident_main.c: snd_trident_detach_synthesizer
        - trident/trident_memory.c: snd_trident_synth_bzero
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Fix compile warning (make inline)
      Fixed compile warning when built without joystick support.
      (Optimized via inline.)
    - Summary: Fix the order of creation of instances
      Make sure that the chip instance is created at first before other components.
      This will fix occasional oops at unloading due to the access to the released
      resources.
  + CA0106 driver
    - Summary: Add snd-ca0106 driver
      Added snd-ca0106 driver for SB Audigy LS / Live 24bit boards
      by James Courtier-Dutton <James@superbug.demon.co.uk>.
    - Summary: Add a new ID
      I attach a minor update that corrects the DMA mask, and adds an extra
      ID. This sound card can handle 32bit DMA addresses.
      Signed-off-by: James Courtier-Dutton  <James@superbug.demon.co.uk>
    - Summary: Don't probe sample rates on non-VRA chips
      Don't probe sample rates on chips which need no VRA.
    - Summary: remove compatibility code for 2.2.x kernels
  + CMIPCI driver
    - 2.6 kernel sync
    - Summary: Fix the order of creation of instances
      Make sure that the chip instance is created at first before other components.
      This will fix occasional oops at unloading due to the access to the released
      resources.
  + CS4231 driver
    - Summary: ALSA ISA drivers: misc cleanups
      The patch below makes cleanups under sound/isa/ including:
      - make needlessly global code static
      - ad1816a/ad1816a_lib.c: much code was unused starting with the
                               global function snd_ad1816a_timer
      - removed EXPORT_SYMBOL's:
        - cs423x/cs4231_lib.c: snd_cs4231_outm
        - es1688/es1688_lib.c: snd_es1688_mixer_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: ifdef typos: sound_isa_cs423x_cs4231_lib.c
      Funny typo.
      Signed-off-by: Domen Puncer <domen@coderock.org>
      Acked-by: Randy Dunlap <rddunlap@osdl.org>
      Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
  + CS4236+ driver
    - Summary: alternate CS4235 ident string
      The patch adds an alternate CS4235 ident string
      Signed-off-by: Pang Lih Wuei <basic@mozdev.org>
  + CS4281 driver
    - Summary: Fix the order of creation of instances
      Make sure that the chip instance is created at first before other components.
      This will fix occasional oops at unloading due to the access to the released
      resources.
  + CS46xx driver
    - Summary: [trivial] Fix compile warnings
      Fix trivial compile warnings.
    - Summary: Add 'Duplicate Front' control
      A new mixer control 'Duplicate Front' is added for the board with
      a single codec.  This toggles the duplication of front signal to
      the rear speakers.
    - Summary: Use msleep() in ac97 callbacks
      Use msleep() instead of mdelay() in ac97 callbacks (spinlock was removed).
  + Common EMU synth
    - Summary: misc cleanups
      The patch below contains the following changes in ALSA code not touched
      by my previous patches:
      - make some needlessly global code static
      - remove the following unused global functions:
        - sound/i2c/cs84: snd_cs8427_detect
        - sound/synth/emux/emux_synth.c: snd_emux_release_voice
        - sound/synth/emux/soundfont.: snd_soundfont_mem_used
      - remove the following unused EXPORT_SYMBOL's:
        - sound/i2c/cs8427.c: snd_cs8427_detect
        - sound/i2c/cs8427.c: snd_cs8427_reg_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + Digigram VX core
    - Summary: misc cleanups
      The patch below contains the following changes in ALSA code not touched
      by my previous patches:
      - make some needlessly global code static
      - remove the following unused global functions:
        - sound/i2c/cs84: snd_cs8427_detect
        - sound/synth/emux/emux_synth.c: snd_emux_release_voice
        - sound/synth/emux/soundfont.: snd_soundfont_mem_used
      - remove the following unused EXPORT_SYMBOL's:
        - sound/i2c/cs8427.c: snd_cs8427_detect
        - sound/i2c/cs8427.c: snd_cs8427_reg_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Fix memory corruption
      Fixed the memory corruption by the wrong sized kmalloc.
    - Summary: Hotplug firmware loader support
      The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
      drivers.  The old ALSA fw loader is still supported for built-in kernels.
      To use the hotplug, the new firmware data must be installed beforehand
      from the latest alsa-tools package.
      The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
      too.
    - Summary: Hotplug firmware loader support
      The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
      drivers.  The old ALSA fw loader is still supported for built-in kernels.
      The hotplug fw is disabled on 2.2/2.4 kernels (although the recent 2.4
      could support it).
      To use the hotplug, the new firmware data must be installed beforehand
      from the latest alsa-tools package.
      The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
      too.
    - Summary: Fix compilation errors
      Fix compilation errors when built without hotplug fw loader.
  + Digigram VX222 driver
    - Summary: Hotplug firmware loader support
      The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
      drivers.  The old ALSA fw loader is still supported for built-in kernels.
      To use the hotplug, the new firmware data must be installed beforehand
      from the latest alsa-tools package.
      The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
      too.
  + Documentation
    - Summary: Addition of pci_disable_device() and cleanup
      Added pci_disable_device() in the removal and error paths.
      Replaced with C-style comments in many places.
    - Summary: Added VIA82xx-modem driver
      Added the VIA82xx AC97 modem driver by Sasha Khapyorsky <sashak@smlink.com>.
    - Summary: Clean up power-management
      Clean up for PM code.
      snd_power_change() is called in the common routines instead of driver's callback.
    - Summary: More rewrite of azx and hda-codec drivers
      - added experimental suspend/resume code
      - added missing sysfs registration in azx
      - split the local helper stuff to hda_local.h from the generic hda_codec.h
      - added multi-channel PCM out helper functions
      - added digital input support on ALC880 and CMI9880
    - Summary: Add description about hotplug fw loader
      New descriptions about hotplug fw loader for vx and mixart drivers.
    - Summary: Add emu10k1x driver
      Added the new driver, snd-emu10k1x, for SB Live Dell OEM version
      by Francisco Moraes <fmoraes@nc.rr.com>.
    - Summary: Add snd-ca0106 driver
      Added snd-ca0106 driver for SB Audigy LS / Live 24bit boards
      by James Courtier-Dutton <James@superbug.demon.co.uk>.
    - Summary: Update documentation for hotplug fw loader
      Updated descriptions about the firmware loading for the recent support of
      hotplug firmware loader.
    - Summary: Description about snd_card_set_dev()
      Added the description about snd_card_set_dev().
      Misc cleanup.
    - Summary: Fix description of ALSA/OSS device mapping
      Fixed the description of ALSA/OSS device mapping.  The direction
      suffix was missing in ALSA devices.
    - Summary: Fixed description about ac97_quirk
      Fixed the description about ac97_quirk option.
      Now it accepts string, too.
    - Summary: Add ac97_quirk option
      Added ac97_quirk option like intel and via drivers.
  + EMU10K1/EMU10K2 driver
    - Summary: minor send routing cleanup
      Use snd_emu10k1_compose_audigy_fxrt* macro where appropriate.  Also add
      a few comments to explain send routing structure.
      Signed-off-by: Lee Revell <rlrevell@joe-job.com>
    - Summary: whitespace cleanup
      Signed-off-by: Lee Revell <rlrevell@joe-job.com>
    - Summary: fix display of send routing in /proc
      The emu10k1's send routing is a per channel setting.  The emu10k1 has 4
      sends per channel, the Audigy 8.  Currently we only display the first 4
      sends for the first channel.  This patch updates the /proc file to
      display the send routing for all 64 channels, and to display the last 4
      sends if present.
      Signed-off-by: Lee Revell <rlrevell@joe-job.com>
    - Summary: ALSA PCI drivers: misc cleanups
      The patch below does the following cleanups under sound/pci/ :
      - make some needlessly global code static
      - remove the following unused EXPORT_SYMBOL's:
        - trident/trident_main.c: snd_trident_clear_voices
        - trident/trident_main.c: snd_trident_synth_bzero
      - remove the following unused global functions:
        - azt3328.c: snd_azf3328_mixer_read
        - emu10k1/io.c: snd_emu10k1_sum_vol_attn
        - trident/trident_main.c: snd_trident_detach_synthesizer
        - trident/trident_memory.c: snd_trident_synth_bzero
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Fixes the "It disables the right channel" bug
      Signed-off-by: James Courtier-Dutton
    - Summary: Support for Audigy2 Value SB0400
      This adds support for the SB0400 version of the Audigy2 Value, that uses
      the new CA0108 chip.
      Signed-off-by: James Courtier-Dutton
    - Summary: add register dump to proc
      The register dump proc files are added.
      Enabled only when CONFIG_SND_DEBUG=y.
      Signed-off-by: James Courtier-Dutton
    - Summary: Fixed problem with changing size of etram
      It doesn't work to double the etram size, because of a bad comparison
      statement.
      Signed-off-by: Mikael Magnusson <mikma@users.sourceforge.net>
    - Summary: Fix the detection of Audigy2 ZS
      Fix the detection of the older model of Audigy2 ZS.
    - Summary: Add emu10k1x driver
      Added the new driver, snd-emu10k1x, for SB Live Dell OEM version
      by Francisco Moraes <fmoraes@nc.rr.com>.
    - Summary: Code clean up
      Small code clean up.  Use snd_pcm_lib_preallocage_pages_for_all()
      for buffer allocation.
    - Summary: Fix compile warning
      Removed an unused variable to fix a compile warning.
    - Summary: Don't probe sample rates on non-VRA chips
      Don't probe sample rates on chips which need no VRA.
    - Summary: Print values at errors
      Print out the invalid values at resource allocation errors, too.
  + EMU8000 driver
    - Summary: fix chorus/reverb FX loader
      Fixed the chorus/reverb FX loader callback.
      The header bytes must be eliminated.
  + ENS1370/1+ driver
    - Trivial patch to enable rear out selection for ens1373 on
      the Gigabyte GA-8IEXP motherboard.
      Signed-off-by: Andrew Dennison <andrew-lists@optusnet.com.au>
    - Summary: Remove unnecessary ac97 spinlocks
      Removed unnecessary spinlocks in ac97 callbacks.
    - Summary: Fix the order of creation of instances
      Make sure that the chip instance is created at first before other components.
      This will fix occasional oops at unloading due to the access to the released
      resources.
  + ES1688 driver
    - Summary: ALSA ISA drivers: misc cleanups
      The patch below makes cleanups under sound/isa/ including:
      - make needlessly global code static
      - ad1816a/ad1816a_lib.c: much code was unused starting with the
                               global function snd_ad1816a_timer
      - removed EXPORT_SYMBOL's:
        - cs423x/cs4231_lib.c: snd_cs4231_outm
        - es1688/es1688_lib.c: snd_es1688_mixer_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + ES18xx driver
    - Summary: ifdef typos: sound_isa_es18xx.c
      Changed CONFIG_PNP_ to CONFIG_PNP, also fixed a comment related to
      another CONFIG_PNP.
      Signed-off-by: Domen Puncer <domen@coderock.org>
  + ES1938 driver
    - Summary: Fix interrupt generation on MIDI input for es1938 sound cards
      The patch ensures that a es1938 based sound card generates interrupts on
      incoming MIDI events. I tested the patch successfully on an ess Solo-1 in
      a AlphaPC UX/164.
      Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
  + ES1968 driver
    - Summary: Fix sleep in h/w volume control
      Fixed sleeps in h/w volume control tasklet.
      Also, msleep()s in ac97 accessor callbacks are removed since the chip
      works without such delays.
    - Summary: Don't probe sample rates on non-VRA chips
      Don't probe sample rates on chips which need no VRA.
  + FM801 driver
    - Summary: Fix spinlocks
      Fixed the possible deadlock with no irq spinlock.
      Also, spin_lock_irqsave() is replaced with spin_lock_irq() in some places.
  + GUS Library
    - Summary: ALSA ISA drivers: misc cleanups
      The patch below makes cleanups under sound/isa/ including:
      - make needlessly global code static
      - ad1816a/ad1816a_lib.c: much code was unused starting with the
                               global function snd_ad1816a_timer
      - removed EXPORT_SYMBOL's:
        - cs423x/cs4231_lib.c: snd_cs4231_outm
        - es1688/es1688_lib.c: snd_es1688_mixer_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + Generic drivers
    - Summary: compile fix for 2.6.10
      Fix write callback for 2.6.10 kernel.
  + HDSPM driver
    - Summary: Change the peak meter ioctl to use indirect access
      The RMS peak meter ioctl is changed to use the indirect access since
      the struct size (8192 bytes) overflows the possible bits of ioctl
      on some architectures.
  + I2C cs8427
    - Summary: misc cleanups
      The patch below contains the following changes in ALSA code not touched
      by my previous patches:
      - make some needlessly global code static
      - remove the following unused global functions:
        - sound/i2c/cs84: snd_cs8427_detect
        - sound/synth/emux/emux_synth.c: snd_emux_release_voice
        - sound/synth/emux/soundfont.: snd_soundfont_mem_used
      - remove the following unused EXPORT_SYMBOL's:
        - sound/i2c/cs8427.c: snd_cs8427_detect
        - sound/i2c/cs8427.c: snd_cs8427_reg_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + I2C lib core
    - Summary: Add CODEC and BUS device types
      Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
      components.
  + ICE1712 driver
    - Summary: Fix WM8770 Init
      Corrects WM8770 ADC mux initialization
      Signed-off-by: Peter Christensen <peter@developers.dk>
    - Summary: IEC958 Capture mixer controls and Universe support
       * Added SPI read routine
       * Added IEC958 Capture mixer controls
       * Improved Universe support
       * Headphone Amp renamed to External Amplifier
       * Fixed GPIO bug in Prodigy code (There is no GPIO23 on ICE1724)
      Signed-off-by: Peter Christensen <peter@developers.dk>
    - Summary: Midiman Delta DIO2496 has two stereo analog outs
  + ICE1724 driver
    - Summary: IEC958 Capture mixer controls and Universe support
       * Added SPI read routine
       * Added IEC958 Capture mixer controls
       * Improved Universe support
       * Headphone Amp renamed to External Amplifier
       * Fixed GPIO bug in Prodigy code (There is no GPIO23 on ICE1724)
      Signed-off-by: Peter Christensen <peter@developers.dk>
  + IOCTL32 emulation
    - Summary: Fix ioctl32 wrapper (for SPARC)
      Fix ioctl32 wrapper design, using compat_alloc_user_space() now.
      This will fix the crash on SPARC64.
    - Summary: Fix ioctl32 wrapper (for SPARC)
      Fix ioctl32 wrapper design, using compat_alloc_user_space() now.
      This will fix the crash on SPARC64.
      For 2.4 kernels, the old codes are renamed to *_old.[ch].
    - Summary: Clean up of kfree()/vfree() NULL checks
      I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
      constructions. I'm going to to this for most of the kernel if I found
      some time.
      Signed-off-by: Marcel Sebek <sebek64@post.cz>
    - Summary: Export snd_ctl_elem_read/write() functions
      snd_ctl_elem_read() and snd_ctl_elem_write() functions are exported
      to be accessible from other kernel modules.  They can be used for
      suspend/resume codes, for example.
    - Summary: Fix ctl_read/write ioctl wrappers
      Fixed bugs with ctl_read/write ioctls.
      The struct size mismatch due to alignment is fixed.
      The code is also a bit optimized.
  + Intel8x0 driver
    - Summary: 2.6 sync - bitfield signedness fix
      Signed-off-by: Linus Torvalds <torvalds@osdl.org>
    - Summary: AC97 quirks for Dell
      Added ac97 quirks for some dell machines.
    - Summary: fix sleep in atomic during prepare callback
      Fixed the sleep in spinlock during prepare callback.
      This happened only on Nforce chips.
    - Summary: misc clean up
      Clean up the module init code after removal of midi/joystick support.
    - Summary: Fix non-symmetrical page_attr changes
      Fixed non-symmetrical calls of change_page_attr() which may cause BUG().
      This bug happens only on 440MX.
    - Summary: [trivial] Fix compile warning
      Fix compile warning abount unused variables.
    - Summary: Add mute LED quirk
      A new quirk type, AC97_TUNE_MUTE_LED, is added for HP/Compaq laptops.
      With this quirk, the EAPD bit is used to control the mute LED in
      conjunction with the master mute switch.
    - Summary: Remove unnecessary ac97 spinlocks
      Removed unnecessary spinlocks in ac97 callbacks.
    - Summary: Allow strings for ac97_quirk options
      Since there are many ac97_quirk values, the number is no longer good to
      remember what it really means.  Now ac97_quirk option becomes as a string
      option, and more undstandable.  For example, you can pass like
      "ac97_quirk=hp_only".  The old number is still kept and parsed for backward
      compatibility.
    - Summary: ac97 quirk entries for HP xw6200 & xw8000
      Add AC97 quick list entries to snd-intel8x0 for HP xw6200 and xw8000.
      Signed-off-by: John W. Linville <linville@tuxdriver.com>
    - Summary: Add quirk for HP zv5000
      Added the quirk for HP zv5000 (mute LED with EAPD).
  + L3 drivers
    - Summary: Add CODEC and BUS device types
      Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
      components.
  + MIXART driver
    - Summary: [trivial] Fix compile warnings
      Fix trivial compile warnings.
    - Summary: Hotplug firmware loader support
      The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
      drivers.  The old ALSA fw loader is still supported for built-in kernels.
      To use the hotplug, the new firmware data must be installed beforehand
      from the latest alsa-tools package.
      The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
      too.
    - Summary: Fix compilation errors
      Fix compilation errors when built without hotplug fw loader.
    - Summary: Fix NULL pointer access
      Fixed NULL pointer access when id string isn't given.
    - Summary: Fix float format support
      Fixed typos in float format support.
      Signed-off-by: Markus Bollinger<bollinger@digigram.com>
  + Memalloc module
    - Summary: fix the test of dma_mask
      Fixed the wrong test of dma_mask.
    - Summary: Clean up of kfree()/vfree() NULL checks
      I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
      constructions. I'm going to to this for most of the kernel if I found
      some time.
      Signed-off-by: Marcel Sebek <sebek64@post.cz>
    - Summary: Fix SBUS-only memory allocation on older kernels
      Fixed the memory allocation on the system without PCI but SBUS only
      on 2.2/2.4 kernels.
  + NM256 driver
    - Summary: Use msleep() in ac97 callbacks
      Use msleep() instead of mdelay() in ac97 callbacks (spinlock was removed).
  + OPL3
    - Summary: opl4 depends on opl3
      Compiling OPL4 doesn't include the snd-opl3-lib. This change in the
      Makefile enables now the compiling of snd-opl3-lib.o for OPL4 soundcards.
      Signed-off-by: Martin Langer <martin-langer@gmx.de>
    - Summary: misc cleanups
      The patch below contains the following changes in ALSA code not touched
      by my previous patches:
      - make some needlessly global code static
      - remove the following unused global functions:
        - sound/i2c/cs84: snd_cs8427_detect
        - sound/synth/emux/emux_synth.c: snd_emux_release_voice
        - sound/synth/emux/soundfont.: snd_soundfont_mem_used
      - remove the following unused EXPORT_SYMBOL's:
        - sound/i2c/cs8427.c: snd_cs8427_detect
        - sound/i2c/cs8427.c: snd_cs8427_reg_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Add CODEC and BUS device types
      Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
      components.
  + OPL4
    - Summary: Add CODEC and BUS device types
      Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
      components.
  + PCI drivers
    - Summary: Added VIA82xx-modem driver
      Added the VIA82xx AC97 modem driver by Sasha Khapyorsky <sashak@smlink.com>.
    - Summary: Add emu10k1x driver
      Added the new driver, snd-emu10k1x, for SB Live Dell OEM version
      by Francisco Moraes <fmoraes@nc.rr.com>.
    - Summary: Add snd-ca0106 driver
      Added snd-ca0106 driver for SB Audigy LS / Live 24bit boards
      by James Courtier-Dutton <James@superbug.demon.co.uk>.
  + PDAudioCF driver
    - Summary: make some code static
      The patch below makes some needlessly global code static.
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + PPC DACA driver
    - Summary: sync with 2.6 mainstream
      snd_pmac_keywest_write_*() macros are removed to use kernel i2c
      layer directly (so that the i2c code can be searched more easily).
      __iomem prefix is added to the proper pointers.
  + PPC PMAC driver
    - Summary: sync with 2.6 mainstream
      snd_pmac_keywest_write_*() macros are removed to use kernel i2c
      layer directly (so that the i2c code can be searched more easily).
      __iomem prefix is added to the proper pointers.
    - Summary: buffersize and constraints on pmac
      Buffersize is a bit small compared to the OSS driver (dmasound.h says
      128kb is limit for Amiga, for pmac 256kb is used)
      At least on Snapper, some samplerates cause choppy sound when
      periods<3 or buffersize is not a multiple of periodsize.
      Signed-off-by: Danny Tholen <obiwan@mailmij.org>
    - Summary: Fix the invalid DMA pointer value
      Fixed the bug returning invalid DMA pointer values.
  + PPC Tumbler driver
    - Summary: sync with 2.6 mainstream
      snd_pmac_keywest_write_*() macros are removed to use kernel i2c
      layer directly (so that the i2c code can be searched more easily).
      __iomem prefix is added to the proper pointers.
  + RME HDSP driver
    - Summary: Fix the missing line in the patch for hdsp accurate_ptr
      Fixed missing line in the patch for hdsp accurate_ptr.
    - Summary: Fix invalid "AutoSync Reference" value
      The value returned by controllers for control number 14 ("AutoSync
      Reference") is incorrect and different from that reported by doing
      a cat /proc/asound/card0/hdsp.
      The value reported is not "AutoSync Reference" but "Preferred Sync
      Reference" instead.
      Signed-off-by: Remy Bruno <remy.bruno@trinnov.com>
    - Summary: Add hotplug firmware loader support
      Added the hotplug firmware loader support without hdsploader.
      The firmware data must be installed beforehand in the proper place from
      the latest alsa-firmware package.
  + RME32 driver
    - Summary: Fix the interface type of mixer controls
      The patch will change SNDRV_CTL_ELEM_IFACE_PCM to
      SNDRV_CTL_ELEM_IFACE_MIXER for some mixer elements of rme32.
      Signed-off-by: Martin Langer <martin-langer@gmx.de>
  + RME96 driver
    - Summary: Fix interface type for some mixer controls
      The interface type of some basic mixer controls is changed from
      IFACE_PCM to IFACE_MIXER so that it can be accessed from mixer apps.
      Signed-off-by: Peter Chrisensen <peter@developers.dk>
  + SA11xx UDA1341 driver
    - Summary: Clean up power-management
      Clean up for PM code.
      snd_power_change() is called in the common routines instead of driver's callback.
  + SB drivers
    - Summary: ALSA ISA drivers: misc cleanups
      The patch below makes cleanups under sound/isa/ including:
      - make needlessly global code static
      - ad1816a/ad1816a_lib.c: much code was unused starting with the
                               global function snd_ad1816a_timer
      - removed EXPORT_SYMBOL's:
        - cs423x/cs4231_lib.c: snd_cs4231_outm
        - es1688/es1688_lib.c: snd_es1688_mixer_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + SPARC cs4231 driver
    - Summary: [trivial] Fix compilation warnings on 64bit
      Fixed the compilation warnings about the pointer size.
    - 2.6 kernel sync
  + Sound Scape driver
    - Summary: check __copy_to_user in sscape_upload_bootblock()
      __copy_to_user() is called without checking its return value in
      sound/isa/sscape.c::sscape_upload_bootblock .
      Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
    - Summary: Update user-space access from sscape driver
      I see that the copy_to/from_user() functions have been updated across
      Linux 2.4 and 2.6, and that verify_read/write() has been replaced by
       access_ok(). I have patched the SoundScape driver accordingly.
      Signed-off-by: Chris Rankin <rankincj@yahoo.com>
  + SoundFont
    - Summary: misc cleanups
      The patch below contains the following changes in ALSA code not touched
      by my previous patches:
      - make some needlessly global code static
      - remove the following unused global functions:
        - sound/i2c/cs84: snd_cs8427_detect
        - sound/synth/emux/emux_synth.c: snd_emux_release_voice
        - sound/synth/emux/soundfont.: snd_soundfont_mem_used
      - remove the following unused EXPORT_SYMBOL's:
        - sound/i2c/cs8427.c: snd_cs8427_detect
        - sound/i2c/cs8427.c: snd_cs8427_reg_read
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + Synth
    - Summary: delete unused file
      Remove nowhere referenced file. (egrep "filename\." didn't find anything)
      Signed-off-by: Domen Puncer <domen@coderock.org>
  + Trident driver
    - Summary: ALSA PCI drivers: misc cleanups
      The patch below does the following cleanups under sound/pci/ :
      - make some needlessly global code static
      - remove the following unused EXPORT_SYMBOL's:
        - trident/trident_main.c: snd_trident_clear_voices
        - trident/trident_main.c: snd_trident_synth_bzero
      - remove the following unused global functions:
        - azt3328.c: snd_azf3328_mixer_read
        - emu10k1/io.c: snd_emu10k1_sum_vol_attn
        - trident/trident_main.c: snd_trident_detach_synthesizer
        - trident/trident_memory.c: snd_trident_synth_bzero
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
  + USB
    - Summary: hwdep interface for pcm data
      Implements "rawusb" pcm data transfer through hwdep interface:
      The usb_hc moves pcm data from/into memory via DMA.
      That memory is mmaped by jack's usx2y driver.
      Jack's usx2y driver is the first/last executable code to read/write pcm data.
      Read/write is a combination of power of 2 period shaping and float/int
      conversation.
      Compared to standard alsa/jack we leave out power of 2 period shaping
      inside snd-usb-usx2y which needs memcpy() and additional buffers.
      As a side effect possible unwanted pcm-data coruption resulting of
      standard alsa's snd-usb-usx2y period shaping scheme falls away.
      Result is sane jack operation at buffering schemes down to 128frames,
      2 periods.
      Also changed Kconfig file, so snd-usb-usx2y is only available for X86,
      PPC or ALPHA platforms, as on others DMA-memory isn't mmapable.
      Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
  + USB USX2Y
    - Summary: Use macro usb_maxpacket() for portability
      In future kernels struct usb_device won't have the epmaxpacketin/out members.
      Use macro usb_maxpacket() instead of directly accessing those members.
      Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
    - Summary: hwdep interface for pcm data
      Implements "rawusb" pcm data transfer through hwdep interface:
      The usb_hc moves pcm data from/into memory via DMA.
      That memory is mmaped by jack's usx2y driver.
      Jack's usx2y driver is the first/last executable code to read/write pcm data.
      Read/write is a combination of power of 2 period shaping and float/int
      conversation.
      Compared to standard alsa/jack we leave out power of 2 period shaping
      inside snd-usb-usx2y which needs memcpy() and additional buffers.
      As a side effect possible unwanted pcm-data coruption resulting of
      standard alsa's snd-usb-usx2y period shaping scheme falls away.
      Result is sane jack operation at buffering schemes down to 128frames,
      2 periods.
      Also changed Kconfig file, so snd-usb-usx2y is only available for X86,
      PPC or ALPHA platforms, as on others DMA-memory isn't mmapable.
      Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
    - Summary: Add missing source codes in the last hwdep-pcm patch.
      The missing source files in the last hwdep-pcm patch are added.
      Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
    - Summary: Fix open handling
      Return -EBUSY from snd_usX2Y_usbpcm_open(), if the associated hwdep
      device is not opened.
      It now works as originally intended. Had forgotten a pair of parenthesis.
      Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
    - Summary: Remove superfluous code
      Removed the superfluous creation/deletion of lowlevel component.
      It's not used at all.
  + USB generic driver
    - Summary: Return -EBADFD when the device is disconnected
      The trigger callback returns -EBADFD when the device is disconnected.
  + VIA82xx driver
    - Summary: via82xx: Enable DXS on ABIT KV8 Pro
      From Marko Kreen <marko@l-t.ee>:
      Enable DXS for via audio chip on ABIT KV8 Pro.
      Works for me.
    - Summary: sort DXS whitelist
      DXS whitelist entries are sorted.
    - Summary: disable legacy IRQs before request_irq() to avoid unhandled interrupts
      Signed-off-by: Christian Koerner <ckoerner@sysgo.com>
    - Summary: Allow strings for ac97_quirk options
      Since there are many ac97_quirk values, the number is no longer good to
      remember what it really means.  Now ac97_quirk option becomes as a string
      option, and more undstandable.  For example, you can pass like
      "ac97_quirk=hp_only".  The old number is still kept and parsed for backward
      compatibility.
    - Summary: Add a DXS entry for ABIT VA-20
      Added a DXS whitelist entry for ABIT VA-20.
  + VIA82xx-modem driver
    - Summary: Added VIA82xx-modem driver
      Added the VIA82xx AC97 modem driver by Sasha Khapyorsky <sashak@smlink.com>.
  + Wavefront drivers
    - Summary: Fix compile warning
      Fixed compile warning regarding the sign of char.
  + YMFPCI driver
    - Summary: ALSA PCI drivers: misc cleanups
      The patch below does the following cleanups under sound/pci/ :
      - make some needlessly global code static
      - remove the following unused EXPORT_SYMBOL's:
        - trident/trident_main.c: snd_trident_clear_voices
        - trident/trident_main.c: snd_trident_synth_bzero
      - remove the following unused global functions:
        - azt3328.c: snd_azf3328_mixer_read
        - emu10k1/io.c: snd_emu10k1_sum_vol_attn
        - trident/trident_main.c: snd_trident_detach_synthesizer
        - trident/trident_memory.c: snd_trident_synth_bzero
      Signed-off-by: Adrian Bunk <bunk@stusta.de>
    - Summary: Avoid VRA on codec chips
      Avoid VRA setting on ac97 codec chips.  YMFPCI doesn't need VRA.
  + au88x0 driver
    - Summary: Replace long delays with msleep()
      Long udelay()'s are replaced with msleep() as much as possible.
    - Summary: Spinlock removal and loop fix
      Removed unnecessary spinlocks.
      The invalid (typo) loop in the codec read callback is fixed.
    - Summary: Fix spinlock
      Fixed possible spin deadlocks.
* alsa-lib
  + Core
    - Summary: Change error message handling
      Change the handling of non-fatal errors.  Now the non-fatal error
      messages are not shown in stderr and no assert() as default.  The
      behavior can be changed with LIBASOUND_DEBUG environment variable.
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Summary: Add accessor to user control elements
      Added accessor functions to user control elements, snd_ctl_elem_add_*(),
      and_ctl_elem_remove() and snd_ctl_elem_info_is_user().
    - release: 1.0.8rc2
    - Summary: Add inclusion of time.h
      timeval and timespec structs need time.h.
    - release: 1.0.8
  + Control API
    - Summary: Add accessor to user control elements
      Added accessor functions to user control elements, snd_ctl_elem_add_*(),
      and_ctl_elem_remove() and snd_ctl_elem_info_is_user().
  + Instrument API
    - Summary: Fix compilation with 2.6.9 kernel (glibc headers)
      Fix by earl <earl@stanfordalumni.org>:
      Fixed the compilation with glibc headers based on 2.6.9 kernel.
  + Mixer API
    - Summary: Add Front control to weight list
      Added "Front" control to the weight list.
  + PCM API
    - Return correct error in snd_pcm_wait() after snd_pcm_poll_descriptors() call
    - Summary: appl_ptr sync fix when status/control structures are not mmaped
      The prepare and reset ioctls can modify appl_ptr, thus the user space
      must take modified appl_ptr from driver.
    - Summary: fix for capture for case when status/control structures are not mmaped
    - Summary: Fixes variable shadow problem in capture direction
      My gnomemeeting hung when accessing the microphone.
      The problem was that the rate variable was not initialized when jumping to
      the __partial label.
      Signed-off-by: Andreas Fenkart <afenkart@gmx.ch>
    - Fixed few typos in documentation.
      Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
    - Summary: Add preamble value configuration for iec958 plugin
      The preamble values can be defined in iec958 plugin configuration.
      As default, Z/Y/X=8/4/2 is used.  CMI8338 has different values,
      so override in its configuration.
    - Summary: Change error message handling
      Change the handling of non-fatal errors.  Now the non-fatal error
      messages are not shown in stderr and no assert() as default.  The
      behavior can be changed with LIBASOUND_DEBUG environment variable.
    - Summary: fix changed error message handling
      In the last error message handling change, some error conditions
      didn't get properly inverted.
    - Summary: Add softvol PCM plugin
      The softvol PCM plugin is added.  It applies the software volume attenuation,
      which may be useful for codecs without volume controls.
      Currently, the control is only mono.  The attenuation is applied to all
      channels equally.  The control is probed and automatically created
      when not exists yet.
    - Summary: Add accessor to user control elements
      Added accessor functions to user control elements, snd_ctl_elem_add_*(),
      and_ctl_elem_remove() and snd_ctl_elem_info_is_user().
    - Summary: Change the behavior with hardware volume controls
      When a hardware volume control is given, softvol plugin simply
      passes the slave PCM without any additional changes.
    - Summary: Set max volume as default for softvol
      Set max volume as default for softvol.
    - Summary: Fix missing declaration
      Fixed the missing declration of softvol plugin.
    - Summary: Support stereo volume control
      softvol supports stereo volume controls.
      Fixed the dB calculation, too.
    - Summary: Performance optimization
      The performance of rate conversion is optimized.
      - with S16 format, no format conversion is done
      - linear polation of expansion uses 16bit resolution
    - Summary: Clear sw_params struct at initialization
      Do zero-clear the sw_params struct in hw_params, just to be sure.
      This makes valgrind happy.
    - Summary: Fix handling of DISCONNECT state
      Fixed the handling of DISCONNECT state in dmix (not to set bogus error
      values to state).
    - Summary: Fix compile warning
      Fixed compile warning due to signed/unsigned comparison.
  + Configuration
    - Summary: Rename AudigyLS -> CA0106
      Along with the rename of the driver, the config file is renamed to
      CA0106, too.
      Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
    - Summary: Disable 'duplicate front' switch for rear
      The rear PCM needs to disable 'duplicate front' switch.
    - Summary: Add preamble value configuration for iec958 plugin
      The preamble values can be defined in iec958 plugin configuration.
      As default, Z/Y/X=8/4/2 is used.  CMI8338 has different values,
      so override in its configuration.
    - Summary: Add default for refer function
      "@func refer" accepts default configuration.  If the refer to the
      given config fails, the default config is picked up.
    - Summary: Make "default" PCM card-specific
      "default" PCM can be card-specific.
      The definition is moved to pcm/default.conf, and read on-demmand via
      aliases.conf.  The card config can override the default config.
    - Summary: Use softvol for PCM outputs
      Use softvol plugin for codecs without PCM volume controls (e.g. c-media).
      The default PCM is redefined to use softvol for playback.
    - Summary: New config for ES1968 and Maestro3
      New config files for ES1968 and Maestro3.
      They have multi-playback capabilities, so the default shouldn't be dmix.
    - Summary: New config for Azalia (intel HD audio) driver
      The new config file for Azalia (snd-azx), Intel HD audio driver.
      For playback, softvol is applied for codecs without volume controls.
    - Summary: Add new config files
      Azalia, ES1968 and Maestro3 configs are added.
  + Documentation
    - Summary: Change error message handling
      Change the handling of non-fatal errors.  Now the non-fatal error
      messages are not shown in stderr and no assert() as default.  The
      behavior can be changed with LIBASOUND_DEBUG environment variable.
    - Summary: Add softvol PCM plugin
      The softvol PCM plugin is added.  It applies the software volume attenuation,
      which may be useful for codecs without volume controls.
      Currently, the control is only mono.  The attenuation is applied to all
      channels equally.  The control is probed and automatically created
      when not exists yet.
  + Error handler
    - Summary: Change error message handling
      Change the handling of non-fatal errors.  Now the non-fatal error
      messages are not shown in stderr and no assert() as default.  The
      behavior can be changed with LIBASOUND_DEBUG environment variable.
  + I/O subsystem
    - Summary: fix miscalculation of buffer size in snd_output_buffer_need()
      snd_output_buffer_need() did not account for the already used part of
      the buffer when trying to allocating new space.
    - Summary: Removed wrong ATTRIBUTE_UNUSED
      Removed a wrong ATTRIBUTE_UNUSED in snd_output_stdio_close().
  + Kernel Headers
    - Sync with the driver (EFX code structure)
* alsa-utils
  + Core
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Summary: i18nize alsaconf
      alsaconf is i18nized.  Only ja.po is provided, so far.
    - Summary: Move m4 to the tail of SUBDIRS
      Moved m4 to the tail of SUBDIRS list.
    - Summary: Require alsa-lib 1.0.8
      Now requires alsa-lib 1.0.8 for the support of user-defined controls.
    - release: 1.0.8rc2
    - release: 1.0.8
  + ALSA Control (alsactl)
    - Summary: Support user-defined controls
      Support store/restore of user-defined controls.
      Also, the numid is no longer checked when -F option is given.
      The element is determined only from the given name, iface, index, device and
      subdevice.
    - Summary: Fix compilation
      Fix compilation: the code was based on the developing version of alsa-lib...
  + Speaker Test
    - Summary: Add man page of speaker-test
      Attached is a speaker-test man page which I believe was submitted to
      Debian by James Courtier-Dutton. Please proof read it before including it.
      Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>
  + alsaconf
    - Summary: Start aplay/arecord in non-blocking mode
      Start aplay/arecord with -N option in non-blocking mode.
    - Summary: i18nize alsaconf
      alsaconf is i18nized.  Only ja.po is provided, so far.
    - Summary: Misc clean up
      Misc clean up: make msgmerge as macro.
    - Summary: Fix installation
      Fix installation: use mkdir -p instead of mkinstalldirs.
    - Summary: Fix installation
      It seems that old autoconf doesn't like @mkdir_p@...
  + alsamixer
    - Summary: Change the view toggle behavior
      Added [F5] key to toggle to "All channels".
      Back from help/proc screen keeps the old channel view mode.
    - Summary: Assign alternative keys for function keys
      Assign number 1-5 keys as alternative keys for the function keys.
      Some terminal programs like gnome-terminal doesn't like that apps
      use function keys.
    - Summary: Reinitialize the size calculation at view change
      The volume bar and space sizes are recalculated at each time when
      the view mode is changed.  This will fix the problem when the view
      with fewer volumes is switched to the view with more volumes.
    - Summary: Add -V option
      Add -V option to specify the default view mode.
    - Summary: More descriptions about mixer views and view modes
      More descriptions about mixer view and view modes are added.
      Corrected some typos.
    - Summary: Usability improvement
      Improved the usability of alsamixer:
      - the mute/unmute appears in a separate box below the volume bar
        more obviously
      - the capture switch appears below the volume bar, too
      - the controls without volume doesn't show volume bars
      - fixed bugs with all view mode
      - fixed the calculation of volume bar size
      - show left/right scrollable status
      - code clean up
    - Summary: fix crashes when selecting an empty view
      alsamixer would crash when a view without controls was selected
    - Summary: Remove number key assignment
      Don't use number keys for alternatives to F1-F5.
      The Tab key can be used to toggle view modes, instead.
    - Summary: Support quick volume change
      Patch provided by nijel, ALSA BTS #785:
      Attached patch adds support for quickly changing volume using 0-9 keys
      in simmilar way as aumix does.
  + aplay/arecord
    - Summary: Fix VU meter
      Fixed VU meter output of 8 and 32bit samples.
* alsa-tools
  + Core
    - Summary: Add pcxhrloader
      Added pcxhrloader, the firmware loader for Digigram PCXHR driver.
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Summary: Add echomixer
      Added echomixer by Giuliano Pochini <pochini@shiny.it>
      Mixer app for echoaudio drivers.
    - release: 1.0.8rc2
    - release: 1.0.8
  + Digigram Echo Mixer
    - Summary: Add echomixer
      Added echomixer by Giuliano Pochini <pochini@shiny.it>
      Mixer app for echoaudio drivers.
    - Summary: echomixer update
      - Big cleanup in the matrix mixer drawing code. It make is way
        smaller and readable.
      - New feature: echomixer can load and restore the status of nominal level
        switches.
      - Version number bumped to 1.0.3.
      Signed-off-by: Giuliano Pochini <pochini@shiny.it>
  + Digigram PCXHR Loader
    - Summary: Add pcxhrloader
      Added pcxhrloader, the firmware loader for Digigram PCXHR driver.
    - Added missing cvscompile script
  + Envy24 Control
    - Summary: envy24control: midi support for mixer
      Hello devlopers,
      I have made the mixer sliders in envy24control react to MIDI
      controllers. This way the hardware mixer can be controlled from a
      sequencer program or some external MIDI controller hardware.
      envy24control became a standard ALSA sequencer client which you can
      connect to arbitrary other MIDI sources/sinks.
      Signed-off-by: Dirk Jagdmann <doj@cubic.org>
    - Summary: Add auto-probing of ice1712 cards
      The ice1712 card is probed automatically when no option is given.
    - Summary: Add missing midi.h
      Added missing midi.h to SOURCES in Makefile.am
    - Summary: Fix the abort with MIDI control
      From Dirk Jagdmann <doj@cubic.org>
      Hello developers,
      I just gave the latest CVS version of envy24control a try and had to add
      this simple patch, so it would not abort upon program start immediately.
    - Summary: Fix for envy24control and midi
      Fix by Dirk Jagdmann <doj@cubic.org>:
      The attached patch fixes a compiler warning, which points to a possible
      bug when initializing the midi controllers.
    - Summary: Fix digital mixer checkboxes
      Fix by Dirk Jagdmann <doj@cubic.org>:
      The digital mixer can routed only to HW1/2 or SPDIF1/2.
      In other channels, the checkbox shouldn't appear.
  + RME Digi Control
    - Summary: Fix interface type of mixer controls
      ALSA BTS #681
      	https://bugtrack.alsa-project.org/alsa-bug/view.php?id=681
      The interface type of mixer controls is changed from IFACE_PCM
      to IFACE_MIXER according to the recent change of rme32/96 drivers.
    - Summary: Fix interface type of mixer controls
      ALSA BTS #681
              https://bugtrack.alsa-project.org/alsa-bug/view.php?id=681
      The interface type of mixer controls is changed from IFACE_PCM
      to IFACE_MIXER according to the recent change of rme32/96 drivers.
* alsa-firmware
  + Core
    - Summary: Hotplug firmware loader support
      New configure options, --disable-hotplug, --disable-loader and
      --with-hotplug-dir.  As default, the firmware files will be installed
      to the paths for both hotplug and ALSA fw loaders.
    - Summary: Add pcxhrloader
      Added pcxhrloader, the firmware loader for Digigram PCXHR driver.
    - release: 1.0.8rc1
    - Summary: Added missing Makefile for pcxhrloader
    - Summary: Add echoaudio firmware files
      Firmware data files for echoaudio drivers are added.
      Installed to the default hotplug path.
    - release: 1.0.8rc2
    - release: 1.0.8
  + Digigram Echo Audio Loader
    - Summary: Add echoaudio firmware files
      Firmware data files for echoaudio drivers are added.
      Installed to the default hotplug path.
    - Summary: Fix typo and fw path
      Fixed the typo in Makefile.am.
      The path of hotplug fw files are changed to the subdirectory ea/*.
  + Digigram MixArt Loader
    - Summary: Hotplug firmware loader support
      New configure options, --disable-hotplug, --disable-loader and
      --with-hotplug-dir.  As default, the firmware files will be installed
      to the paths for both hotplug and ALSA fw loaders.
  + Digigram PCXHR Loader
    - Summary: Add pcxhrloader
      Added pcxhrloader, the firmware loader for Digigram PCXHR driver.
  + Digigram Vx Loader
    - Summary: Hotplug firmware loader support
      New configure options, --disable-hotplug, --disable-loader and
      --with-hotplug-dir.  As default, the firmware files will be installed
      to the paths for both hotplug and ALSA fw loaders.
  + RME HDSP Loader
    - Summary: Hotplug firmware loader support
      Added hotplug firmware loader support.
      This feature is enabled only for 2.6 kernels, so far.
      The older kernels require still hdsploader.
* alsa-oss
  + Core
    - release: 1.0.8-rc1
    - release: 1.0.8rc1
    - Summary: Add so versions
      Specify so versions in configure script for future extension.
    - release: 1.0.8rc2
    - release: 1.0.8
  + Manual Page
    - Summary: Add description of ALSA_OSS_PCM_DEVICE env variable
      Added the description about ALSA_OSS_PCM_DEVICE environment variable.
  + PCM Emulation
    - Summary: Fix periods_max setting
      Fixed the setting of periods_max not to be below periods_min.
    - Summary: Misc improvement for PCM
      - Allow user to pass the PCM name to open via ALSA_OSS_PCM_DEVICE
        environment variable.
      - Always open the device with non-blocking mode, and change the
        mode to the proper one after open.
      - Code clean up.

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
