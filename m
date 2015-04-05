From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/10] sound/atmel/abdac.c: fix error return code
Date: Sun,  5 Apr 2015 13:38:32 +0200
Message-ID: <1428233914-4503-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize retval before returning from a failed call to ioremap.

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
 sound/atmel/abdac.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index 98554f4..277ebce 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -452,6 +452,7 @@ static int __devinit atmel_abdac_probe(struct platform_device *pdev)
 	dac->regs = ioremap(regs->start, resource_size(regs));
 	if (!dac->regs) {
 		dev_dbg(&pdev->dev, "could not remap register memory\n");
+		retval = -ENOMEM;
 		goto out_free_card;
 	}
 
