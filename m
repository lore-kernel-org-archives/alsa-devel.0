From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/5] snd-usb endpoint rework, take 5
Date: Wed, 21 Dec 2011 00:34:43 +0100
Message-ID: <1324424088-5705-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id BA8FA2412D
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 00:35:02 +0100 (CET)
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

I actually wanted to wait for more input, but as the flaws reported so
far were rather minor, I addressed to following details in this new
round as mentioned by Takashi and Clemens:

 - removed the faulty "(!u || u->urb)" check
 - guard the result of min() with the spinlock inside next_packet_size()
 - removed the tasklet and made the handler a function that is called
   in-place

Thanks again for the reviews, and keep them coming :)

Daniel

Daniel Mack (5):
  ALSA: snd-usb: add snd_usb_audio-wide mutex
  ALSA: snd-usb: implement new endpoint streaming model
  ALSA: snd-usb: switch over to new endpoint streaming logic
  ALSA: snd-usb: remove old streaming logic
  ALSA: snd-usb: add support for implicit feedback

 sound/usb/card.c     |   10 +-
 sound/usb/card.h     |   62 +++
 sound/usb/endpoint.c | 1454 +++++++++++++++++++++++++------------------------
 sound/usb/endpoint.h |   32 +-
 sound/usb/pcm.c      |  437 +++++++++++++---
 sound/usb/stream.c   |   31 +-
 sound/usb/usbaudio.h |    2 +
 7 files changed, 1224 insertions(+), 804 deletions(-)

-- 
1.7.5.4
