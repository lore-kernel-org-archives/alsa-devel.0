From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/10] sound/atmel/abdac.c: fix error return code
Date: Sun, 19 Aug 2012 09:02:58 +0200
Message-ID: <1345359780-18647-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
 (mail4-relais-sop.national.inria.fr [192.134.164.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B89265CFF
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2012 08:33:19 +0200 (CEST)
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
 
