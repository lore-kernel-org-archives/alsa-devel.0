From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm_adsp: Improve DSP error handling
Date: Thu, 10 Mar 2016 10:44:54 +0000
Message-ID: <1457606694-10985-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEAF2612D0
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 11:44:56 +0100 (CET)
In-Reply-To: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

If we encounter an error on the DSP side whilst user-space is waiting on
the poll we should call snd_compr_fragment_elapsed, although data is
not actually available we want to wake user-space such that the error
can be propagated out quickly. Additionally some versions of the DSP
firmware are not super consistent about actually generating an IRQ if
they encounter an error, as such we will check the DSP error status
every time we run out of available data as well, to ensure we catch it.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f28c244..3ee1c72 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2861,10 +2861,10 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		goto out;
 	}
 
+out:
 	if (compr && compr->stream)
 		snd_compr_fragment_elapsed(compr->stream);
 
-out:
 	mutex_unlock(&dsp->pwr_lock);
 
 	return ret;
@@ -2926,6 +2926,10 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 					 ret);
 				goto out;
 			}
+
+			ret = wm_adsp_buffer_check_error(buf);
+			if (ret < 0)
+				goto out;
 		}
 	}
 
-- 
2.1.4
