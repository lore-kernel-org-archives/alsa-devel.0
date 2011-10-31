From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/5] RFC for snd-usb: rework usb endpoint logic
Date: Mon, 31 Oct 2011 13:10:25 +0100
Message-ID: <1320063030-3502-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C8DB22469F
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 13:10:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

It's been a while since the last round of patches for this topic, so
here is a new version.

In contrast to earlier versions, I did another bunch of cleanips and
can now use input and output simultaniously.

The patches that follow are structured in a way that should make
reviews easier, as they first implement a new streaming model while
leaving the old one working, and then switch to it in a separate
patch. This way, the series is also fully bisectable.

The problems that remain is a regression in handling data streams
with feedback endpoints in full duplex mode and a hard lockup when
changing audio parameters while two streams are running. I guess the
latter is caused by missing locking.

I didn't sign-off the patches on purpose, as I would really like to
get them reviewed before they go in. Can people have a look and state
whether the whole idea is at all sane?


Thanks a lot,
Daniel


Daniel Mack (5):
  ALSA: snd-usb: implement new endpoint streaming model
  ALSA: snd-usb: switch over to new endpoint streaming logic
  ALSA: snd-usb: remove old streaming logic
  ALSA: snd-usb: set MAX_URBS to 16
  ALSA: snd-usb: add support for implicit feedback

 sound/usb/card.c     |    6 +-
 sound/usb/card.h     |   56 ++-
 sound/usb/endpoint.c | 1347 ++++++++++++++++++++++++--------------------------
 sound/usb/endpoint.h |   31 +-
 sound/usb/pcm.c      |  412 +++++++++++++---
 sound/usb/stream.c   |   31 +-
 sound/usb/usbaudio.h |    1 +
 7 files changed, 1081 insertions(+), 803 deletions(-)

-- 
1.7.5.4
