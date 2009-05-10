From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/3] speaker-test: allow frequency to be
	floating point
Date: Sat,  9 May 2009 19:27:05 -0500
Message-ID: <1241915227-12629-2-git-send-email-dpmcgee@gmail.com>
References: <1241915227-12629-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F8F61037ED
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 02:27:14 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1657960ywq.2
	for <alsa-devel@alsa-project.org>; Sat, 09 May 2009 17:27:13 -0700 (PDT)
In-Reply-To: <1241915227-12629-1-git-send-email-dpmcgee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dan McGee <dpmcgee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use atof() rather than atoi() to store the frequency- we were already using
a floating point value internally but did not let the user specify one from
the command line.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 speaker-test/speaker-test.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 63a7151..5e00ea4 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -76,7 +76,7 @@ static unsigned int       speaker     = 0;	            /* count of channels */
 static unsigned int       buffer_time = 0;	            /* ring buffer length in us */
 static unsigned int       period_time = 0;	            /* period time in us */
 static unsigned int       nperiods    = 4;                  /* number of periods */
-static double             freq        = 440;                /* sinusoidal wave frequency in Hz */
+static double             freq        = 440.0;              /* sinusoidal wave frequency in Hz */
 static int                test_type   = TEST_PINK_NOISE;    /* Test type. 1 = noise, 2 = sine wave */
 static pink_noise_t pink;
 static snd_pcm_uframes_t  buffer_size;
@@ -860,9 +860,9 @@ int main(int argc, char *argv[]) {
       channels = channels > 1024 ? 1024 : channels;
       break;
     case 'f':
-      freq = atoi(optarg);
-      freq = freq < 50 ? 50 : freq;
-      freq = freq > 5000 ? 5000 : freq;
+      freq = atof(optarg);
+      freq = freq < 50.0 ? 50.0 : freq;
+      freq = freq > 5000.0 ? 5000.0 : freq;
       break;
     case 'b':
       buffer_time = atoi(optarg);
-- 
1.6.2.4
