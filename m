From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Thu, 12 Apr 2012 13:51:09 +0200
Message-ID: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C7622417E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:51:24 +0200 (CEST)
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

Here's the 7th iteration of patches that reimplement the streaming logic of
the ALSA USB audio driver.

There were some bugs reportes by Felix and Grant, which have been resolved.

More testing is definitely important, but maybe the code will get a wider
test coverage when merged to the development tree?


Daniel


Daniel Mack (6):
  ALSA: snd-usb: add snd_usb_audio-wide mutex
  ALSA: snd-usb: implement new endpoint streaming model
  ALSA: snd-usb: switch over to new endpoint streaming logic
  ALSA: snd-usb: remove old streaming logic
  ALSA: snd-usb: add support for implicit feedback
  ALSA: snd-usb: add some documentation

 sound/usb/card.c     |   10 +-
 sound/usb/card.h     |   62 ++
 sound/usb/endpoint.c | 1601 ++++++++++++++++++++++++++++----------------------
 sound/usb/endpoint.h |   32 +-
 sound/usb/pcm.c      |  441 ++++++++++++---
 sound/usb/stream.c   |   31 +-
 sound/usb/usbaudio.h |    2 +
 7 files changed, 1381 insertions(+), 798 deletions(-)

-- 
1.7.7.6
