From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/8] ALSA: oxfw: obsolete snd-scs1x with
	snd-oxfw
Date: Tue, 22 Dec 2015 09:15:38 +0900
Message-ID: <1450743346-14071-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id ED4D2261298
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 01:15:52 +0100 (CET)
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

This patchset update a part of my previous RFCv2 (patch 10-17).
[alsa-devel] [RFC][PATCH 00/17 v2] ALSA: oxfw: refactoring and merging scs1x module
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101558.html

This patchset should be accumurated to the other patches under reviewing.

[alsa-devel] [PATCH 0/4] ALSA: oxfw: localize stuffs of old firewire-speakers module
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102071.html


This patchset obsoletes snd-scs1x module with snd-oxfw module because the models
supported by snd-scs1x module are based on OXFW971, which snd-oxfw supports, too.
So snd-oxfw should support them. As a result, one of the models gets packet
streaming functionality to receive PCM samples. This is a lack of
functionalities in snd-scs1x.


Usually I won't post additional patches during the others are under reviewing.
But it's near the end of year. I'd like to post these patches in advance to
avoid year-end busyness. I'm happy if you review them and these patches go
forward, then I can get a short rest in the year-end.

I note that I have the other patches for ALSA dice module, too. I'm also happy
to start reviewing process for them after this patchset goes forward...

Changes from RFCv2:
 * remove sound/firewire/scs1x.c (I forget it)
 * revise operations in rawmidi callbacks

Takashi Sakamoto (8):
  ALSA: oxfw: add scs1x layer
  ALSA: oxfw: allocate own address region for SCS.1 series
  ALSA: oxfw: copy handlers of asynchronous transaction for MIDI capture
  ALSA: oxfw: add MIDI capture port for SCS.1 models
  ALSA: oxfw: copy handlers of asynchronous transaction for MIDI
    playback
  ALSA: oxfw: add MIDI playback port for SCS.1 models
  ALSA: oxfw: obsolete scs1x module
  ALSA: oxfw: add stream format quirk for SCS.1 models

 sound/firewire/Kconfig           |  12 +-
 sound/firewire/Makefile          |   2 -
 sound/firewire/oxfw/Makefile     |   2 +-
 sound/firewire/oxfw/oxfw-scs1x.c | 406 ++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.c       |  38 ++-
 sound/firewire/oxfw/oxfw.h       |   2 +
 sound/firewire/scs1x.c           | 530 ---------------------------------------
 7 files changed, 446 insertions(+), 546 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw-scs1x.c
 delete mode 100644 sound/firewire/scs1x.c

-- 
2.5.0
