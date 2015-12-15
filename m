From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: oxfw: code refactoring for
	model-dependent quirks
Date: Tue, 15 Dec 2015 23:56:16 +0900
Message-ID: <1450191381-16352-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 211AF26262A
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 15:56:27 +0100 (CET)
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

ALSA oxfw driver has got some patches to expand its functionalities. As a
result, current code includes some inefficiencies and confusions.

This patchset is a code refactoring about model-dependent quirks. This
patchset is a part of my previous RFCv2 (patch 01-05) and a preparation for
the rest of patches:

[alsa-devel] [RFC][PATCH 00/17 v2] ALSA: oxfw: refactoring and merging scs1x module
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101558.html

Takashi Sakamoto (5):
  ALSA: oxfw: rename a file for control elements so that it's for
    model-specific
  ALSA: oxfw: rename local functions for control elements so that they
    represent as local
  ALSA: oxfw: change function prototype for AV/C Audio Subunit command
  ALSA: oxfw: reuse driver entry to detect quirk
  ALSA: oxfw: gather model-dependent conditions to a function

 sound/firewire/oxfw/Makefile                       |  4 +-
 .../firewire/oxfw/{oxfw-control.c => oxfw-spkr.c}  | 80 ++++++++++++----------
 sound/firewire/oxfw/oxfw.c                         | 59 +++++++++-------
 sound/firewire/oxfw/oxfw.h                         |  6 +-
 4 files changed, 86 insertions(+), 63 deletions(-)
 rename sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} (71%)

-- 
2.5.0
