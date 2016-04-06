From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Improve DSP error handling" to
	the asoc tree
Date: Wed, 06 Apr 2016 10:19:37 -0700
Message-ID: <E1anr7B-0003Lg-Is@finisterre>
References: <1459938115-25456-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5289626070F
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 19:19:52 +0200 (CEST)
In-Reply-To: <1459938115-25456-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Improve DSP error handling

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5847609edb3c80be07e897e449a9bb579a0fe9d8 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 6 Apr 2016 11:21:54 +0100
Subject: [PATCH] ASoC: wm_adsp: Improve DSP error handling

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f70c60914042..3ac2e1f06ad3 100644
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
2.8.0.rc3
