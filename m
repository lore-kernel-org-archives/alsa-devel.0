From: "Gilliland, Scott M" <scott.gilliland@gatech.edu>
Subject: [PATCH] Fix bug in arecord --max-file-time where the
 file size could overflow 32 bits
Date: Fri, 23 Jun 2017 18:35:03 +0000
Message-ID: <CY4PR07MB3544F3467606CB0401C3F0918DD80@CY4PR07MB3544.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0125.outbound.protection.outlook.com [104.47.34.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CA5C266AE2
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 20:35:06 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Scott Gilliland <scott.gilliland@gatech.edu>

Fix bug in arecord --max-file-time where the file size could overflow 32 bits

Signed-off-by: Scott Gilliland <scott.gilliland@gatech.edu>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index f793c82..00af662 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -3027,7 +3027,7 @@ static void capture(char *orig_name)
        if (count == 0)
                count = LLONG_MAX;
        /* compute the number of bytes per file */
-       max_file_size = max_file_time *
+       max_file_size = (long long) max_file_time *
                snd_pcm_format_size(hwparams.format,
                                    hwparams.rate * hwparams.channels);
        /* WAVE-file should be even (I'm not sure), but wasting one byte
-- 
2.11.0
