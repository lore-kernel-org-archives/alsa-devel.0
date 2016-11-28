From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] hiface: Fix sample rate changes
Date: Mon, 28 Nov 2016 11:27:45 +0200
Message-ID: <ee24b066-41d2-ad24-8598-f15a26a743a8@sonarnerd.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------277DD9BBB14B895CFF97A878"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CBF1266937
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 10:27:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, michael@amarulasolutions.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------277DD9BBB14B895CFF97A878
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

When attempting to change sample rate for the interface after first 
set-play cycle, the change is not reflected to the hardware, while from 
user space everything seems to go fine.

This patch fixes the issue and the driver now behaves the same way as 
for example the USB Audio Class driver.



--------------277DD9BBB14B895CFF97A878
Content-Type: text/x-patch;
 name="0001-Fix-M2Tech-hiFace-driver-sampling-rate-change.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-M2Tech-hiFace-driver-sampling-rate-change.patch"

>From f4eec5602d86b5f938abed48a5725f59141d32cd Mon Sep 17 00:00:00 2001
From: Jussi Laako <jussi@sonarnerd.net>
Date: Mon, 28 Nov 2016 01:11:46 +0200
Subject: [PATCH] Fix M2Tech hiFace driver sampling rate change

Sampling rate changes after first set one are not reflected to the
hardware, while driver and ALSA think the rate has been changed.

Fix the problem by properly stopping the interface at the beginning of
prepare call, allowing new rate to be set to the hardware. This keeps
the hardware in sync with the driver.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/hiface/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 2c44139..33db205 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -445,6 +445,8 @@ static int hiface_pcm_prepare(struct snd_pcm_substream *alsa_sub)
 
 	mutex_lock(&rt->stream_mutex);
 
+	hiface_pcm_stream_stop(rt);
+
 	sub->dma_off = 0;
 	sub->period_off = 0;
 
-- 
2.7.4


--------------277DD9BBB14B895CFF97A878
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------277DD9BBB14B895CFF97A878--
