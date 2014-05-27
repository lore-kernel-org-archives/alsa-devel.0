From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/12] fixes for firewire topic branch
Date: Wed, 28 May 2014 00:14:35 +0900
Message-ID: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E567265843
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This series of patch is to fix this patchset:
[PATCH 00/49 v4] Enhancement for support of Firewire devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-April/075841.html

After the patchset was merged into firewire topic branch, kbuild test backend
reports some warnings. And I found some bugs and minor issues by myself.

If you want to see fixup for each patch in the patchset, please see:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/077140.html

Takashi Sakamoto (12):
  firewire-lib: Use ARRAY_SIZE() instead of sizeof() for correct loop
    limit
  firewire-lib: Fix sparse warning of incorrect type in assignment
  fireworks: Fix wrong value as argument for PTR_ERR()
  fireworks: Use the same prototype for functions as actual declaration
  fireworks/bebob: Change type of argument for sampling rate
  fireworks/bebob: Use the same type of variables as function parameters
  fireworks/bebob: Add suffix for long long integer literal
  fireworks/bebob: Improve indentation
  bebob: Use different names for identifiers in the same file
  bebob: Add static specifier to identifier with file scope
  bebob: Remove meaningless mutex_unlock()
  bebob: Improve comments about stream format

 sound/firewire/amdtp.c                           |  4 ++--
 sound/firewire/bebob/bebob.c                     |  9 ++++-----
 sound/firewire/bebob/bebob.h                     |  6 +++---
 sound/firewire/bebob/bebob_focusrite.c           | 24 ++++++++++++------------
 sound/firewire/bebob/bebob_maudio.c              |  4 ++--
 sound/firewire/bebob/bebob_midi.c                |  4 ++--
 sound/firewire/bebob/bebob_stream.c              |  7 ++++---
 sound/firewire/bebob/bebob_terratec.c            |  6 +++---
 sound/firewire/cmp.c                             |  4 +++-
 sound/firewire/fireworks/fireworks.h             |  5 +++--
 sound/firewire/fireworks/fireworks_hwdep.c       |  2 +-
 sound/firewire/fireworks/fireworks_midi.c        |  4 ++--
 sound/firewire/fireworks/fireworks_pcm.c         |  4 ++--
 sound/firewire/fireworks/fireworks_stream.c      |  2 +-
 sound/firewire/fireworks/fireworks_transaction.c |  4 ++--
 15 files changed, 46 insertions(+), 43 deletions(-)

-- 
1.8.3.2
