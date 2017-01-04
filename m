From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH v3 0/2] ALSA: Fix usb-audio races
Date: Thu,  5 Jan 2017 00:37:45 +0200
Message-ID: <20170104223747.2742-1-adi@adirat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Changes since v2:
    * Fixed snd_usb_*lock_shutdown imbalance caused by an early return
    in snd_usb_pcm_prepare()

Ioan-Adrian Ratiu (2):
  ALSA: usb-audio: Fix irq/process data synchronization
  ALSA: usb-audio: test EP_FLAG_RUNNING at urb completion

 sound/usb/endpoint.c | 20 ++++++++++----------
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.11.0
