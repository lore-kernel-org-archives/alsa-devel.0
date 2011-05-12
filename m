From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 7/9] ASoC: Silence DEBUG_STRICT_USER_COPY_CHECKS=y warning
Date: Thu, 12 May 2011 16:50:10 -0700
Message-ID: <1305244212-19183-8-git-send-email-sboyd@codeaurora.org>
References: <1305244212-19183-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305244212-19183-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Enabling DEBUG_STRICT_USER_COPY_CHECKS causes the following
warning:

In file included from arch/x86/include/asm/uaccess.h:573,
                 from include/linux/poll.h:14,
                 from include/sound/pcm.h:29,
                 from include/sound/ac97_codec.h:31,
                 from sound/soc/soc-core.c:34:
In function 'copy_from_user',
    inlined from 'codec_reg_write_file' at
    sound/soc/soc-core.c:252:
arch/x86/include/asm/uaccess_64.h:65:
warning: call to 'copy_from_user_overflow' declared with
attribute warning: copy_from_user() buffer size is not provably
correct

presumably due to buf_size being signed causing GCC to fail to
see that buf_size can't become negative.

Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d8562ce..e8a0f64 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -242,7 +242,7 @@ static ssize_t codec_reg_write_file(struct file *file,
 		const char __user *user_buf, size_t count, loff_t *ppos)
 {
 	char buf[32];
-	int buf_size;
+	size_t buf_size;
 	char *start = buf;
 	unsigned long reg, value;
 	int step = 1;
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
