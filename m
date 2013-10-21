From: Clemens Ladisch <clemens@ladisch.de>
Subject: [GIT PULL] [00/29] playback-only DICE driver
Date: Mon, 21 Oct 2013 21:19:23 +0200
Message-ID: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 48B9A261A25
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 21:19:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

please pull this driver for FireWire DACs based on the DICE chip
family.  While the driver supports only PCM playback at the
moment, it fills a gap left by FFADO, which supports only full-
duplex devices.

Thanks,
Clemens
----------------------------------------------------------------

The following changes since commit 6e4664525b1db28f8c4e1130957f70a94c19213e:

  Linux 3.11 (2013-09-02 13:46:10 -0700)

are available in the git repository at:

  git://git.alsa-project.org/alsa-kprivate.git dice-driver-playback-only

for you to fetch changes up to b20be8de1b3972ccf9af72850b045214faa8d830:

  ALSA: dice: restrict the driver to playback-only devices (2013-10-20 22:07:57 +0200)

----------------------------------------------------------------
Clemens Ladisch (28):
      ALSA: add DICE driver
      ALSA: dice: optimize bus reset handling
      ALSA: dice: allow all sample rates
      ALSA: dice: reduce noisy logging
      ALSA: dice, firewire-lib: add blocking mode
      ALSA: dice: fix hang when unplugging a running device
      ALSA: dice: implement hwdep device
      ALSA: dice: clear device lock when closing hwdep device
      ALSA: firewire: introduce amdtp_out_stream_running()
      ALSA: dice: reorganize interface definitions
      ALSA: dice: fix device detection for other vendors
      ALSA: dice: support dual-wire stream format at 192 kHz
      ALSA: dice: optimize reading of consecutive registers
      ALSA: firewire: extend snd_fw_transaction()
      ALSA: dice: avoid superflous write at bus reset
      ALSA: dice: remove 10s period length limit
      ALSA: dice: remove superfluous field
      ALSA: dice: make amdtp_rates[] const
      ALSA: dice: get clock capabilities
      ALSA: dice: allow notifications during initialization
      ALSA: dice: get rate-dependent parameters
      ALSA: dice: dynamic sample rate selection
      ALSA: dice: check clock change timeout
      ALSA: dice: add a proc file to show device information
      ALSA: dice: document quadlet alignment
      ALSA: dice: dice_proc_read: remove wrong typecast
      ALSA: dice: fix detection of Weiss devices
      ALSA: dice: restrict the driver to playback-only devices

Stefan Richter (1):
      ALSA: dice: fix locking

 Documentation/ioctl/ioctl-number.txt |    1 +
 include/uapi/sound/Kbuild            |    1 +
 include/uapi/sound/asound.h          |    3 +-
 include/uapi/sound/firewire.h        |   51 ++
 sound/firewire/Kconfig               |   15 +
 sound/firewire/Makefile              |    2 +
 sound/firewire/amdtp.c               |  209 +++--
 sound/firewire/amdtp.h               |   46 +-
 sound/firewire/cmp.c                 |   50 +-
 sound/firewire/dice-interface.h      |  371 +++++++++
 sound/firewire/dice.c                | 1494 ++++++++++++++++++++++++++++++++++
 sound/firewire/fcp.c                 |    2 +-
 sound/firewire/isight.c              |   43 +-
 sound/firewire/lib.c                 |   24 +-
 sound/firewire/lib.h                 |    7 +-
 sound/firewire/scs1x.c               |    8 +-
 sound/firewire/speakers.c            |   16 +-
 17 files changed, 2192 insertions(+), 151 deletions(-)
 create mode 100644 include/uapi/sound/firewire.h
 create mode 100644 sound/firewire/dice-interface.h
 create mode 100644 sound/firewire/dice.c
