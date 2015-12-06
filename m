From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/17 v2] ALSA: oxfw: refactoring and
	merging scs1x module
Date: Sun,  6 Dec 2015 13:18:08 +0900
Message-ID: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E4CF2260496
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset update my previous post for merging ALSA scs1x module to oxfw
module:
[alsa-devel] [RFC][PATCH 0/9] ALSA: oxfw: merge scs1x module
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100534.html

This patchset consists of three parts:
 * 01-05: code refactoring for OXFW module
 * 06-09: code refactoring for old firewire-speaker functionalities in OXFW module
 * 10-17: merge scs1x module

Changes:
 * split some patches for a fine granularity
 * drop a small framework I proposed in previous patch
 * rename functions for AV/C Audio Subunit command

After this patchset is applied, OXFW module is loaded instead of scs1x module.
Then, some names except for rawmidi ID are changed, see patch 16. Currently,
I find no advantage to keep them what they were. I'm welcome to receive your
oppositions about it.

Takashi Sakamoto (17):
  ALSA: oxfw: rename a file for control elements so that it's for
    model-specific
  ALSA: oxfw: rename local functions for control elements so that they
    represent as local
  ALSA: oxfw: change function prototype for AV/C Audio Subunit command
  ALSA: oxfw: reuse driver entry to detect quirk
  ALSA: oxfw: gather model-dependent conditions to a function
  ALSA: oxfw: add memory allocation for model-specific structure
  ALSA: oxfw: move model-specific members from common structure
  ALSA: oxfw: move model-specific parameters from common structure
  ALSA: oxfw: rename a structure so that it means backward compatibility
    to old drivers
  ALSA: oxfw: add scs1x layer
  ALSA: oxfw: allocate own address region for SCS.1 series
  ALSA: oxfw: copy handlers of asynchronous transaction for MIDI capture
  ALSA: oxfw: add MIDI capture port for SCS.1 models
  ALSA: oxfw: copy handlers of asynchronous transaction for MIDI
    playback
  ALSA: oxfw: add MIDI playback port for SCS.1 models
  ALSA: oxfw: obsolete scs1x module
  ALSA: oxfw: add stream format quirk for SCS.1 models

 sound/firewire/Kconfig                             |  12 +-
 sound/firewire/Makefile                            |   2 -
 sound/firewire/oxfw/Makefile                       |   4 +-
 sound/firewire/oxfw/oxfw-scs1x.c                   | 409 +++++++++++++++++++++
 .../firewire/oxfw/{oxfw-control.c => oxfw-spkr.c}  | 142 ++++---
 sound/firewire/oxfw/oxfw.c                         | 110 ++++--
 sound/firewire/oxfw/oxfw.h                         |  23 +-
 7 files changed, 586 insertions(+), 116 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw-scs1x.c
 rename sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} (55%)

-- 
2.5.0
