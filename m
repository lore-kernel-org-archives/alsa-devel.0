From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] USB-audio disconnection lockdep fixes
Date: Wed, 26 Aug 2015 16:16:06 +0200
Message-ID: <1440598569-4473-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B761265259
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 16:16:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of patches for USB-audio to improve the lock
handling at disconnection.  Originally it was aimed to get rid of
spurious lockdep warnings, but this ended up with the rewrite and
improvement of locking code at disconnection and its checks in the
mixer and PCM codes.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Avoid nested autoresume calls
  ALSA: usb-audio: Replace probing flag with active refcount
  ALSA: usb-audio: Handle normal and auto-suspend equally

 sound/usb/card.c         | 108 ++++++++++++++++++++++------------------
 sound/usb/endpoint.c     |  10 ++--
 sound/usb/mixer.c        |  32 ++++--------
 sound/usb/mixer_quirks.c | 126 ++++++++++++++++++++---------------------------
 sound/usb/pcm.c          |  32 ++++++------
 sound/usb/proc.c         |   4 +-
 sound/usb/usbaudio.h     |  11 +++--
 7 files changed, 155 insertions(+), 168 deletions(-)

-- 
2.5.0
