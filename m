From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Thu, 8 Mar 2018 12:06:53 -0800
Message-ID: <20180308200653.GA47801@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If a codec is not attached to the sound soc, a NULL deref is possible as a
regular user in /sys.

[ 2278.331878] DSS: context saved
[ 2278.820343] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[ 2278.828948] pgd = c36040a2
[ 2278.831787] [00000004] *pgd=876c4831, *pte=00000000, *ppte=00000000
[ 2278.838439] Internal error: Oops: 17 [#1] ARM
[ 2278.843017] Modules linked in:
[ 2278.846221] CPU: 0 PID: 16337 Comm: grep Tainted: G        W 4.16.0-rc4-next-20180308 #71
[ 2278.855529] Hardware name: Nokia RX-51 board
[ 2278.860015] PC is at soc_codec_reg_show+0x8/0x19c
[ 2278.864959] LR is at codec_reg_show+0x28/0x30

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
No idea if this is the _right_ fix, but it should stop the crash from
unprivileged userspace.
---
 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..78ad165ad424 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
 	size_t total = 0;
 	loff_t p = 0;
 
+	if (!codec || !codec->driver)
+		return 0;
+
 	wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
 	regsize = codec->driver->reg_word_size * 2;
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
