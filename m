From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] ALSA: au1x00: Use resource_size
Date: Fri, 13 Jun 2014 03:32:07 +0530
Message-ID: <20140612220206.GA10257@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

Use the function resource_size, which reduces the chance of introducing
off-by-one errors in calculating the resource size.

The semantic patch that makes this change is as follows:

// <smpl>
@@
struct resource *res;
@@

- (res->end - res->start) + 1
+ resource_size(res)
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Not compile tested.
 sound/mips/au1x00.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index d10ef76..86583c7 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -649,7 +649,7 @@ static int au1000_ac97_probe(struct platform_device *pdev)
 
 	err = -EBUSY;
 	au1000->ac97_res_port = request_mem_region(r->start,
-					r->end - r->start + 1, pdev->name);
+					resource_size(r), pdev->name);
 	if (!au1000->ac97_res_port) {
 		snd_printk(KERN_ERR "ALSA AC97: can't grab AC97 port\n");
 		goto out;
-- 
1.9.1
