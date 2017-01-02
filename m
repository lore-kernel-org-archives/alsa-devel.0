From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH v2 0/2] ALSA: Fix usb-audio races
Date: Mon,  2 Jan 2017 17:50:29 +0200
Message-ID: <20170102155031.3638-1-adi@adirat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz, o-takashi@sakamocchi.jp
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Many thanks to Takashi Iwai & Sakamoto for their awesome feedback.

Changes since v1:
    * Rebased my fix on top of tiwai's revert and integrated the changes
    from the original fix into this.
    * Dropped the stop_endpoints() call inside snd_usb_pcm_prepare() and
    kept the previously existing snd_usb_endpoint_sync_pending_stop() call.
    * Retained the deactivate_urbs() call in snd_usb_pcm_prepare(), I only
    removed the can_sleep logic.
    * Split the EP_FLAG_RUNNING check in a separate commit to keep the log
    clean since this is not part of the race fix.

Ioan-Adrian Ratiu (2):
  ALSA: usb-audio: Fix irq/process data synchronization
  ALSA: usb-audio: test EP_FLAG_RUNNING at urb completion

 sound/usb/endpoint.c | 20 ++++++++++----------
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.11.0
