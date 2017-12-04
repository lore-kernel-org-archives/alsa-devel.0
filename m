From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH V2 0/2] ALSA: usb-audio: fix OOB and return value check
Date: Mon,  4 Dec 2017 15:31:47 +0900
Message-ID: <1512369109-23253-1-git-send-email-climbbb.kim@gmail.com>
References: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, stable <stable@vger.kernel.org>, alsa-devel@alsa-project.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series fixes the out-of-bound error caused by the return value
of usb_string(). It was descovered by KASAN.

KASAN OOB warning meesage was founded by connecting the following product.
http://www.lg.com/uk/lg-friends/lg-AFD-1200

Changes in v2:
 - Changes return value check for second patch (by Takashi Iwai)
 - In case of failure case, return 0 not negative value (by Takashi Iwai)
 - Put an explicit error and bail out (by Takashi Iwai)

Thanks
jaejoong

Jaejoong Kim (2):
  ALSA: usb-audio: Fix out-of-bound error
  ALSA: usb-audio: Add check return value for usb_string()

 sound/usb/mixer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.7.4
