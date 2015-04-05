From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/9] sound/atmel/ac97c.c: fix error return code
Date: Sun,  5 Apr 2015 13:38:31 +0200
Message-ID: <1428233914-4503-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

In the first case, the second test of whether retval is negative is
redundant.  It is dropped and the previous and subsequent tests are
combined.

In the second case, add an initialization of retval on failure of ioremap.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}

// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/atmel/ac97c.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 3c8d3ba..9052aff 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -278,14 +278,9 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 	if (retval < 0)
 		return retval;
 	/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-	if (cpu_is_at32ap7000()) {
-		if (retval < 0)
-			return retval;
-		/* snd_pcm_lib_malloc_pages returns 1 if buffer is changed. */
-		if (retval == 1)
-			if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
-				dw_dma_cyclic_free(chip->dma.rx_chan);
-	}
+	if (cpu_is_at32ap7000() && retval == 1)
+		if (test_and_clear_bit(DMA_RX_READY, &chip->flags))
+			dw_dma_cyclic_free(chip->dma.rx_chan);
 
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
@@ -980,6 +975,7 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 
 	if (!chip->regs) {
 		dev_dbg(&pdev->dev, "could not remap register memory\n");
+		retval = -ENOMEM;
 		goto err_ioremap;
 	}
 

