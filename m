From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH] ALSA: sound, core, pcm_lib: fix xrun_log
Date: Wed, 18 May 2011 23:52:38 -0400
Message-ID: <1305777158-21361-1-git-send-email-bengardiner@nanometrics.ca>
References: <20110519111557.f147fc1e.sfr@canb.auug.org.au>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110519111557.f147fc1e.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Takashi Iwai <tiwai@suse.de>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The xrun_log function was augmented with the in_interrupt parameter whereas the
empty macro definition used when xrun logging is disabled was not.

Add a third parameter to the empty macro definition so as to not cause compiler
errors when xrun logging (CONFIG_SND_PCM_XRUN_DEBUG) is disabled.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

---
This fixes the build error caused by ec08b14483de ("ALSA: sound, core, pcm_lib:
xrun_log: log also in_interrupt") -- which was my patch. Sorry for the breakage.

---
 sound/core/pcm_lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index c8c8091..abfeff16 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -266,7 +266,7 @@ static void xrun_log_show(struct snd_pcm_substream *substream)
 #else /* ! CONFIG_SND_PCM_XRUN_DEBUG */
 
 #define hw_ptr_error(substream, fmt, args...) do { } while (0)
-#define xrun_log(substream, pos)	do { } while (0)
+#define xrun_log(substream, pos, in_interrupt)	do { } while (0)
 #define xrun_log_show(substream)	do { } while (0)
 
 #endif
-- 
1.7.4.1
