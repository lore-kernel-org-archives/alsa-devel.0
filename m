From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire: block .remove callback of
	bus
Date: Wed, 10 Oct 2018 15:34:58 +0900
Message-ID: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 538822678AB
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 08:35:10 +0200 (CEST)
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so2019585plr.8
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2018 23:35:10 -0700 (PDT)
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

In a discussion for devres support[1], I realize difference of unbind
behaviour of drivers in ALSA firewire stack and in the others. For
consistency behaviour inner the same subsystem for users, it's better
to imitate the behaviour.

Additionally, blocking .remove function simplifies codes to releasing
device.

This commit uses 'snd_card_free()' instead of
'snd_card_free_when_closed()' in .remove function and performs
refactoring for release codes.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140431.html

Takashi Sakamoto (4):
  ALSA: firewire: block .remove callback of bus driver till all of ALSA
    character devices are released
  ALSA: firewire: release reference count of firewire unit in .remove
    callback of bus driver
  ALSA: bebob/fireworks: simplify handling of local device entry table
  ALSA: firewire: simplify cleanup process when failing to register
    sound card

 sound/firewire/bebob/bebob.c         | 43 ++++++---------------
 sound/firewire/dice/dice.c           | 35 ++++-------------
 sound/firewire/digi00x/digi00x.c     | 28 +++++---------
 sound/firewire/fireface/ff.c         | 28 +++++---------
 sound/firewire/fireworks/fireworks.c | 56 ++++++++--------------------
 sound/firewire/isight.c              |  8 ++--
 sound/firewire/motu/motu.c           | 39 +++++--------------
 sound/firewire/oxfw/oxfw.c           | 39 +++++--------------
 sound/firewire/tascam/tascam.c       | 32 +++++-----------
 9 files changed, 90 insertions(+), 218 deletions(-)

-- 
2.19.0
