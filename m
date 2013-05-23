From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH: TinyCompress 2/2] cplay: use get_alsa_rate to
	convert sample rate
Date: Thu, 23 May 2013 13:42:47 +0530
Message-ID: <1369296767-30136-2-git-send-email-vinod.koul@intel.com>
References: <1369296767-30136-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 920A3261ACD
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 10:49:31 +0200 (CEST)
In-Reply-To: <1369296767-30136-1-git-send-email-vinod.koul@intel.com>
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
 cplay.c |   48 +++++-------------------------------------------
 1 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/cplay.c b/cplay.c
index 673026e..10c5424 100644
--- a/cplay.c
+++ b/cplay.c
@@ -226,49 +226,11 @@ void play_samples(char *name, unsigned int card, unsigned int device,
 	codec.id = SND_AUDIOCODEC_MP3;
 	codec.ch_in = channels;
 	codec.ch_out = channels;
-	switch (rate) {
-	case 5512:
-		codec.sample_rate = SNDRV_PCM_RATE_5512;
-		break;
-	case 8000:
-		codec.sample_rate = SNDRV_PCM_RATE_8000;
-		break;
-	case 11025:
-		codec.sample_rate = SNDRV_PCM_RATE_11025;
-		break;
-	case 16000:
-		codec.sample_rate = SNDRV_PCM_RATE_16000;
-		break;
-	case 220500:
-		codec.sample_rate = SNDRV_PCM_RATE_22050;
-		break;
-	case 32000:
-		codec.sample_rate = SNDRV_PCM_RATE_32000;
-		break;
-	case 44100:
-		codec.sample_rate = SNDRV_PCM_RATE_44100;
-		break;
-	case 48000:
-		codec.sample_rate = SNDRV_PCM_RATE_48000;
-		break;
-	case 64000:
-		codec.sample_rate = SNDRV_PCM_RATE_64000;
-		break;
-	case 88200:
-		codec.sample_rate = SNDRV_PCM_RATE_88200;
-		break;
-	case 96000:
-		codec.sample_rate = SNDRV_PCM_RATE_96000;
-		break;
-	case 176400:
-		codec.sample_rate = SNDRV_PCM_RATE_176400;
-		break;
-	case 192000:
-		codec.sample_rate = SNDRV_PCM_RATE_192000;
-		break;
-	default:
-		fprintf(stderr, "unknown sample rate %d\n", rate);
-		goto FILE_EXIT;
+	codec.sample_rate = compress_get_alsa_rate(rate);
+	if (!codec.sample_rate) {
+		fprintf(stderr, "invalid sample rate %d\n", rate);
+		fclose(file);
+		exit(EXIT_FAILURE);
 	}
 	codec.bit_rate = bits;
 	codec.rate_control = 0;
-- 
1.7.0.4
