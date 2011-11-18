From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/5] RFC v2 for snd-usb endpoint logic rework
Date: Fri, 18 Nov 2011 21:05:39 +0100
Message-ID: <1321646744-13656-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id EC46524390
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 21:06:00 +0100 (CET)
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

This is v2 of the patch bulk I posted some weeks ago, which incoporates
the points that were discussed. Thanks to everyone who commented and
helped with sugesstions.

This version work really well here, but as last time, it needs a lot
more testing. What's still missing are some cleanups and more
documentation, I'll do that once the acutal content is agreed upon.

Patches should apply cleanly to the latest mainline git + Takashi's
sound tree.

Thanks for any feedback for this next round,
Daniel


Daniel Mack (5):
  ALSA: snd-usb: add snd_usb_audio-wide mutex
  ALSA: snd-usb: implement new endpoint streaming model
  ALSA: snd-usb: switch over to new endpoint streaming logic
  ALSA: snd-usb: remove old streaming logic
  ALSA: snd-usb: add support for implicit feedback

 sound/usb/card.c     |    8 +-
 sound/usb/card.h     |   65 +++
 sound/usb/endpoint.c | 1434 +++++++++++++++++++++++++-------------------------
 sound/usb/endpoint.h |   31 +-
 sound/usb/pcm.c      |  444 +++++++++++++---
 sound/usb/stream.c   |   31 +-
 sound/usb/usbaudio.h |    2 +
 7 files changed, 1214 insertions(+), 801 deletions(-)

-- 
1.7.5.4
