From: ajay khandelwal <ajay.lforum@gmail.com>
Subject: Error from Alsa Lib Test/pcm.c
Date: Tue, 29 Nov 2011 11:40:07 +0530
Message-ID: <CAL7V=_E-hK8KJQhLwkrCKkVh5dKyrZaZ7LWyqK4GAUVRSC2j0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 53E4324402
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 07:10:08 +0100 (CET)
Received: by vbbfp1 with SMTP id fp1so3635262vbb.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:10:07 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi All,
 I was validating pause/resume of my alsa driver for spdif. After few loop
of pause/resume snd_pcm_writei routine returns error.
(error code -77, No such device or address).


For testing I'm using pcm.c in test/pcm.c. I modified pcm.c under name
pcm_pause.c to support pause and resume.
I'm attaching my patch for changes below.

--- pcm.c 2011-08-13 14:35:15.384157182 +0530
+++ pcm_pause.c 2011-11-30 14:20:26.990180303 +0530
@@ -779,7 +779,7 @@
   {NULL, 0, NULL, 0},
  };
  snd_pcm_t *handle;
- int err, morehelp;
+ int err, morehelp,pid;
  snd_pcm_hw_params_t *hwparams;
  snd_pcm_sw_params_t *swparams;
  int method = 0;
@@ -912,14 +912,40 @@
   areas[chn].first = chn * snd_pcm_format_physical_width(format);
   areas[chn].step = channels * snd_pcm_format_physical_width(format);
  }
-
- err = transfer_methods[method].transfer_loop(handle, samples, areas);
- if (err < 0)
-  printf("Transfer failed: %s\n", snd_strerror(err));
-
- free(areas);
- free(samples);
- snd_pcm_close(handle);
- return 0;
+
+ pid = fork();
+ if(pid > 0){
+  err = transfer_methods[method].transfer_loop(handle, samples, areas);
+  if (err < 0)
+   printf("Transfer failed: %s\n", snd_strerror(err));
+
+  free(areas);
+  free(samples);
+  snd_pcm_close(handle);
+  return 0;
+ }
+
+ if(pid == 0)
+ {
+  int pause_count = 0;
+  int resume_count = 0;
+  while(1)
+  {
+   sleep(1);
+   if((err = snd_pcm_pause(handle,1)) < 0)
+   {
+    printf("\nPause Failed: %s", snd_strerror(err));
+    exit(EXIT_FAILURE);
+   }
+   printf("\nPAUSED Audio: Count %d\n", ++pause_count);
+   sleep(1);
+   if((err = snd_pcm_pause(handle,0)) < 0)\
+   {
+    printf("\nResume Failed: %s", snd_strerror(err));
+    exit(EXIT_FAILURE);
+   }
+   printf("\nRESUME Audio: Count %d\n", ++resume_count);
+  }
+ }
 }
