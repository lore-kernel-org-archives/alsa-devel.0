From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] tinycompress: cplay: use the numeric
	sample rate
Date: Mon, 16 Dec 2013 20:44:59 +0530
Message-ID: <1387206900-9441-3-git-send-email-vinod.koul@intel.com>
References: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 659FB261687
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 17:14:20 +0100 (CET)
In-Reply-To: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 cplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cplay.c b/cplay.c
index 10c5424..c46577a 100644
--- a/cplay.c
+++ b/cplay.c
@@ -226,7 +226,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	codec.id = SND_AUDIOCODEC_MP3;
 	codec.ch_in = channels;
 	codec.ch_out = channels;
-	codec.sample_rate = compress_get_alsa_rate(rate);
+	codec.sample_rate = rate;
 	if (!codec.sample_rate) {
 		fprintf(stderr, "invalid sample rate %d\n", rate);
 		fclose(file);
-- 
1.7.0.4
