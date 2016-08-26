From: keqiao.zhang@intel.com
Subject: [PATCH 1/2] alsabat: fix alsabat -86 error
Date: Fri, 26 Aug 2016 23:37:54 +0800
Message-ID: <1472225875-18081-2-git-send-email-keqiao.zhang@intel.com>
References: <1472225875-18081-1-git-send-email-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C12C1266168
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 09:59:10 +0200 (CEST)
In-Reply-To: <1472225875-18081-1-git-send-email-keqiao.zhang@intel.com>
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
Cc: keqiao.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Keqiao, Zhang" <keqiao.zhang@intel.com>

alsabat reports -86 error when system suspend and resume. Check the
return value of read_to_pcm() and write_to_pcm(), when -x8 err is
detected, do resume and wait for read/write to pcm to complete.

Write PCM device error: Streams pipe error(-86)
Read PCM device error: Streams pipe error(-86)
*** Error in alsabat: double free or corruption (out): 0x00007fb438001810 ***

Signed-off-by: Keqiao, Zhang <keqiao.zhang@intel.com>
---
 bat/alsa.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bat/alsa.c b/bat/alsa.c
index cef1734..7613f44 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -319,6 +319,11 @@ static int write_to_pcm(const struct pcm_container *sndpcm,
 			if (bat->roundtriplatency)
 				bat->latency.xrun_error = true;
 			snd_pcm_prepare(sndpcm->handle);
+		} else if (err == -ESTRPIPE) {
+			while ((err = snd_pcm_resume(sndpcm->handle)) == -EAGAIN)
+				sleep(1);  /* wait until resume flag is released */
+			if (err < 0)
+				snd_pcm_prepare(sndpcm->handle);
 		} else if (err < 0) {
 			fprintf(bat->err, _("Write PCM device error: %s(%d)\n"),
 					snd_strerror(err), err);
@@ -518,6 +523,11 @@ static int read_from_pcm(struct pcm_container *sndpcm,
 					snd_strerror(err), err);
 			if (bat->roundtriplatency)
 				bat->latency.xrun_error = true;
+		} else if (err == -ESTRPIPE) {
+			while ((err = snd_pcm_resume(sndpcm->handle)) == -EAGAIN)
+				sleep(1);  /* wait until resume flag is released */
+			if (err < 0)
+				snd_pcm_prepare(sndpcm->handle);
 		} else if (err < 0) {
 			fprintf(bat->err, _("Read PCM device error: %s(%d)\n"),
 					snd_strerror(err), err);
-- 
2.5.0
