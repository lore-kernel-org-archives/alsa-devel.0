From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] ASoC: Use __printf markup to silence compiler
Date: Wed, 23 Jan 2019 20:41:30 +0100
Message-ID: <20190123194131.19406-1-malat@debian.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Silence warnings (triggered at W=1) by adding relevant __printf
attributes.

  sound/soc/soc-dapm.c:149:2: warning: function 'pop_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..92a2e7dab5fe 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -133,6 +133,7 @@ static void pop_wait(u32 pop_time)
 		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
 }
 
+__printf(3, 4)
 static void pop_dbg(struct device *dev, u32 pop_time, const char *fmt, ...)
 {
 	va_list args;
-- 
2.19.2
