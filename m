From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: use managed-resource to maintain
	allocated buffers
Date: Wed,  3 Oct 2018 08:21:49 +0900
Message-ID: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A02E2676A7
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 01:22:07 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so2477023plb.10
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 16:22:07 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Linux Device Driver subsystem has a feature of 'devres', which is
resource allocator/deallocator synchronously to reference counter
of kobject corresponding to device structure. This feature avoid
memory leak from programming mistakes.

This patchset replaces calls of allocator/deallocator with devres
helper functions. There're two types of target device structure;
firewire unit device and sound card device. All drivers in ALSA
firewire stack use reference counting to serialize timing to
release the type of two device, therefore no worries of
dereferencing to released memory objects.

This patchset is for v4.20 and based on my series of fix patches
in 'sound-4.19-rc5' branch. But current 'for-next' branch doesn't
include them. So this patchset is rebased to upstream 'master'
branch (HEAD=067284726963). I'm OK to take them pending till
the '-rc5' is merged.

Takashi Sakamoto (5):
  ALSA: firewire: use managed-resource of fw unit device for private
    data
  ALSA: bebob: use managed-resource to maintain data specific to M-Audio
    FW-1814/ProjectMix I/O
  ALSA: fireworks: use managed-resource to maintain response buffer
  ALSA: oxfw: use managed-resource to maintain model-specific data
  ALSA: oxfw: use managed-resource to maintain cache of stream formats

 sound/firewire/bebob/bebob.c         | 17 ++++++-----------
 sound/firewire/bebob/bebob_maudio.c  |  5 +++--
 sound/firewire/dice/dice.c           |  8 +++-----
 sound/firewire/digi00x/digi00x.c     |  9 ++++-----
 sound/firewire/fireface/ff.c         | 10 +++-------
 sound/firewire/fireworks/fireworks.c | 15 +++++----------
 sound/firewire/motu/motu.c           | 10 ++++------
 sound/firewire/oxfw/oxfw-scs1x.c     |  5 +++--
 sound/firewire/oxfw/oxfw-spkr.c      |  5 +++--
 sound/firewire/oxfw/oxfw-stream.c    | 13 ++++++++-----
 sound/firewire/oxfw/oxfw.c           | 28 ++++------------------------
 sound/firewire/tascam/tascam.c       | 10 +++-------
 12 files changed, 49 insertions(+), 86 deletions(-)

-- 
2.17.1
