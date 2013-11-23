From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/13] bebob: a new driver for BridgeCo
	BeBoB based device
Date: Sat, 23 Nov 2013 15:09:12 +0900
Message-ID: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 034E0265309
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In previous series of patch, I showed enhancement of current firewire-lib. So
I should show the way to use new functions in each driver side. This driver is
under development but functionalities for streaming seems to be fixed.  I'm
happy to receive your comments.

This is a new driver for BridgeCo BeBoB based device. FFADO (successor of
FreeBoB project) currently give driver and mixer control in user space. My aim
of this series of patch is just to give a support for kernel streaming.

In theory, this driver just support kernel streaming and related functionality.
But for my debugging, this module still includes some functionality which
should be in user space.

Additionally, there is a heavily customized version of BeBoB. For some reasons,
this driver give a few functionality to control such device.

Takashi Sakamoto (13):
  bebob: Add skelton for BridgeCo BeBoB based devices
  bebob: Add command and stream management
  bebob: Add proc interface for debug
  bebob: Add functionality to change sampling rate and control interface
  bebob: Add MIDI interface
  bebob: Add PCM interface
  bebob: Add hwdep interface to lock/unlock streaming
  bebob: Prepare for device specific operations
  bebob: add support for M-Audio Firewire series
  bebob: Add support for Focusrite Saffire/SaffirePro series
  bebob: Add support for Terratec PHASE series
  bebob: Add support for Yamaha GO series
  bebob: Add support for Presonus FIREBOX/FIREPOD

 include/uapi/sound/asound.h            |   3 +-
 include/uapi/sound/firewire.h          |   1 +
 sound/firewire/Kconfig                 |  29 ++
 sound/firewire/Makefile                |   1 +
 sound/firewire/bebob/Makefile          |   6 +
 sound/firewire/bebob/bebob.c           | 450 ++++++++++++++++
 sound/firewire/bebob/bebob.h           | 255 +++++++++
 sound/firewire/bebob/bebob_command.c   | 423 +++++++++++++++
 sound/firewire/bebob/bebob_control.c   | 331 ++++++++++++
 sound/firewire/bebob/bebob_focusrite.c | 390 ++++++++++++++
 sound/firewire/bebob/bebob_hwdep.c     | 207 ++++++++
 sound/firewire/bebob/bebob_maudio.c    | 910 +++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c      | 182 +++++++
 sound/firewire/bebob/bebob_pcm.c       | 420 +++++++++++++++
 sound/firewire/bebob/bebob_presonus.c  |  75 +++
 sound/firewire/bebob/bebob_proc.c      | 164 ++++++
 sound/firewire/bebob/bebob_stream.c    | 724 ++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_terratec.c  | 143 ++++++
 sound/firewire/bebob/bebob_yamaha.c    | 176 +++++++
 19 files changed, 4889 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/Makefile
 create mode 100644 sound/firewire/bebob/bebob.c
 create mode 100644 sound/firewire/bebob/bebob.h
 create mode 100644 sound/firewire/bebob/bebob_command.c
 create mode 100644 sound/firewire/bebob/bebob_control.c
 create mode 100644 sound/firewire/bebob/bebob_focusrite.c
 create mode 100644 sound/firewire/bebob/bebob_hwdep.c
 create mode 100644 sound/firewire/bebob/bebob_maudio.c
 create mode 100644 sound/firewire/bebob/bebob_midi.c
 create mode 100644 sound/firewire/bebob/bebob_pcm.c
 create mode 100644 sound/firewire/bebob/bebob_presonus.c
 create mode 100644 sound/firewire/bebob/bebob_proc.c
 create mode 100644 sound/firewire/bebob/bebob_stream.c
 create mode 100644 sound/firewire/bebob/bebob_terratec.c
 create mode 100644 sound/firewire/bebob/bebob_yamaha.c

-- 
1.8.3.2
