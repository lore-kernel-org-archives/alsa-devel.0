From: Jaroslav Kysela <perex@suse.cz>
Subject: 1.0.2 release
Date: Tue, 27 Jan 2004 10:51:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
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
Cc: ALSA Announce <alsa-announce@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	we released packages 1.0.2.

ChangeLog:
**********

common
  * added support for new automake
alsa-driver
  * general
    - fixed typo in configure for detecting RedHat kernels
    - added resource allocation failure messages to all drivers
    - fixes in PCI memory allocation routines
    - fixed the build of 2.6 kernel with modversion
    - fixed PCI DMA allocation for most PCI cards
    - added SNDRV_PCM_STATE_DISCONNECTED state
    - more complete sysfs support
    - fixed 2.2 kernel support
    - added the support of stack dump at xrun
    - Change -EINVAL to -EALREADY in snd_pcm_unlink()
  * added intel8x0 modem driver
  * sb16 - fixed PnP problems
  * au88x0 - added pci fixup code
  * ens1371
    - cleanups in s/pdif controls
    - added rear/line-in switch
  * via82xx
    - fixed DXS volume value
    - more quirks
  * intel8x0
    - fixed the 6 channel output on nforce
    - added more quirks
    - added the workaround for a hardware bug in intel 440MX B-stepping
  * cmipci - improved s/pdif status bits initialization
  * emu10k1
    - renamed "Surround Digital" -> "Surround" to avoid ac97 name clashing
  * emusynth
    - added native API (hwdep) for soundfont handling
  * USB audio driver
    - add support for Edirol UM-1SX
    - added quirk for Sound Blaster MP3+
  * MPU401
    - fix names for MPU-401 ports
  * HDSP
    - set the PCI latency timer to 255 for fixing some misbehavior
  * OSS emulation
    - fixed the oops in OSS mixer when the control elements are dynamically changed
    - a next attempt to fix click at the end of stream
alsa-lib
  * general
    - added SNDRV_PCM_STATE_DISCONNECTED state
    - fixed SHM memory leak fix in pcm routines
    - fixed non-version build
    - removed the function-in-function for qsort
    - CMIPCI, ICE1712 - fixed the iec958 capture using asym plugin
  * direct plugins
    - close all file descriptors in server_job()
    - improved compatibility with xine (fixes in poll() implemetation)
    - added slowptr option which improves pointer accuracy
    - dmix optimizations
alsa-utils
  * improved amidi

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
