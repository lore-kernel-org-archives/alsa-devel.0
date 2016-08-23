From: Luis Henriques <luis.henriques@canonical.com>
Subject: ALSA: compress: Memset timestamp structure to zero.
Date: Tue, 23 Aug 2016 14:40:37 +0100
Message-ID: <1471959637-18163-2-git-send-email-luis.henriques@canonical.com>
References: <1471959637-18163-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471959637-18163-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishnankutty Kolathappilly <kkolat@codeaurora.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Krishnankutty Kolathappilly <kkolat@codeaurora.org>

snd_compr_tstamp is initialized using aggregate initialization
that does not zero out the padded bytes. Initialize timestamp
structure to zero using memset to avoid this.

CRs-Fixed: 568717
Change-Id: I7a7d188705161f06201f1a1f2945bb6acd633d5d
Signed-off-by: Krishnankutty Kolathappilly <kkolat@codeaurora.org>
---
 sound/core/compress_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 2c498488af6c..84aaa07ca853 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -659,9 +659,10 @@ snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
 static inline int
 snd_compr_tstamp(struct snd_compr_stream *stream, unsigned long arg)
 {
-	struct snd_compr_tstamp tstamp = {0};
+	struct snd_compr_tstamp tstamp;
 	int ret;
 
+	memset(&tstamp, 0, sizeof(tstamp));
 	ret = snd_compr_update_tstamp(stream, &tstamp);
 	if (ret == 0)
 		ret = copy_to_user((struct snd_compr_tstamp __user *)arg,
