From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/3] Remove dead/commented out code
Date: Sat,  9 May 2009 19:27:07 -0500
Message-ID: <1241915227-12629-4-git-send-email-dpmcgee@gmail.com>
References: <1241915227-12629-1-git-send-email-dpmcgee@gmail.com>
	<1241915227-12629-2-git-send-email-dpmcgee@gmail.com>
	<1241915227-12629-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 520FD1037F7
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 02:27:18 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so1657639yxn.2
	for <alsa-devel@alsa-project.org>; Sat, 09 May 2009 17:27:18 -0700 (PDT)
In-Reply-To: <1241915227-12629-3-git-send-email-dpmcgee@gmail.com>
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

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 speaker-test/speaker-test.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 38e5462..d983a4f 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -142,17 +142,6 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
   float   *samp_f = (float*) frames;
 
   while (count-- > 0) {
-    //res = sin((phase * 2 * M_PI) / max_phase - M_PI) * 32767;
-    //res = sin((phase * 2 * M_PI) / max_phase - M_PI) * 32767;
-    //res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
-    //if (res > 0) res = 10000;
-    //if (res < 0) res = -10000;
-
-    /* printf("%e\n",res); */
-    //ires = res;
-    //ires = ((16 - (count & 0xf)) <<24);
-    //ires = 0;
-
     for(chn=0;chn<channels;chn++) {
       switch (format) {
       case SND_PCM_FORMAT_S8:
@@ -195,11 +184,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0.75 ; /* Don't use MAX volume */
           fres = res;
 	  *samp_f++ = fres;
-	  //*samp32++ = 0xF2345678;
-	//printf("res=%lf, ires=%d 0x%x, samp32=0x%x\n",res,ires, ires, samp32[-1]);
         } else {
-	  //*samp32++ = ires+0x10000;
-	  //*samp32++ = ires;
 	  *samp_f++ = 0.0;
         }
         break;
-- 
1.6.2.4
