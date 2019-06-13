From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] ALSA: pci: echoaudio: remove variable which is a constant
Date: Thu, 13 Jun 2019 18:04:23 +0200
Message-ID: <20190613160423.17097-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Checking a variable which is always '1' has no use.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested. Found by static code analysis of similar patterns.

 sound/pci/echoaudio/echoaudio_dsp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index b181752b8481..50d4a87a6bb3 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -1058,7 +1058,6 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 {
 	int i;
 	u32 channel_mask;
-	char is_cyclic;
 
 	dev_dbg(chip->card->dev,
 		"allocate_pipes: ch=%d int=%d\n", pipe_index, interleave);
@@ -1066,8 +1065,6 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 	if (chip->bad_board)
 		return -EIO;
 
-	is_cyclic = 1;	/* This driver uses cyclic buffers only */
-
 	for (channel_mask = i = 0; i < interleave; i++)
 		channel_mask |= 1 << (pipe_index + i);
 	if (chip->pipe_alloc_mask & channel_mask) {
@@ -1078,8 +1075,8 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 
 	chip->comm_page->position[pipe_index] = 0;
 	chip->pipe_alloc_mask |= channel_mask;
-	if (is_cyclic)
-		chip->pipe_cyclic_mask |= channel_mask;
+	/* This driver uses cyclic buffers only */
+	chip->pipe_cyclic_mask |= channel_mask;
 	pipe->index = pipe_index;
 	pipe->interleave = interleave;
 	pipe->state = PIPE_STATE_STOPPED;
-- 
2.20.1
