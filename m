From: Alan Young <Alan.Young@IEE.org>
Subject: [PATCH] pcm_rate: Do not discard slave reported delay
 in status result.
Date: Thu, 17 Nov 2016 15:24:23 +0000
Message-ID: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------6DCEE2E28F1945DF61572FFD"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 80141267569
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 16:24:25 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id g23so317606881wme.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 07:24:25 -0800 (PST)
Received: from [192.168.11.11] (178.55.208.46.dyn.plus.net. [46.208.55.178])
 by smtp.googlemail.com with ESMTPSA id r138sm16156423wme.9.2016.11.17.07.24.23
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Nov 2016 07:24:24 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------6DCEE2E28F1945DF61572FFD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Similar to recent dshare patch.


--------------6DCEE2E28F1945DF61572FFD
Content-Type: text/x-patch;
 name="0001-pcm_rate-Do-not-discard-slave-reported-delay-in-stat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-pcm_rate-Do-not-discard-slave-reported-delay-in-stat.pa";
 filename*1="tch"

>From da687e77261f5cdd3c4b373156fb68ed83d98a26 Mon Sep 17 00:00:00 2001
From: Alan Young <consult.awy@gmail.com>
Date: Tue, 14 Jun 2016 10:15:01 +0100
Subject: [PATCH] pcm_rate: Do not discard slave reported delay in status
 result.

snd_pcm_rate_status() gets the underlying status from the slave PCM.
This may contain a delay value that includes elements such as codec and
other transfer delays. Use this as the base for the returned delay
value, adjusted for any frames buffered locally (within the rate
plugin).

Also update snd_pcm_rate_delay() similarly.
---
 src/pcm/pcm_rate.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 6184def..15383ae 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -559,10 +559,9 @@ snd_pcm_rate_read_areas1(snd_pcm_t *pcm,
 		   pcm->channels, rate);
 }
 
-static inline void snd_pcm_rate_sync_hwptr(snd_pcm_t *pcm)
+static inline void snd_pcm_rate_sync_hwptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
-	snd_pcm_uframes_t slave_hw_ptr = *rate->gen.slave->hw.ptr;
 
 	if (pcm->stream != SND_PCM_STREAM_PLAYBACK)
 		return;
@@ -576,6 +575,12 @@ static inline void snd_pcm_rate_sync_hwptr(snd_pcm_t *pcm)
 	rate->hw_ptr %= pcm->boundary;
 }
 
+static inline void snd_pcm_rate_sync_hwptr(snd_pcm_t *pcm)
+{
+	snd_pcm_rate_t *rate = pcm->private_data;
+	snd_pcm_rate_sync_hwptr0(pcm, *rate->gen.slave->hw.ptr);
+}
+
 static int snd_pcm_rate_hwsync(snd_pcm_t *pcm)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
@@ -586,10 +591,37 @@ static int snd_pcm_rate_hwsync(snd_pcm_t *pcm)
 	return 0;
 }
 
+static snd_pcm_uframes_t snd_pcm_rate_playback_internal_delay(snd_pcm_t *pcm)
+{
+	snd_pcm_rate_t *rate = pcm->private_data;
+
+	if (rate->appl_ptr < rate->last_commit_ptr) {
+		return rate->appl_ptr - rate->last_commit_ptr + pcm->boundary;
+	} else {
+		return rate->appl_ptr - rate->last_commit_ptr;
+	}
+}
+
 static int snd_pcm_rate_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
+	snd_pcm_rate_t *rate = pcm->private_data;
+	snd_pcm_sframes_t slave_delay;
+	int err;
+
 	snd_pcm_rate_hwsync(pcm);
-	*delayp = snd_pcm_mmap_hw_avail(pcm);
+
+	err = snd_pcm_delay(rate->gen.slave, &slave_delay);
+	if (err < 0) {
+		return err;
+	}
+
+	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
+		*delayp = rate->ops.input_frames(rate->obj, slave_delay)
+				+ snd_pcm_rate_playback_internal_delay(pcm);
+	} else {
+		*delayp = rate->ops.output_frames(rate->obj, slave_delay)
+				+ snd_pcm_mmap_capture_hw_avail(pcm);
+	}
 	return 0;
 }
 
@@ -1083,15 +1115,17 @@ static int snd_pcm_rate_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 			status->state = SND_PCM_STATE_RUNNING;
 		status->trigger_tstamp = rate->trigger_tstamp;
 	}
-	snd_pcm_rate_sync_hwptr(pcm);
+	snd_pcm_rate_sync_hwptr0(rate, status->hw_ptr);
 	status->appl_ptr = *pcm->appl.ptr;
 	status->hw_ptr = *pcm->hw.ptr;
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
-		status->delay = snd_pcm_mmap_playback_hw_avail(pcm);
+		status->delay = rate->ops.input_frames(rate->obj, status->delay)
+					+ snd_pcm_rate_playback_internal_delay(pcm);
 		status->avail = snd_pcm_mmap_playback_avail(pcm);
 		status->avail_max = rate->ops.input_frames(rate->obj, status->avail_max);
 	} else {
-		status->delay = snd_pcm_mmap_capture_hw_avail(pcm);
+		status->delay = rate->ops.output_frames(rate->obj, status->delay)
+					+ snd_pcm_mmap_capture_hw_avail(pcm);
 		status->avail = snd_pcm_mmap_capture_avail(pcm);
 		status->avail_max = rate->ops.output_frames(rate->obj, status->avail_max);
 	}
-- 
2.5.5


--------------6DCEE2E28F1945DF61572FFD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------6DCEE2E28F1945DF61572FFD--
