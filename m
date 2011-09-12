From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/4] Cleanups for snd-usb-audio
Date: Mon, 12 Sep 2011 18:54:09 +0200
Message-ID: <1315846453-5036-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 759D9244CB
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 18:53:55 +0200 (CEST)
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I prepared a subset of my work on the generic USB audio driver that
doesn't actually change any logic but just moves around major chunks
of code. Can we get this merged as preparation for the more intrusive
parts that follow?


Thanks,
Daniel


Daniel Mack (4):
  USB: Add endpoint usage definitions to ch9.h
  ALSA: snd-usb: re-order the Makefile
  ALSA: snd-usb: re-order code
  ALSA: snd-usb: move code from urb.c to endpoint.c

 include/linux/usb/ch9.h |   17 +-
 sound/usb/Makefile      |   12 +-
 sound/usb/card.c        |    4 +-
 sound/usb/endpoint.c    | 1185 +++++++++++++++++++++++++++++++++--------------
 sound/usb/endpoint.h    |   20 +-
 sound/usb/pcm.c         |    2 +-
 sound/usb/quirks.c      |    7 +-
 sound/usb/stream.c      |  452 ++++++++++++++++++
 sound/usb/stream.h      |   12 +
 sound/usb/urb.c         |  941 -------------------------------------
 sound/usb/urb.h         |   21 -
 11 files changed, 1341 insertions(+), 1332 deletions(-)
 create mode 100644 sound/usb/stream.c
 create mode 100644 sound/usb/stream.h
 delete mode 100644 sound/usb/urb.c
 delete mode 100644 sound/usb/urb.h

-- 
1.7.5.4
