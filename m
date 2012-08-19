From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 7/9] sound/pci/sis7019.c: fix error return code
Date: Sun, 19 Aug 2012 09:02:55 +0200
Message-ID: <1345359780-18647-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
 (mail4-relais-sop.national.inria.fr [192.134.164.105])
 by alsa0.perex.cz (Postfix) with ESMTP id C76972652C6
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2012 08:33:18 +0200 (CEST)
In-Reply-To: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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
