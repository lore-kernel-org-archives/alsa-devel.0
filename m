From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/5] sound/isa/opti9xx/miro.c: eliminate
	possible double free
Date: Sun, 21 Oct 2012 12:52:03 +0200
Message-ID: <1350816727-1381-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1350816727-1381-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
 (mail4-relais-sop.national.inria.fr [192.134.164.105])
 by alsa0.perex.cz (Postfix) with ESMTP id EAAA42650B0
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 12:52:14 +0200 (CEST)
In-Reply-To: <1350816727-1381-1-git-send-email-Julia.Lawall@lip6.fr>
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

snd_miro_probe is a static function that is only called twice in the file
that defines it.  At each call site, its argument is freed using
snd_card_free.  Thus, there is no need for snd_miro_probe to call
snd_card_free on its argument on any of its error exit paths.

Because snd_card_free both reads the fields of its argument and kfrees its
argments, the results of the second snd_card_free should be unpredictable.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier f,free,a;
parameter list[n] ps;
type T;
expression e;
@@

f(ps,T a,...) {
  ... when any
      when != a = e
  if(...) { ... free(a); ... return ...; }
  ... when any
}

@@
identifier r.f,r.free;
expression x,a;
expression list[r.n] xs;
@@

* x = f(xs,a,...);
  if (...) { ... free(a); ... return ...; }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 sound/isa/opti9xx/miro.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 3d1afb6..4a7ff4e 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1286,7 +1286,6 @@ static int __devinit snd_miro_probe(struct snd_card *card)
 
 	error = snd_card_miro_aci_detect(card, miro);
 	if (error < 0) {
-		snd_card_free(card);
 		snd_printk(KERN_ERR "unable to detect aci chip\n");
 		return -ENODEV;
 	}
