From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] alsa-lib: Remove usleep usage
Date: Sun,  1 Sep 2019 18:32:40 -0700
Message-ID: <20190902013240.16591-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0D4FF80306
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 03:32:44 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id b24so8058163pfp.1
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2019 18:32:43 -0700 (PDT)
Received: from localhost.localdomain (76-14-106-55.rk.wavecable.com.
 [76.14.106.55])
 by smtp.gmail.com with ESMTPSA id l123sm16584020pfl.9.2019.09.01.18.32.41
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2019 18:32:41 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

usleep was deprecated by POSIX 2008 and is unavailable without deprecated
APIs enabled in uClibc-ng.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 src/pcm/pcm_shm.c | 3 ++-
 src/ucm/main.c    | 3 ++-
 test/mixtest.c    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_shm.c b/src/pcm/pcm_shm.c
index 26a27a57..30a77cd4 100644
--- a/src/pcm/pcm_shm.c
+++ b/src/pcm/pcm_shm.c
@@ -485,12 +485,13 @@ static int snd_pcm_shm_drain(snd_pcm_t *pcm)
 	snd_pcm_shm_t *shm = pcm->private_data;
 	volatile snd_pcm_shm_ctrl_t *ctrl = shm->ctrl;
 	int err;
+	struct timespec req = { 0, 10 * 1000 * 1000 };
 	do {
 		ctrl->cmd = SNDRV_PCM_IOCTL_DRAIN;
 		err = snd_pcm_shm_action(pcm);
 		if (err != -EAGAIN)
 			break;
-		usleep(10000);
+		nanosleep(&req, NULL);
 	} while (1);
 	if (err < 0)
 		return err;
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 99b1cd08..0e5236cb 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -359,6 +359,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 {
 	struct list_head *pos;
 	struct sequence_element *s;
+	struct timespec sleep = { 0, s->data.sleep * 1000 };
 	char *cdev = NULL;
 	snd_ctl_t *ctl = NULL;
 	int err = 0;
@@ -440,7 +441,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 			}
 			break;
 		case SEQUENCE_ELEMENT_TYPE_SLEEP:
-			usleep(s->data.sleep);
+			nanosleep(&sleep, NULL);
 			break;
 		case SEQUENCE_ELEMENT_TYPE_EXEC:
 			err = system(s->data.exec);
diff --git a/test/mixtest.c b/test/mixtest.c
index 57ca5d53..f0940344 100644
--- a/test/mixtest.c
+++ b/test/mixtest.c
@@ -77,7 +77,7 @@ static double detect_cpu_clock()
 	rdtscll(tsc_begin);
 	clock_gettime(CLOCK_MONOTONIC, &tm_begin);
 
-	usleep(1000000);
+	sleep(1);
 
 	rdtscll(tsc_end);
 	clock_gettime(CLOCK_MONOTONIC, &tm_end);
-- 
2.17.1
