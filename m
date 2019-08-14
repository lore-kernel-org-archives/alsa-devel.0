From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] A few more HD-audio core fixes / cleanups
Date: Wed, 14 Aug 2019 21:39:01 +0200
Message-ID: <20190814193905.5530-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBC32F8015B
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 21:39:10 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A1DEBABB1
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 19:39:09 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of yet another patches for HD-audio core stuff.
The first two are workarounds for possible races in the driver
registration and other two are merely cleanups.


Takashi

===

Takashi Iwai (4):
  ALSA: hda - Drop unsol event handler for Intel HDMI codecs
  ALSA: hda: Add codec on bus address table lately
  ALSA: hda: Drop export of snd_hdac_bus_add/remove_device()
  ALSA: hda: Unexport a few more stuff

 include/sound/hdaudio.h    |  9 ---------
 sound/hda/hdac_bus.c       |  8 ++++----
 sound/hda/hdac_device.c    | 27 ++++++++++++++-------------
 sound/hda/hdac_regmap.c    |  1 +
 sound/hda/local.h          |  7 +++++++
 sound/pci/hda/patch_hdmi.c |  9 ++++++++-
 6 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.16.4
