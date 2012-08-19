From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 9/9] sound/ppc/snd_ps3.c: fix error return code
Date: Sun, 19 Aug 2012 09:02:59 +0200
Message-ID: <1345359780-18647-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Geoff Levand <geoff@infradead.org>
Cc: kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize ret before returning on failure, as done elsewhere in the
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
 sound/ppc/snd_ps3.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 1aa52ef..9b18b52 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -1040,6 +1040,7 @@ static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 				   GFP_KERNEL);
 	if (!the_card.null_buffer_start_vaddr) {
 		pr_info("%s: nullbuffer alloc failed\n", __func__);
+		ret = -ENOMEM;
 		goto clean_preallocate;
 	}
 	pr_debug("%s: null vaddr=%p dma=%#llx\n", __func__,
