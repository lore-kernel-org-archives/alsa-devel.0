From: Jaroslav Kysela <perex@suse.cz>
Subject: ALSA 1.0.5
Date: Sat, 29 May 2004 10:27:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405291025420.1781@pnote.perex-int.cz>
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

Hello all,

	ALSA 1.0.5 release is available for download.

				Jaroslav

Changes:

* alsa-driver
  - use the new module_param*() functions
  - clean up of power-management codes
  - removed superfluous warning messages after pci_module_init()
  - fixed the allocation of coherent DMA pages under 32bit mask
  - added early event flag and code to the timer interface
  - added experimental emu10k1x driver
  - added snd-atiixp-modem driver for ATI IXP modem (experimental)
  - sequencer
    - export snd_seq_set_queue_tempo() for OSS to prevent calling
      snd_seq_kernel_client_ctl() (using copy_from_user()) in interrupt
      context
  - PCM midlevel
    - fixed the deadlock of power_lock in suspend
    - fixed the bit width of IEC958_SUBFRAME_* formats from 24 to 32
    - added SYNC_PTR ioctl (for problematic cache coherency archs)
  - PCM OSS
    - don't return negative byte count from GET[IO]PTR ioctl
  - intel8x0
    - 20-bit sample support
    - fixed MX440 workaround in suspend/resume
    - interrupt handling fixes
  - via82xx
    - added dxs_support and ac97_quirk entries for Amira notebook
    - added DXS whitelist for (eMachines) m680x
    - added the DXS entry for ECS K7VTA3 v8.0
    - fixed the DXS entry for ASUS A7V8X to NO_VRA
    - added the DXS entry for Mitac/Vobis/Yakumo laptop
  - atiixp
    - fixed S/PDIF support
    - fixed the codec probing without the proper interrupts
    - added the experimental PM support
  - usx2y
    - US224 support
  - au88x0
    - bugfixes and VIA/AMD chipset automatic workaround
  - ICE1712
    - added Event Electronics EZ8 support
    - added a control for default rate in the ice1712 driver
    - fix Hoontech DSP* box configuration
    - added model module option to specify board model
  - ICE1724
    - added model module option to specify board model
    - added the support of Aureon 7.1-Universe
    - improved the description of ice1724 driver on Kconfig.
    - better support of VT1720 with snd-ice1724 driver.
    - check PCI subsystem IDs when no EEPROM is available (ice1724 only)
    - change the driver name string if given in the board list.
    - merged prodigy 7.1 support into aureon.c.  they are almost identical.
    - allow to use PDMA4 and RMDA1 for non-SPDIF purpose if specified (ice1724 only).
    - avoid to change the AC97 rate registers
  - USB audio
    - Edirol UA-700 advanced modes support
    - Roland UA-1000 support
  - Opti9xx
    - fixed irq&dma initialization for <93x chips
  - opl3sa2
    - added YMH0801 ISA PnP ID - OPL3-SA2
  - emu10k1
    - added support for SB Live 5.1 (c) 2003
  - HDSP
    - HDSP9632 has also firmware version 0x97
  - nm256
    - added a blacklist to avoid the possible hang-up at module loading
  - cmipci
    - dropped the software encoding of AC3 stream in the driver (moved to alsa-lib)
  - AC97 codec
    - detection for S/PDIF rates
    - fix access to wrong register when clearing powerdown bits
    - show AC'97 2.3 information in proc file
    - fix AC'97 revision bits on AD1985
    - added the write support to ac97#x-x+regs proc file (DEBUG)
    - fixed AD18xx PCM bit handling
    - stac9758 initialization fixes
    - STAC9758: stereo mutes, jack configuration
    - added the global mutex for ac97_t (ad18xx mutex is removed).
       used to protect paging and AD18xx multi-codecs.
    - set PAGE_INT register explicitly before accessing (for STAC9758).
    - moved ALC650 revision check to patch_alc650().
    - support stereo Mic playback.
    - moved STAC9708 quirk to patch_stac9708().
    - don't clear PC_BEEP high bits (ac97 2.3 sets frequency there).
    - avoid the unnecessary RESET-waiting for audio/modem codec.
    - fixed the evaluation of modem codec to call mpatch callback properly.
    - determine the SPDIF rate in the build path.
    - added suffix argument to snd_ac97_rename|remove|swap_ctl().
    - added snd_ac97_rename_vol_ctl().
    - Added the single mixer control with AC97 2.3 paging.
    - Handle the paging for some ALC655/658 registers.
    - Added the experimental support for ALC850.
  - VX core
    - added 'Clock Mode' control to choose the clock source
* alsa-lib
  - added snd_asoundlib_version()
  - added a new plugin "iec958" to convert IEC958 subframes
  - added SYNC_PTR ioctl support for pcm_hw plugin
  - dmix plugin - fixed wrong jump for 32-bit mixing
* alsa-utils
   - arecordmidi enhancements by Pedro Lopez-Cabanillas
   - arecord fix (timelimit)
   - added speaker-test utility
* alsa-tools
  - added profile management to envy24control

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
