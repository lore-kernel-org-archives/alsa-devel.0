From: Marcin Pietraszko <marcin.pietraszko@linux.intel.com>
Subject: [PATCH 1/1] ASoC: topology: Fix variable overflow in
	split_format
Date: Mon, 26 Aug 2019 13:51:41 +0200
Message-ID: <1566820301-18671-1-git-send-email-marcin.pietraszko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 742A1F801ED
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 12:49:41 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org, Marcin Pietraszko <marcin.pietraszko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The 1 which was 32-bit long, when left-shifted by more than 31 caused
an overflow, which resulted in some of the formats being not supported.

Signed-off-by: Marcin Pietraszko <marcin.pietraszko@linux.intel.com>
---
 src/topology/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 5f586dc..00a35b9 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -321,7 +321,7 @@ static int split_format(struct snd_soc_tplg_stream_caps *caps, char *str)
 			return -EINVAL;
 		}
 
-		caps->formats |= 1 << format;
+		caps->formats |= 1ull << format;
 		s = strtok(NULL, ", ");
 		i++;
 	}
-- 
2.7.4
