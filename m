From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 07/10] ALSA: sb: check get_user() return value
Date: Wed, 28 Jul 2010 20:40:51 +0400
Message-ID: <1280335251-23385-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

get_user() may fail, if so return -EFAULT.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/isa/sb/emu8000_pcm.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index ccedbfe..ae6fa9f 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -433,7 +433,8 @@ static int emu8k_transfer_block(struct snd_emu8000 *emu, int offset, unsigned sh
 	while (count > 0) {
 		unsigned short sval;
 		CHECK_SCHEDULER();
-		get_user(sval, buf);
+		if (get_user(sval, buf))
+			return -EFAULT;
 		EMU8000_SMLD_WRITE(emu, sval);
 		buf++;
 		count--;
@@ -525,7 +526,8 @@ static int emu8k_pcm_copy(struct snd_pcm_substream *subs,
 	while (count-- > 0) {
 		unsigned short sval;
 		CHECK_SCHEDULER();
-		get_user(sval, buf);
+		if (get_user(sval, buf))
+			return -EFAULT;
 		EMU8000_SMLD_WRITE(emu, sval);
 		buf++;
 		if (rec->voices > 1) {
-- 
1.7.0.4
