From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/5] snd-usb endpoint rework, take 4
Date: Tue, 20 Dec 2011 10:48:35 +0100
Message-ID: <1324374520-32332-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C0C862438A
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 10:48:53 +0100 (CET)
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

As stated in reply to my previous series, the last version caused deadlocks
when quickly starting and stopping the PCM streams. These should finally be
fixed now. Tested with both the FTU and a sync-endpoint driven device.

Please check and report :)

Daniel


Daniel Mack (5):
  ALSA: snd-usb: add snd_usb_audio-wide mutex
  ALSA: snd-usb: implement new endpoint streaming model
  ALSA: snd-usb: switch over to new endpoint streaming logic
  ALSA: snd-usb: remove old streaming logic
  ALSA: snd-usb: add support for implicit feedback

 sound/usb/card.c     |   10 +-
 sound/usb/card.h     |   63 +++
 sound/usb/endpoint.c | 1458 ++++++++++++++++++++++++++------------------------
 sound/usb/endpoint.h |   32 +-
 sound/usb/pcm.c      |  435 +++++++++++++---
 sound/usb/stream.c   |   31 +-
 sound/usb/usbaudio.h |    2 +
 7 files changed, 1229 insertions(+), 802 deletions(-)

-- 
1.7.5.4
