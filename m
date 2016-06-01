From: han.lu@intel.com
Subject: [PATCH 1/1] alsabat: fix a possible memory leak
Date: Wed,  1 Jun 2016 16:54:28 +0800
Message-ID: <1464771268-16096-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5893826520A
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 10:55:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Fix a possible memory leak in generate_sine_wave(). Memory free was
ignored when the function return an error.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/signal.c b/bat/signal.c
index a47ba97..61d2824 100644
--- a/bat/signal.c
+++ b/bat/signal.c
@@ -168,16 +168,17 @@ int generate_sine_wave(struct bat *bat, int frames, void *buf)
 	/* reorder samples to interleaved mode */
 	err = reorder(bat, sinus_f, frames);
 	if (err != 0)
-		return err;
+		goto exit;
 
 	/* adjust amplitude and offset of waveform */
 	err = adjust_waveform(bat, sinus_f, frames);
 	if (err != 0)
-		return err;
+		goto exit;
 
 	bat->convert_float_to_sample(sinus_f, buf, frames, bat->channels);
 
+exit:
 	free(sinus_f);
 
-	return 0;
+	return err;
 }
-- 
2.5.0
