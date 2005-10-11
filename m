From: Jaroslav Kysela <perex@suse.cz>
Subject: [ALSA] 1.0.10rc2 release
Date: Tue, 11 Oct 2005 16:43:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0510111641430.9618@tm8103.perex-int.cz>
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
To: ALSA development <alsa-devel@alsa-project.org>
Cc: ALSA Announce <alsa-announce@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	1.0.10rc2 ALSA packages are available for download.

						Jaroslav


Changelog between 1.0.10rc1 and 1.0.10rc2 releases
**************************************************

* alsa-driver
  + Sound Core
    - Add check of CONFIG_ISA_DMA_API
    - Merge hpklinux to alsa-driver tree
    - Fix detection of CONFIG_ISA_DMA_API
    - ad1889: add AD1889 driver docs
    - disable HPET driver
    - Add a wrapper for register_sound_special_device()
    - Add pci_ids.h wrapper
    - Added kzalloc() wrapper
    - release 1.0.10rc2
  + ALSA Core
    - Define CONFIG_ISA_DMA_API for older kernels
    - sparse: add __nocast to wrappers
    - Add snd_card_set_generic_dev() call
    - Add a wrapper for register_sound_special_device()
    - Add pci_ids.h wrapper
    - Add wrappers for pci_get_device() and pci_dev_put()
    - Fixed compilation with older 2.6 kernels
    - Added kzalloc() wrapper
    - Replace with kzalloc()
    - Try to fix compiling to work. More problems exist.
    - fix typo that prevented compiling.
    - include new PCI IDs with 2.2.x kernels
    - set owner field in struct pci_driver
    - fix driver_register() on old kernels
    - fix missing return value of dummy snd_card_set_generic_dev()
    - fix warning about CONFIG_ISA_DMA_API redefinition
    - fix compilation on 2.2.x kernels
    - Fix PCI IDs in rme32/96 driver
    - Add getnstimeofday() wrapper.
    - Move kmalloc wrappers to alsa-driver tree
    - Fix compile without CONFIG_SND_DEBUG_MEMORY
  + Generic drivers
    - Add snd_card_set_generic_dev() call
    - Replace with kzalloc()
  + IOCTL32 emulation
    - Replace with kzalloc()
  + MPU401 UART
    - mpu401: fix patch
  + MSND driver
    - sparse address space annotations
    - msnd-pinnacle: remove strange escapes
    - Remove vmalloc wrapper, kfree_nocheck()
  + Memalloc module
    - Move kmalloc wrappers to alsa-driver tree
  + Opti9xx drivers
    - Add snd_card_set_generic_dev() call
* alsa-lib
  + Core
    - moved simple mixer abstraction modules to modules/mixer/simple directory
    - mixer API - extend simple enumerated controls for direction tests
    - Fix type-punning
    - release 1.0.10rc2
  + Mixer API
    - mixer API - extend simple enumerated controls for direction tests
  + Mixer Abstraction API
    - moved simple mixer abstraction modules to modules/mixer/simple directory
    - mixer API - extend simple enumerated controls for direction tests
  + PCM API
    - PCM API - handle EINTR from poll() in snd_pcm_wait() function
    - Fix call of semctl IPC_RMID
    - Workaround for crash with knotify
    - Fix buffer allocation and mmap with plugins
    - Fix compile warnings
    - direct plugins - change group according ipc_gid for the socket file
    - fix segfault then hooks list is empty
    - Don't return error if chown() fails
    - Removed unused function
    - Fix endianess with dmix plugin
    - pcm - Add SOFTVOL pcm type
    - PCM add missing pcm types - DSNOOP, IEC958, IOPLUG, EXTPLUG
    - fixed typo in comment
    - Fix type-punning
    - Fix mmap and channel_info of hook plugin
  + Sequencer API
    - Fix type-punning
  + /Makefile.am
    - moved simple mixer abstraction modules to modules/mixer/simple directory
  + /include/Makefile.am
    - Allow separate build and source trees
  + /modules/Makefile.am
    - moved simple mixer abstraction modules to modules/mixer/simple directory
  + /src/Makefile.am
    - Allow separate build and source trees
  + Configuration
    - Fix configuration for ICE1724
    - dmix and dsnoop configuration - added ipc_perm 0660 (to handle all users with audio group)
    - modem's pcm "two device" config
    - Add modem pcm definition for hda-intel driver
    - emu10k1: Front channels via fxbus 8 and 9
    - Use S16_LE as default for dmix
    - Fix endianess of PMac driver
    -  New @func - pcm_args_by_class
    - use dmix/dsnoop for default PCM on ca0106
  + Kernel Headers
    - Fix type-punning
  + Simple Abstraction Mixer Modules
    - Allow separate build and source trees
  + Test/Example code
    - pcm.c test / example - Added EINTR handling
    - test/pcm.c - remove -EINTR handling (a job for alsa-lib)
* alsa-utils
  + Core
    - release 1.0.10rc2
  + ALSA Control (alsactl)
    - Fix / clean up man pages
    - Extend 'alsactl names' to show modem devices
  + ALSA RawMidi Utility (amidi)
    - Fix / clean up man pages
  + Speaker Test
    - speaker-test: Add support for testing FLOAT_LE format.
  + alsaconf
    - Allow separate build and source trees
    - Fix hwcfg file name by alsaconf
  + alsamixer
    - Fix / clean up man pages
    - Use strsignal()
    - Implement dB gain level display.
  + amixer
    - Fix / clean up man pages
    - Added more better error fault handling for sset toggle
    - Fix for more better error fault handling for sset toggle
  + aplay/arecord
    - aplay - added -EINTR error code handling for read/write operations
    - aplay - remove EINTR handling (a job for alsa-lib)
* alsa-tools
  + Core
    - release 1.0.10rc2
  + Envy24 Control
    - Fix segfault of envy24control
* alsa-oss
  + Core
    - Use $LIB for LD_PRELOAD path in aoss
    - release 1.0.10rc2
  + PCM Emulation
    - Fix suspend/resume with aoss
    - More fix for PM
  + aoss script
    - Use $LIB for LD_PRELOAD path in aoss

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
