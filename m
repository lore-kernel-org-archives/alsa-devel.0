From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] hiface: Fix sample rate changes
Date: Mon, 28 Nov 2016 11:55:23 +0200
Message-ID: <d4797282-d15e-4548-5804-77ab974ae5b7@sonarnerd.net>
References: <ee24b066-41d2-ad24-8598-f15a26a743a8@sonarnerd.net>
 <CAOf5uw=YOqJQpLbLE7RhMVE=kzHxR6jhEvEAm8n4dWfPVFWPWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id A7707266D44
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 10:55:24 +0100 (CET)
In-Reply-To: <CAOf5uw=YOqJQpLbLE7RhMVE=kzHxR6jhEvEAm8n4dWfPVFWPWg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@ao2.it>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> Can you please sent it inline? Not having access at the hardware now
> but Antonio should have it

Sure! I have tested this with my hiFace...


	- Jussi


 From f4eec5602d86b5f938abed48a5725f59141d32cd Mon Sep 17 00:00:00 2001
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
@@ -445,6 +445,8 @@ static int hiface_pcm_prepare(struct 
snd_pcm_substream *alsa_sub)

  	mutex_lock(&rt->stream_mutex);

+	hiface_pcm_stream_stop(rt);
+
  	sub->dma_off = 0;
  	sub->period_off = 0;

-- 
2.7.4
