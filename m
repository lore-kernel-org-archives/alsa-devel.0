From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 2/2] ALSA: compress: Use memdup_user() rather than
 duplicating its implementation
Date: Mon, 22 Aug 2016 10:40:56 +0200
Message-ID: <85977ca3-562e-0a49-0189-53e0ebcdde0c@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <7233eb00-a941-4935-dce2-7cb907272d41@users.sourceforge.net>
 <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
 <1471809094.3746.17.camel@perches.com>
 <14b1efe1-3c1c-4c36-bfc2-19947c190412@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14b1efe1-3c1c-4c36-bfc2-19947c190412@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 22 Aug 2016 10:12:37 +0200

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/compress_offload.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a10d139..786989b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -554,13 +554,9 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 	 * we should allow parameter change only when stream has been
 	 * opened not in other cases
 	 */
-	params = kmalloc(sizeof(*params), GFP_KERNEL);
-	if (!params)
-		return -ENOMEM;
-	if (copy_from_user(params, (void __user *)arg, sizeof(*params))) {
-		retval = -EFAULT;
-		goto out;
-	}
+	params = memdup_user((void __user *)arg, sizeof(*params));
+	if (IS_ERR(params))
+		return PTR_ERR(params);
 
 	retval = snd_compress_check_input(params);
 	if (retval)
-- 
2.9.3
