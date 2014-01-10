From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH v2 00/13] speakers: Add support for
	capture/playback of PCM/MIDI
Date: Sat, 11 Jan 2014 00:29:22 +0900
Message-ID: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 719D22608C9
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:50 +0100 (CET)
In-Reply-To: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In previous series of patch, I showed an idea to add a new driver for
OXFW970/971. This driver can support some recording equipments.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070705.html

ALSA already has a driver, firewire-speakers for these chipsets. But it
supports PCM playback only. The devices need support for capture/playback of
PCM/MIDI.

According to maintainer's advice, I'll add these functionality to
firewire-speakers. Additionally, like the other firewire drivers, I'll add
hwdep interface.

As a result, this driver can support:
 * Oxford Semiconductor OXFW970/971.
 * Griffin Firewave
 * LaCie Firewire Speakers
 * Behringer F-Control Audio 202
 * Mackie Onyx-i series (former model)
 * Mackie Onyx Satellite

This driver can also support but IDs are unknown:
 * Mackie d.2 pro
 * Mackie d.4 pro
 * Mackie U.420
 * Mackie U.420d
 * Mackie Tapco Link.Firewire

Takashi Sakamoto (13):
  speakers: move to its own directory
  speakers: Split stream functionality to a new file and add a header
    file
  speakers: Split PCM functionality to a new file
  speakers: Split control functionality to a new file
  speakers: Change the way to name card
  speakers: Change the way to make PCM rules/constraints
  speakers: Add proc interface for debugging purpose
  speakers: Change the way to start stream
  speakers: Add some AV/C commands to get stream formation and supported
    sampling rates
  speakers: Add support for Behringer/Mackie devices
  speakers: Add support AMDTP in-stream and PCM capture
  speakers: Add support for capture/playback MIDI messages
  speakers: Add hwdep interface

 include/uapi/sound/asound.h                |   3 +-
 include/uapi/sound/firewire.h              |   3 +-
 sound/firewire/Kconfig                     |  11 +-
 sound/firewire/Makefile                    |   3 +-
 sound/firewire/speakers.c                  | 801 -----------------------------
 sound/firewire/speakers/Makefile           |   3 +
 sound/firewire/speakers/speakers.c         | 272 ++++++++++
 sound/firewire/speakers/speakers.h         | 140 +++++
 sound/firewire/speakers/speakers_command.c | 162 ++++++
 sound/firewire/speakers/speakers_control.c | 283 ++++++++++
 sound/firewire/speakers/speakers_hwdep.c   | 195 +++++++
 sound/firewire/speakers/speakers_midi.c    | 150 ++++++
 sound/firewire/speakers/speakers_pcm.c     | 402 +++++++++++++++
 sound/firewire/speakers/speakers_proc.c    |  60 +++
 sound/firewire/speakers/speakers_stream.c  | 534 +++++++++++++++++++
 15 files changed, 2214 insertions(+), 808 deletions(-)
 delete mode 100644 sound/firewire/speakers.c
 create mode 100644 sound/firewire/speakers/Makefile
 create mode 100644 sound/firewire/speakers/speakers.c
 create mode 100644 sound/firewire/speakers/speakers.h
 create mode 100644 sound/firewire/speakers/speakers_command.c
 create mode 100644 sound/firewire/speakers/speakers_control.c
 create mode 100644 sound/firewire/speakers/speakers_hwdep.c
 create mode 100644 sound/firewire/speakers/speakers_midi.c
 create mode 100644 sound/firewire/speakers/speakers_pcm.c
 create mode 100644 sound/firewire/speakers/speakers_proc.c
 create mode 100644 sound/firewire/speakers/speakers_stream.c

-- 
1.8.3.2
