From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 5/6] ASoC: wm_adsp: Improve DSP error
	handling
Date: Wed, 6 Apr 2016 11:21:54 +0100
Message-ID: <1459938115-25456-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A0CE265041
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 12:21:52 +0200 (CEST)
In-Reply-To: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

If we encounter an error on the DSP side whilst user-space is
waiting on the poll we should call snd_compr_fragment_elapsed,
although data is not actually available we want to wake
user-space such that the error can be propagated out
quickly. Additionally some versions of the DSP firmware are
not super consistent about actually generating an IRQ if they
encounter an error, as such we will check the DSP error status
every time we run out of available data as well, to ensure we
catch it.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f70c609..3ac2e1f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2853,7 +2853,7 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 
 	ret = wm_adsp_buffer_get_error(buf);
 	if (ret < 0)
-		goto out;
+		goto out_notify; /* Wake poll to report error */
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
 				  &buf->irq_count);
@@ -2868,6 +2868,7 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		goto out;
 	}
 
+out_notify:
 	if (compr && compr->stream)
 		snd_compr_fragment_elapsed(compr->stream);
 
@@ -2928,6 +2929,10 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 		 * DSP to inform us once a whole fragment is available.
 		 */
 		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
+			ret = wm_adsp_buffer_get_error(buf);
+			if (ret < 0)
+				goto out;
+
 			ret = wm_adsp_buffer_reenable_irq(buf);
 			if (ret < 0) {
 				adsp_err(dsp,
-- 
2.1.4
