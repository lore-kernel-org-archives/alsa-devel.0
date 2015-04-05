From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 7/9] sound/pci/sis7019.c: fix error return code
Date: Sun,  5 Apr 2015 13:38:29 +0200
Message-ID: <1428233914-4503-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize rc before returning on failure, as done elsewhere in the
function.

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
 sound/pci/sis7019.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 535efe2..51e4340 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1377,8 +1377,9 @@ static int __devinit sis_chip_create(struct snd_card *card,
 	if (rc)
 		goto error_out_cleanup;
 
-	if (request_irq(pci->irq, sis_interrupt, IRQF_SHARED, KBUILD_MODNAME,
-			sis)) {
+	rc = request_irq(pci->irq, sis_interrupt, IRQF_SHARED, KBUILD_MODNAME,
+			 sis);
+	if (rc) {
 		dev_err(&pci->dev, "unable to allocate irq %d\n", sis->irq);
 		goto error_out_cleanup;
 	}
