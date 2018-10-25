From: Eduardo Abinader <eduardoabinader@gmail.com>
Subject: [PATCH] alsa-utils: fix identation indentation on
	speaker-test.c
Date: Thu, 25 Oct 2018 14:04:59 +0200
Message-ID: <20181025120459.5905-1-eduardoabinader@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E86B26759E
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 14:05:09 +0200 (CEST)
Received: by mail-ed1-f41.google.com with SMTP id c15-v6so8217167eds.4
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 05:05:08 -0700 (PDT)
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
Cc: Eduardo Abinader <eduardoabinader@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
---
 speaker-test/speaker-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 773af0a..4aac30c 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -1207,7 +1207,7 @@ int main(int argc, char *argv[]) {
 
       gettimeofday(&tv1, NULL);
       for(chn = 0; chn < channels; chn++) {
-	int channel = get_speaker_channel(chn);
+        int channel = get_speaker_channel(chn);
         printf(" %d - %s\n", channel, get_channel_name(channel));
 
         err = write_loop(handle, channel, ((rate*3)/period_size), frames);
-- 
2.17.1
