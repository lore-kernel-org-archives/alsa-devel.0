From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 8/9] sound/pci/rme9652/hdspm.c: fix error return code
Date: Sun,  5 Apr 2015 13:38:28 +0200
Message-ID: <1428233914-4503-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

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
 sound/pci/rme9652/hdspm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index b8ac871..b12308b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6585,7 +6585,7 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 		snd_printk(KERN_ERR "HDSPM: "
 				"unable to kmalloc Mixer memory of %d Bytes\n",
 				(int)sizeof(struct hdspm_mixer));
-		return err;
+		return -ENOMEM;
 	}
 
 	hdspm->port_names_in = NULL;
