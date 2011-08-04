From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/3] 3 Patches for better UAC2 handling
Date: Thu,  4 Aug 2011 15:56:25 +0200
Message-ID: <1312466188-3428-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 029D424418
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 15:56:57 +0200 (CEST)
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

Sorry, I've been distracted, but here are 3 patches that should be
included.

Thanks,
Daniel

Daniel Mack (2):
  ALSA: snd-usb: Accept UAC2 FORMAT_TYPE descriptors with bLength > 6
  ALSA: snd-usb: operate on given mixer interface only

Nicolai Krakowiak (1):
  ALSA: snd-usb: avoid dividing by zero on invalid input

 sound/usb/endpoint.c |    2 +-
 sound/usb/mixer.c    |   25 +++++++++++++------------
 sound/usb/mixer.h    |    1 +
 3 files changed, 15 insertions(+), 13 deletions(-)

-- 
1.7.5.4
