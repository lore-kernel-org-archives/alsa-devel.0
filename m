From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/7] ALSA: firewire: apply deleyed registration
	to all drivers
Date: Thu, 31 Mar 2016 08:47:01 +0900
Message-ID: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F3402650BD
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:47:14 +0200 (CEST)
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

Commit b59fb1900b4fee('ALSA: dice: postpone card registration') applied
delayed registration[1] of sound card instance to ALSA dice driver. This idea
is also nice for drivers in ALSA firewire stack because in IEEE 1394 bus adding
units is corresponding to bus reset and the actual units tend not to work well
during bus-reset state.

This patchset adds a new function to firewire-lib module to schedule a delayed
work for sound card registration. Currently, the work is commonly scheduled 2
seconds after time of the last bus-reset recorded by Linux firewire core. Then,
take all drivers to use it as Dice driver does.

Related to this patchset, I'd like to cancel a discussion about my proposed
patchset to remove unpractical module parameters from ALSA bebob/fireworks[2].
I'm sorry for reviewers but my work priority to this patchset is prior to the
former one.


[1]: [alsa-devel] [PATCH 0/4 v5] ALSA: dice: improve card registration
processing
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102562.html

[2]: [alsa-devel] [PATCH 0/2] ALSA: bebob/fireworks: remove module parameters to
reduce maintenance work
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/106219.html

Regards


Takashi Sakamoto (8):
  ALSA: firewire-lib: suppress kernel warnings when releasing
    uninitialized stream data
  ALSA: dice: simplify unit probe processing
  ALSA: firewire-lib: add new function to schedule a work for sound card
    registration
  ALSA: bebob: delayed registration of sound card
  ALSA: fireworks: delayed registration of sound card
  ALSA: oxfw: delayed registration of sound card
  ALSA: firewire-digi00x: delayed registration of sound card
  ALSA: firewire-tascam: deleyed registration of sound card

 sound/firewire/amdtp-stream.c                |   4 +
 sound/firewire/bebob/bebob.c                 | 215 ++++++++++++++++-----------
 sound/firewire/bebob/bebob.h                 |   5 +-
 sound/firewire/dice/dice.c                   |  34 +----
 sound/firewire/digi00x/digi00x-transaction.c |   7 +-
 sound/firewire/digi00x/digi00x.c             | 107 +++++++++----
 sound/firewire/digi00x/digi00x.h             |   3 +
 sound/firewire/fireworks/fireworks.c         | 147 ++++++++++++------
 sound/firewire/fireworks/fireworks.h         |   3 +
 sound/firewire/lib.c                         |  32 ++++
 sound/firewire/lib.h                         |   3 +
 sound/firewire/oxfw/oxfw.c                   | 151 ++++++++++++-------
 sound/firewire/oxfw/oxfw.h                   |   3 +
 sound/firewire/tascam/tascam.c               | 118 ++++++++++-----
 sound/firewire/tascam/tascam.h               |   2 +
 15 files changed, 551 insertions(+), 283 deletions(-)

-- 
2.7.4
