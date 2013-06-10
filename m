From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-utils)] speaker-test: Fix wrong wave file
	played back in chmap setup
Date: Mon, 10 Jun 2013 16:42:48 +0200
Message-ID: <1370875368-2614-2-git-send-email-david.henningsson@canonical.com>
References: <1370875368-2614-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 11D7E261688
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:42:50 +0200 (CEST)
In-Reply-To: <1370875368-2614-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When explicitly specifying channel maps, we need to use that when
loading wave files so the correct file is played back.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 speaker-test/speaker-test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index a41b5bd..a04043a 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -771,8 +771,16 @@ static int setup_wav_file(int chn)
 
   if (given_test_wav_file)
     return check_wav_file(chn, given_test_wav_file);
-  else
-    return check_wav_file(chn, wavs[chn]);
+
+#ifdef CONFIG_SUPPORT_CHMAP
+  if (channel_map_set && chn < channel_map->channels) {
+    int channel = channel_map->pos[chn] - SND_CHMAP_FL;
+    if (channel >= 0 && channel < MAX_CHANNELS)
+      return check_wav_file(chn, wavs[channel]);
+  }    
+#endif
+
+  return check_wav_file(chn, wavs[chn]);
 }
 
 static int read_wav(uint16_t *buf, int channel, int offset, int bufsize)
@@ -1179,7 +1187,7 @@ int main(int argc, char *argv[]) {
 
     if (test_type == TEST_WAV) {
       for (chn = 0; chn < channels; chn++) {
-	if (setup_wav_file(chn) < 0)
+	if (setup_wav_file(get_speaker_channel(chn)) < 0)
 	  prg_exit(EXIT_FAILURE);
       }
     }
-- 
1.8.1.2
