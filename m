From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/12] ALSA: msnd: Fix the default sample sizes
Date: Wed, 25 Jul 2018 23:00:48 +0200
Message-ID: <20180725210057.18017-4-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 54D8B26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:04 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7C863B067
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The default sample sizes set by msnd driver are bogus; it sets ALSA
PCM format, not the actual bit width.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/msnd/msnd_pinnacle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 642609f7eda9..7e3f52c8a6c6 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -82,10 +82,10 @@
 
 static void set_default_audio_parameters(struct snd_msnd *chip)
 {
-	chip->play_sample_size = DEFSAMPLESIZE;
+	chip->play_sample_size = snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->play_sample_rate = DEFSAMPLERATE;
 	chip->play_channels = DEFCHANNELS;
-	chip->capture_sample_size = DEFSAMPLESIZE;
+	chip->capture_sample_size = snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->capture_sample_rate = DEFSAMPLERATE;
 	chip->capture_channels = DEFCHANNELS;
 }
-- 
2.18.0
