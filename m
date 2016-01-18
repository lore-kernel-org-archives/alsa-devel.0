From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] tinycompress: crec: make functions static
Date: Mon, 18 Jan 2016 22:00:03 +0530
Message-ID: <1453134603-25356-4-git-send-email-vinod.koul@intel.com>
References: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C89C32652C5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 17:26:32 +0100 (CET)
In-Reply-To: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse rightly complains some functions should be static so make them static

crec.c:113:26: warning: symbol 'blank_wave_header' was not declared. Should it be static?
crec.c:239:6: warning: symbol 'capture_samples' was not declared. Should it be static?

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 src/utils/crec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/utils/crec.c b/src/utils/crec.c
index 6e8166d8f77b..8d5b7b0b2c30 100644
--- a/src/utils/crec.c
+++ b/src/utils/crec.c
@@ -110,7 +110,7 @@ struct wave_header {
 	} __attribute__((__packed__)) data;
 } __attribute__((__packed__));
 
-const struct wave_header blank_wave_header = {
+static const struct wave_header blank_wave_header = {
 	.riff = {
 		.chunk = {
 			.desc = "RIFF",
@@ -236,7 +236,7 @@ static int finish_record(void)
 	return 0;
 }
 
-void capture_samples(char *name, unsigned int card, unsigned int device,
+static void capture_samples(char *name, unsigned int card, unsigned int device,
 		     unsigned long buffer_size, unsigned int frag,
 		     unsigned int length, unsigned int rate,
 		     unsigned int channels, unsigned int format)
-- 
1.9.1
