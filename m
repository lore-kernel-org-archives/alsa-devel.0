From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 0/2 v2] usb-audio misc fix
Date: Tue, 6 Dec 2016 14:46:13 +0900
Message-ID: <20161206054615.29187-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

This patch set contains the following patches

Andreas Pape (1):
  ALSA: usb-audio: more tolerant packetsize

Daniel Girnus (1):
  ALSA: usb-audio: avoid setting of sample rate multiple times on bus

 sound/usb/endpoint.c |  4 ++--
 sound/usb/pcm.c      | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.9.3
