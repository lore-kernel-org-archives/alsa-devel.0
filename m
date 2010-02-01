From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] trivial: sound seq ioctl dbg: print hexadecimal value padded with 0s
Date: Mon,  1 Feb 2010 16:17:01 -0200
Message-ID: <1265048222-8050-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Instead of padding with blanks and printing "number=0x a", print
"number=0x0a".

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 sound/core/seq/seq_clientmgr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 8ca2be3..48eca9f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2190,7 +2190,7 @@ static int snd_seq_do_ioctl(struct snd_seq_client *client, unsigned int cmd,
 		if (p->cmd == cmd)
 			return p->func(client, arg);
 	}
-	snd_printd("seq unknown ioctl() 0x%x (type='%c', number=0x%2x)\n",
+	snd_printd("seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
 	return -ENOTTY;
 }
-- 
1.6.6.1
