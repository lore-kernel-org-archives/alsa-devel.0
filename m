From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/8] ALSA: firewire: minor code refactoring and
	bug
Date: Tue, 18 Jun 2019 22:26:14 +0900
Message-ID: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BC04F80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:29 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

During a couple of weeks, I added code refactoring to all of drivers in
ALSA firewire stack. But I can find some rooms for additional code
refactoring and some bugs.

This patchset is for them.

Takashi Sakamoto (8):
  ALSA: firewire-tascam: unify stop and release method for duplex
    streams
  ALSA: fireface: unify stop and release method for duplex streams
  ALSA: firewire-motu: unify stop and release method for duplex streams
  ALSA: firewire-digi00x: unify stop and release method for duplex
    streams
  ALSA: dice: unify stop and release method for duplex streams
  ALSA: bebob: ensure to release isochronous resources in pcm.hw_params
    callback
  ALSA: fireworks: ensure to release isochronous resources in
    pcm.hw_params callback
  ALSA: oxfw: ensure to release isochronous resources in pcm.hw_params
    callback

 sound/firewire/bebob/bebob_stream.c         |  3 +++
 sound/firewire/dice/dice-midi.c             |  1 -
 sound/firewire/dice/dice-pcm.c              |  1 -
 sound/firewire/dice/dice-stream.c           |  8 ++------
 sound/firewire/dice/dice.h                  |  1 -
 sound/firewire/digi00x/digi00x-midi.c       |  1 -
 sound/firewire/digi00x/digi00x-pcm.c        |  1 -
 sound/firewire/digi00x/digi00x-stream.c     | 14 +++++---------
 sound/firewire/digi00x/digi00x.h            |  1 -
 sound/firewire/fireface/ff-pcm.c            |  1 -
 sound/firewire/fireface/ff-stream.c         | 14 +++++---------
 sound/firewire/fireface/ff.h                |  1 -
 sound/firewire/fireworks/fireworks_stream.c |  3 +++
 sound/firewire/motu/motu-midi.c             |  1 -
 sound/firewire/motu/motu-pcm.c              |  1 -
 sound/firewire/motu/motu-stream.c           | 14 +++++---------
 sound/firewire/motu/motu.h                  |  1 -
 sound/firewire/oxfw/oxfw-stream.c           |  2 ++
 sound/firewire/tascam/tascam-pcm.c          |  1 -
 sound/firewire/tascam/tascam-stream.c       | 14 +++++---------
 sound/firewire/tascam/tascam.h              |  1 -
 21 files changed, 30 insertions(+), 55 deletions(-)

-- 
2.20.1
