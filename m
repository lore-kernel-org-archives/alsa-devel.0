From: Julian Scheel <julian@jusst.de>
Subject: [PATCH v2 2/2] speaker-test: Remove unused variable
Date: Wed, 23 May 2018 15:42:21 +0200
Message-ID: <20180523134221.27260-2-julian@jusst.de>
References: <20180523134221.27260-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 535DB2671EE
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:42:32 +0200 (CEST)
In-Reply-To: <20180523134221.27260-1-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 speaker-test/speaker-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 4804bcf..0cdecb3 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -300,7 +300,6 @@ static void do_generate(uint8_t *frames, int channel, int count,
 {
   value_t res;
   int    chn;
-  int32_t  ires;
   int8_t *samp8 = (int8_t*) frames;
   int16_t *samp16 = (int16_t*) frames;
   int32_t *samp32 = (int32_t*) frames;
-- 
2.17.0
