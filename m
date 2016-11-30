From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 0/3 v1] usb-misc fix
Date: Wed, 30 Nov 2016 16:59:20 +0900
Message-ID: <20161130075923.15205-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

This patch set contains the following patches

Andreas Pape (1):
  ALSA: usb-audio: more tolerant packetsize

Daniel Girnus (1):
  ALSA: usb-audio: avoid setting of sample rate multiple times on bus

Mark Craske (1):
  ALSA: usb-audio: fix race in snd_usb_endpoint_stop

 sound/usb/endpoint.c | 24 ++++++++++++++++--------
 sound/usb/pcm.c      | 21 +++++++++++----------
 2 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.9.3
