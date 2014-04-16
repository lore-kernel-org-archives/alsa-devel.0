From: Tim Gardner <tim.gardner@canonical.com>
Subject: [PATCH v2 linux-next] ALSA: pcm: 'BUG:' message unnecessarily triggers kerneloops
Date: Wed, 16 Apr 2014 08:18:35 -0600
Message-ID: <1397657915-5036-1-git-send-email-tim.gardner@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, JongHo Kim <furmuwon@gmail.com>
List-Id: alsa-devel@alsa-project.org

BugLink: http://bugs.launchpad.net/bugs/1305480

The kerneloops-daemon scans dmesg for common crash signatures, among
which is 'BUG:'. The message emitted by the PCM library is really a
warning, so the most expedient thing to do seems to be to change the
string.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: JongHo Kim <furmuwon@gmail.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

v2: Changed string preface from "OVER RUN" to "XRUN". As Takashi pointed out,
'Use a term "XRUN", as it's not always an overrun.'

 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ce83def..9acc77e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -345,7 +345,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 			snd_pcm_debug_name(substream, name, sizeof(name));
 			xrun_log_show(substream);
 			pcm_err(substream->pcm,
-				"BUG: %s, pos = %ld, buffer size = %ld, period size = %ld\n",
+				"XRUN: %s, pos = %ld, buffer size = %ld, period size = %ld\n",
 				name, pos, runtime->buffer_size,
 				runtime->period_size);
 		}
-- 
1.9.1
