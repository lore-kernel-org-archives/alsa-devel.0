From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/9] ALSA: oxfw: merge scs1x module
Date: Sun, 15 Nov 2015 18:25:56 +0900
Message-ID: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB28261A40
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:10 +0100 (CET)
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

This patchset is for merging ALSA scs1x module to oxfw module.

Models which scs1x supports are based on OXFW971. You can see it in
HSS1394 codes. HSS1394 was a project to investigate protocols for
Stanton Controllers and Systems 1.
http://bazaar.launchpad.net/~mixxxdevelopers/hss1394/trunk/view/head:/code/src/Oxford1394Definitions.h

ALSA firewire stack already has oxfw driver for OXFW970/971, therefore
it's better to merge scs1x module to it. Then, the stack supports SCS.1m
with additional PCM functionality.

This patchset consists of three parts:
 * 01: add a framework to support model-dependent functionalities
 * 02-04: apply the framework for firewire-speakers
 * 05-09: merge scs1x module with the framework

As I describe in patch 05, there's an issue to SCS.1d. Please see the
commit comment.

Takashi Sakamoto (9):
  ALSA: oxfw: add a small framework for model-unique functionalities
  ALSA: oxfw: rename a file for control elements so that it means being
    model-specific
  ALSA: oxfw: rename local functions for control elements so that they
    represent as local
  ALSA: oxfw: apply model-specific functionality framework to
    firewire-speakers
  ALSA: oxfw: add scs1x layer
  ALSA: oxfw: copy MIDI capture functionality to scs1x layer
  ALSA: oxfw: copy MIDI playback functionality to scs1x layer
  ALSA: oxfw: optimize MIDI operations to model-specific framework
  ALSA: oxfw: obsolete scs1x module

 sound/firewire/Kconfig                             |  12 +-
 sound/firewire/Makefile                            |   2 -
 sound/firewire/oxfw/Makefile                       |   4 +-
 sound/firewire/oxfw/oxfw-scs1x.c                   | 413 ++++++++++++++++
 .../firewire/oxfw/{oxfw-control.c => oxfw-spkr.c}  | 116 +++--
 sound/firewire/oxfw/oxfw.c                         | 103 ++--
 sound/firewire/oxfw/oxfw.h                         |  25 +-
 sound/firewire/scs1x.c                             | 530 ---------------------
 8 files changed, 575 insertions(+), 630 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw-scs1x.c
 rename sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} (62%)
 delete mode 100644 sound/firewire/scs1x.c

-- 
2.5.0
