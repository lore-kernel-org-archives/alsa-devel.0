From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/5] snd-usb endpoint logic rework, version 3
Date: Mon, 19 Dec 2011 00:02:27 +0100
Message-ID: <1324249352-14738-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id DCDC3103870
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 00:02:51 +0100 (CET)
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

This is the 3rd round, and I didn't mark it RFC anymore as Clemens and
Takashi agreed on the way of implementation in general.

So in comparison to the last version, this round incorporates some
spinlock fixes, a lot less debugging output and my S-o-b lines.

Please test this extensively with different sound cards.

I didn't experience a single problem over the last hours of testing,
but the more testing the better.


Thanks,
Daniel


Daniel Mack (5):
  ALSA: snd-usb: add snd_usb_audio-wide mutex
  ALSA: snd-usb: implement new endpoint streaming model
  ALSA: snd-usb: switch over to new endpoint streaming logic
  ALSA: snd-usb: remove old streaming logic
  ALSA: snd-usb: add support for implicit feedback

 sound/usb/card.c     |    8 +-
 sound/usb/card.h     |   65 +++
 sound/usb/endpoint.c | 1427 +++++++++++++++++++++++++-------------------------
 sound/usb/endpoint.h |   31 +-
 sound/usb/pcm.c      |  428 +++++++++++++---
 sound/usb/stream.c   |   31 +-
 sound/usb/usbaudio.h |    2 +
 7 files changed, 1191 insertions(+), 801 deletions(-)

-- 
1.7.5.4
