From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 10/12] pcm: hw: add a helper function
	to issue avail_min without sub-effects
Date: Fri, 30 Jun 2017 08:58:26 +0900
Message-ID: <20170629235828.18076-11-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id AC98D2673FF
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:35 +0200 (CEST)
In-Reply-To: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At present, applications can change avail_min parameter of PCM substream
by two ways; via mapped control data, and by executing ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR. The former is available in a case that the
applications map the data successfully.

When utilizing alsa-lib API, the above is done by a call of
'snd_pcm_sw_params()' to hw PCM plugin. In current implementation, this
call has an sub-effect to issue appl_ptr unexpectedly.

This commit adds a helper function to issue avail_min without the
sub-effect.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index aacfa669..c8fef64d 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -151,6 +151,15 @@ static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
+static int issue_avail_min(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_control_fallbacked)
+		return 0;
+
+	/* Avoid unexpected change of applptr in kernel space. */
+	return sync_ptr1(hw, SNDRV_PCM_SYNC_PTR_APPL);
+}
+
 static int issue_applptr(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_control_fallbacked)
@@ -492,7 +501,7 @@ static int snd_pcm_hw_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params)
 	    params->silence_size == pcm->silence_size &&
 	    old_period_event == hw->period_event) {
 		hw->mmap_control->avail_min = params->avail_min;
-		return sync_ptr(hw, 0);
+		return issue_avail_min(hw);
 	}
 	if (params->tstamp_type == SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW &&
 	    hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 12)) {
-- 
2.11.0
