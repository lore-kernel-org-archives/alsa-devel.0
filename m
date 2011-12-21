From: linux@audioscience.com
Subject: [PATCH] ALSA: asihpi - fix pcm dma pointer tracking
Date: Thu, 22 Dec 2011 11:54:02 +1300
Message-ID: <1324508042-16082-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AAB7103BE4
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 23:54:30 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D2YSY9NQ00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 11:54:11 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Elapsed counter should only count data committed to snd_pcm_period_elapsed,
rather than all data available

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index e9de799..322ddfe 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -888,8 +888,8 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 							pd, xfer2));
 				}
 			}
-			ds->pcm_buf_host_rw_ofs = ds->pcm_buf_host_rw_ofs + xfercount;
-			ds->pcm_buf_elapsed_dma_ofs = pcm_buf_dma_ofs;
+			ds->pcm_buf_host_rw_ofs = += xfercount;
+			ds->pcm_buf_elapsed_dma_ofs += xfercount;
 			snd_pcm_period_elapsed(s);
 		}
 	}
-- 
1.7.0.4
