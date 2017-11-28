From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 0/3] ALSA: usb-audio: fix OOB and return value check
Date: Tue, 28 Nov 2017 09:36:25 +0900
Message-ID: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, stable <stable@vger.kernel.org>, alsa-devel@alsa-project.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series fixes the out-of-bound error caused by the return value
of usb_string(). It was descovered by KASAN. The Patch 1 is the V2 about
http://www.spinics.net/lists/alsa-devel/msg69487.html

Chanes in V2:
 - put an explicit error bail out(by Takashi iwai)

Patch1 was founded by connecting the following product.
http://www.lg.com/uk/lg-friends/lg-AFD-1200

I found that it only check if the return value from usb_string() is always
zero while modifying OOB KASAN message. So instead of making the
modifications to OOB to V2, I sent a patch series.

I am sorry to break the mail thread.

Thanks
jaejoong

Jaejoong Kim (3):
  ALSA: usb-audio: Fix out-of-bound error
  ALSA: usb-audio: Fix return value check for usb_string()
  ALSA: usb-audio: Add check return value for usb_string()

 sound/usb/mixer.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

-- 
2.7.4
