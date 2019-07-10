From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: pci: lx6464es: Remove unneeded variable err
Date: Wed, 10 Jul 2019 08:00:59 +0530
Message-ID: <20190710023059.GA14204@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes below issue reported by coccicheck
sound/pci/lx6464es/lx6464es.c:256:5-8: Unneeded variable: "err". Return
"0" on line 258

We cannot change return value as its registered with snd_pcm_ops->close

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 1771a6d..583ca73 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -253,9 +253,8 @@ static int lx_pcm_open(struct snd_pcm_substream *substream)
 
 static int lx_pcm_close(struct snd_pcm_substream *substream)
 {
-	int err = 0;
 	dev_dbg(substream->pcm->card->dev, "->lx_pcm_close\n");
-	return err;
+	return 0;
 }
 
 static snd_pcm_uframes_t lx_pcm_stream_pointer(struct snd_pcm_substream
-- 
2.7.4
