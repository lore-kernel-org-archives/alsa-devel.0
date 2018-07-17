From: Rob Duncan <rduncan@tesla.com>
Subject: Re: Bug in snd_pcm_ioplug_avail_update()?
Date: Tue, 17 Jul 2018 08:46:35 -0700
Message-ID: <dw77emr2k1eug4.fsf@tesla.com>
References: <dw77em7elyg52i.fsf@tesla.com> <s5hd0vnkove.wl-tiwai@suse.de>
 <dw77emtvoyenzz.fsf@tesla.com> <s5ho9f6jvwd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0019bd01.pphosted.com (mx0b-0019bd01.pphosted.com
 [148.163.155.1])
 by alsa0.perex.cz (Postfix) with ESMTP id C2D182677D1
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 17:46:38 +0200 (CEST)
In-Reply-To: <s5ho9f6jvwd.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

At 22:04 on Mon, Jul 16 2018, Takashi wrote:

> The code change is similar as what I had in my mind, but...

Version 2!

Thanks,

Rob.

>From 8890fbf81c27ed5fded12349b274c7c008c53249 Mon Sep 17 00:00:00 2001
From: Rob Duncan <rduncan@teslamotors.com>
Date: Mon, 16 Jul 2018 16:35:23 -0700
Subject: [PATCH] pcm: ioplug: Transfer all available data

The snd_pcm_mmap_begin() call returns the amount of contiguous data,
which is less than the total available if it wraps around the buffer
boundary.

If we don't handle this split we leave stale data in the buffer that
should have been overwritten, as well as unread data in the io_plugin
that gets transferred on a subsequent call at the wrong offset.

Signed-off-by: Rob Duncan <rduncan@teslamotors.com>
---
 src/pcm/pcm_ioplug.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 6d52c27b..881a1a85 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -716,6 +716,8 @@ static snd_pcm_sframes_t snd_pcm_ioplug_avail_update(snd_pcm_t *pcm)
 	snd_pcm_ioplug_hw_ptr_update(pcm);
 	if (io->data->state == SND_PCM_STATE_XRUN)
 		return -EPIPE;
+
+	avail = snd_pcm_mmap_avail(pcm);
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE &&
 	    pcm->access != SND_PCM_ACCESS_RW_INTERLEAVED &&
 	    pcm->access != SND_PCM_ACCESS_RW_NONINTERLEAVED) {
@@ -728,9 +730,19 @@ static snd_pcm_sframes_t snd_pcm_ioplug_avail_update(snd_pcm_t *pcm)
 			result = io->data->callback->transfer(io->data, areas, offset, size);
 			if (result < 0)
 				return result;
+
+			/* If the available data doesn't fit in the
+			   contiguous area at the end of the mmap we
+			   must transfer the remaining data to the
+			   beginning of the mmap. */
+			if (size < avail) {
+				result = io->data->callback->transfer(io->data, areas,
+								      0, avail - size);
+				if (result < 0)
+					return result;
+			}
 		}
 	}
-	avail = snd_pcm_mmap_avail(pcm);
 	if (avail > io->avail_max)
 		io->avail_max = avail;
 	return (snd_pcm_sframes_t)avail;
-- 
2.15.1
