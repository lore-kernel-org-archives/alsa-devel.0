From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: dapm: Add a dummy snd_pcm_runtime to avoid NULL pointer access
Date: Tue, 26 Jul 2016 12:28:40 -0700
Message-ID: <1469561320-31853-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The SND_SOC_DAPM_PRE_PMU case would call startup()/hw_params() that
might access substream->runtime through other functions.

For example:

Unable to handle kernel NULL pointer dereference at virtual address
[....]
PC is at snd_pcm_hw_rule_add+0x24/0x1b0
LR is at snd_pcm_hw_constraint_list+0x20/0x28
[....]
Process arecord (pid: 424, stack limit = 0xffffffc1ecaf0020)
Call trace:
[<ffffffc00086be68>] snd_pcm_hw_rule_add+0x24/0x1b0
[<ffffffc00086c014>] snd_pcm_hw_constraint_list+0x20/0x28
[<ffffffc0008b47a4>] cs53l30_pcm_startup+0x24/0x30
[<ffffffc0008a6260>] snd_soc_dai_link_event+0x290/0x354
[<ffffffc0008a7528>] dapm_seq_check_event.isra.31+0x134/0x2c8
[<ffffffc0008a7768>] dapm_seq_run_coalesced+0x94/0x1c8
[<ffffffc0008a7940>] dapm_seq_run+0xa4/0x404
[<ffffffc0008a8bac>] dapm_power_widgets+0x524/0x984
[<ffffffc0008ab1c4>] snd_soc_dapm_stream_event+0x8c/0xa8
[<ffffffc0008ac7f4>] soc_pcm_prepare+0x10c/0x1ec
[<ffffffc000865b9c>] snd_pcm_do_prepare+0x1c/0x38
[<ffffffc000865600>] snd_pcm_action_single+0x40/0x88
[<ffffffc0008656b8>] snd_pcm_action_nonatomic+0x70/0x90
[<ffffffc000868d28>] snd_pcm_common_ioctl1+0xb6c/0xdd8
[<ffffffc000869508>] snd_pcm_capture_ioctl1+0x200/0x334
[<ffffffc00086a084>] snd_pcm_ioctl_compat+0x648/0x95c
[<ffffffc0001ff4b4>] compat_SyS_ioctl+0xac/0xfc4
[<ffffffc000084cf0>] el0_svc_naked+0x24/0x28
---[ end trace 0dc4f99c2759c35c ]---

So this patch adds a dummy runtime for the original dummy substream
to merely avoid the NULL pointer access.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8698c26..eed15ca 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3493,6 +3493,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
 	struct snd_pcm_substream substream;
 	struct snd_pcm_hw_params *params = NULL;
+	struct snd_pcm_runtime runtime;
 	u64 fmt;
 	int ret;
 
@@ -3540,6 +3541,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		= config->channels_max;
 
 	memset(&substream, 0, sizeof(substream));
+	memset(&runtime, 0, sizeof(runtime));
+	substream.runtime = &runtime;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-- 
2.1.4
