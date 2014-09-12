From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] speaker-test: Fix dropped samples at the end
	of test
Date: Fri, 12 Sep 2014 15:14:28 +0300
Message-ID: <1410524068-15982-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CB44C2657C0
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 14:14:52 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, guillaume-florianx.vidal@intel.com
List-Id: alsa-devel@alsa-project.org

Commit 6d1673526b0f ("Avoid unnecessary drain/restart in speaker-test")
drains only when buffer is bigger than audio sample. This has a drawback
that up to buffer size amount of data may not be heard at the end of audio
sample.

This was noted with "speaker-test -c 2 -t wav -s 2" test on a
hardware that has a buffer size of 24000 samples and 48 kHz sample rate.
Instead of playing "front right" it played something like "front ra".

Reverse buffer size vs sample size test wouldn't work either since then
samples smaller than buffer are dropped.

Fix this by removing buffer_size tests from write_loop() and do
drain/restart always when not aborting.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Vidal, Guillaume-florianX <guillaume-florianx.vidal@intel.com>
---
This was originally noted on Baytrail ADSP hw (default buffer size 24000)
but can be heard also on Intel HDA (default buffer size 8192) when audio
sample is small enough but bigger than buffer. For instance 100 ms sample
finishes too shortly (buffer size 8192, sample size 9600) but 50 ms plays
ok (buffer size 8192, sample size 4800).

I guess some optimization can be done for snd_pcm_prepare() when not looping
but that's not necessary for this fix.
---
 speaker-test/speaker-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 61396f296c65..836fd26d35b1 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -942,7 +942,7 @@ static int write_loop(snd_pcm_t *handle, int channel, int periods, uint8_t *fram
 			      snd_pcm_bytes_to_frames(handle, err * channels))) < 0)
 	break;
     }
-    if (buffer_size > n && !in_aborting) {
+    if (!in_aborting) {
       snd_pcm_drain(handle);
       snd_pcm_prepare(handle);
     }
@@ -964,7 +964,7 @@ static int write_loop(snd_pcm_t *handle, int channel, int periods, uint8_t *fram
     if ((err = write_buffer(handle, frames, period_size)) < 0)
       return err;
   }
-  if (buffer_size > n * period_size && !in_aborting) {
+  if (!in_aborting) {
     snd_pcm_drain(handle);
     snd_pcm_prepare(handle);
   }
-- 
2.1.0
